// HOOK N' QUEUE · "Cartero" de avisos por mail (Supabase Edge Function: notificar)
// Secretos necesarios (Edge Functions > Secrets): RESEND_API_KEY, HNQ_SECRET, FROM_EMAIL, SITE_URL
// Versión equilibrada: mantiene el estilo oscuro de Hook n' Queue, sin botones grandes ni emojis en el asunto.

const esc = (t) => String(t ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));

function mailHtml({ lines, quote, linkText, site, unsub }) {
  return `<!DOCTYPE html><html lang="es"><body style="margin:0;padding:0;background:#0D0F0F">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#0D0F0F;padding:24px 12px">
<tr><td align="center">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:520px;background:#141817;border:1px solid #242A29;border-radius:14px;font-family:Arial,Helvetica,sans-serif">
<tr><td style="padding:20px 24px 4px;font-weight:700;letter-spacing:1px;font-size:14px;color:#E4EAE8">HOOK N' <span style="color:#3DBF8E">QUEUE</span></td></tr>
<tr><td style="padding:10px 24px 0;font-size:15px;line-height:1.6;color:#D7DFDC">${lines.map((l) => `<p style="margin:0 0 12px">${l}</p>`).join("")}</td></tr>
${quote ? `<tr><td style="padding:0 24px 4px"><div style="border-left:3px solid #3DBF8E;padding:6px 12px;font-size:15px;line-height:1.5;color:#E4EAE8">${quote}</div></td></tr>` : ""}
<tr><td style="padding:12px 24px 22px;font-size:15px"><a href="${site}" style="color:#3DBF8E;font-weight:700;text-decoration:none">${linkText} &rarr;</a></td></tr>
</table>
<p style="max-width:520px;font-family:Arial,Helvetica,sans-serif;font-size:12px;line-height:1.5;color:#86918E;margin:14px auto 0;text-align:center">
Te llegó porque tenés los avisos activados en Hook n' Queue. <a href="${unsub}" style="color:#86918E">No quiero más mails</a></p>
</td></tr></table></body></html>`;
}

Deno.serve(async (req) => {
  if (req.headers.get("x-hnq-secret") !== Deno.env.get("HNQ_SECRET")) return new Response("No autorizado", { status: 401 });
  const p = await req.json();
  const site = Deno.env.get("SITE_URL");
  const unsub = `${site}/baja.html?t=${encodeURIComponent(p.token)}`;
  const from = esc(p.from_nick), to = esc(p.to_nick), offer = esc(p.offer_title);
  const isChat = p.kind === "new_chat";

  const subject = isChat ? `${p.from_nick} quiere jugar con vos` : `${p.from_nick} te escribió`;
  const hasMsg = String(p.preview ?? "").trim() !== "";
  const html = mailHtml(isChat
    ? (hasMsg
        ? { lines: [`Hola ${to},`, `<b>${from}</b> vio tu oferta "${offer}" y te escribió:`], quote: esc(p.preview), linkText: "Responder", site, unsub }
        : { lines: [`Hola ${to},`, `<b>${from}</b> vio tu oferta "${offer}" y te abrió un chat para jugar.`], linkText: "Ver el chat", site, unsub })
    : { lines: [`Hola ${to},`, `<b>${from}</b> te mandó un mensaje por tu oferta "${offer}":`], quote: esc(p.preview), linkText: "Responder", site, unsub });
  const text = (isChat
      ? `Hola ${p.to_nick},\n\n${p.from_nick} vio tu oferta "${p.offer_title}"${hasMsg ? ` y te escribió:\n\n"${p.preview}"\n\nResponder` : ` y te abrió un chat para jugar.\n\nVer el chat`}: ${site}`
      : `Hola ${p.to_nick},\n\n${p.from_nick} te mandó un mensaje por tu oferta "${p.offer_title}":\n\n"${p.preview}"\n\nResponder: ${site}`)
    + `\n\n—\nNo quiero más mails: ${unsub}`;

  const r = await fetch("https://api.resend.com/emails", {
    method: "POST",
    headers: { Authorization: `Bearer ${Deno.env.get("RESEND_API_KEY")}`, "Content-Type": "application/json" },
    body: JSON.stringify({
      from: Deno.env.get("FROM_EMAIL"), to: [p.to_email], subject, html, text,
      headers: { "List-Unsubscribe": `<${unsub}>` },
    }),
  });
  return new Response(await r.text(), { status: r.ok ? 200 : 500 });
});
