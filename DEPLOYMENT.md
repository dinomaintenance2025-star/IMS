# Secure Deployment Guide

This guide explains how to deploy the IMS app and landing page securely. The repo contains a static landing page (`index.html`) suitable for Netlify and a small PHP app (`register.php`, `db.php`) which must be hosted on a PHP-capable server.

1) Protect secrets
- Do NOT commit `db.php` with real credentials. Use the included `db.example.php` as a template.
- On your server or platform, provide DB credentials through environment variables (`DB_HOST`, `DB_USER`, `DB_PASS`, `DB_NAME`) and copy `db.example.php` to `db.php` or configure your `db.php` to read env variables.

2) Recommended hosts
- Render (managed): supports PHP via Docker or static services + separate PHP service. Good docs and env var support.
- DigitalOcean App Platform: good support for PHP and environment variables.
- Traditional shared hosting or VPS: place `db.php` on server, ensure file permissions prevent world-readable secrets.

3) Database security
- Use a managed MySQL instance where possible.
- Restrict DB user to only the required database and minimal privileges (no SUPER).
- Restrict DB network access to the IPs of your app host only; do not expose DB to the public internet.
- Use TLS for DB connections if supported by your provider.

4) HTTPS and domain
- Always serve the site over HTTPS. Netlify provides automatic HTTPS for static sites. For your PHP app, configure HTTPS via your host or use a load balancer / reverse proxy with TLS.

5) Application hardening
- Use `password_hash` / `password_verify` (already used).
- Use prepared statements for DB queries (we updated `register.php`).
- Validate and sanitize inputs server-side.
- Set secure session cookies: `session_set_cookie_params(['secure' => true, 'httponly' => true, 'samesite' => 'Lax']);`

6) Operational
- Monitor logs and set up simple alerting (errors, repeated failed logins).
- Back up the database regularly.
- Apply minimal OS and app updates on your host.

7) Deploy flow (example: Render)
- Create a new service on Render for the PHP app (or a Docker service). Connect the repo or push a deployment artifact.
- Add environment variables on the Render dashboard: `DB_HOST`, `DB_USER`, `DB_PASS`, `DB_NAME`.
- Ensure `db.php` on the instance reads env variables or use `db.example.php` as the basis and do not push credentials.
- Use the Netlify site for the static landing page (link to your PHP host for dynamic routes) or configure domain routing.

If you tell me which provider you prefer (Render, DigitalOcean, shared host, VPS), I will produce step-by-step instructions and any small config files required (Dockerfile, Render/DO spec) and help prepare the repo for deployment.
