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
