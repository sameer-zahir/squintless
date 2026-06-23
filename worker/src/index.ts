// Squintless short-URL redirector (Cloudflare Worker).
//   /sq , /ps1  -> install.ps1   (Windows:      irm <url> | iex)
//   /sh         -> install.sh     (macOS/Linux:  curl -fsSL <url> | bash)
//   /           -> the repo
// 302s (not 301) so the target can later move to a pinned release tag without a redeploy.

const RAW = "https://raw.githubusercontent.com/sameer-zahir/squintless/main";
const REPO = "https://github.com/sameer-zahir/squintless";

export default {
  async fetch(request: Request): Promise<Response> {
    const { pathname } = new URL(request.url);
    const path = pathname.replace(/\/+$/, "") || "/";
    switch (path) {
      case "/sq":
      case "/ps1":
        return Response.redirect(`${RAW}/install.ps1`, 302);
      case "/sh":
        return Response.redirect(`${RAW}/install.sh`, 302);
      case "":
      case "/":
        return Response.redirect(REPO, 302);
      default:
        return new Response("Squintless. Try /sq (Windows) or /sh (macOS/Linux).\n", {
          status: 404,
          headers: { "content-type": "text/plain; charset=utf-8" },
        });
    }
  },
};
