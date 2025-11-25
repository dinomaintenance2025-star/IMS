# IMS — Landing page for Netlify

This repository contains a static landing page for the IMS project that can be deployed on Netlify.

Quick notes:
- The project contains PHP files (`register.php`, `db.php`). Netlify serves static sites and does not execute PHP.
- Use this landing page to present the project, link to the GitHub repo, or link to a PHP-capable host for the app.

Deploy steps (Netlify):

1. Create a new site on Netlify and link it to this GitHub repository.
2. For the build settings use the default (no build command) and set the publish directory to the repository root (`.`).
3. Deploy the site — the `index.html` will be used as the landing page.

Local test:

```powershell
cd 'C:\Users\Kamote\Desktop\databasee'
php -S localhost:8000
# open http://localhost:8000 in your browser
```

Backend & secrets
- This repo contains `register.php` and `db.php`. `db.php` contains live DB credentials in the original project and MUST NOT be committed to public repos. The repository now includes a `.gitignore` that prevents `db.php` from being committed.
- Netlify serves static files only — it will not execute PHP. To run the PHP app you have two options:
	- Host the PHP app on a PHP-capable host (shared hosting, Render, DigitalOcean App Platform, a VPS). Keep `db.php` on the server and do not push credentials to GitHub.
	- Use a separate small PHP host for the app and link the hosted app from this Netlify landing page.

Security checklist before deploying the PHP app
- Replace placeholder DB credentials in `db.php` with environment-specific values on the server (do not commit real credentials).
- Use `password_hash`/`password_verify` as the app already does. Consider adding input validation and prepared statements (`$conn->prepare(...)`) to prevent SQL injection.

Netlify-specific tips
- If you want to show the live Netlify URL on the landing page, update `index.html` after deploy with the Netlify site URL or set a custom domain via the Netlify UI.
- To automatically build/publish from the repo root, we added `netlify.toml` with `publish = "."`.

If you want help provisioning a PHP-capable host and wiring it to this landing page (or migrating the small PHP app to a serverless alternative), tell me which provider you prefer and I will prepare step-by-step instructions.
