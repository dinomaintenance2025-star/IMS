**Project Overview**
- **Stack:** PHP (single-file PHP+HTML), MySQL via `mysqli`.
- **Layout:** All app files live at repository root; DB connection is centralized in `db.php` and included where needed (example: `register.txt` uses `<?php include 'db.php'; ?>`).

**Key Files / Patterns**
- **`db.php`:** Creates a `new mysqli($servername, $username, $password, $dbname)` and exposes `$conn` to included files. Credentials are stored inline (look for `your_db_password`).
- **`register.txt`:** Contains mixed HTML + PHP handling a registration form. It posts to the same file, uses `password_hash(...)` for passwords, and executes SQL via string interpolation: `INSERT INTO users (username, password) VALUES ('$username', '$password')`.

**Important Project-Specific Notes for AI Edits**
- **File inclusion convention:** Use `include 'db.php';` to access the `$conn` object—follow this pattern rather than introducing a new DI mechanism.
- **Preserve single-file PHP+HTML style:** Changes should keep the same mixed-template approach unless explicitly asked to refactor the app structure.
- **Credential handling is explicit:** `db.php` contains host/user/password strings. Do not commit real secrets; if you need to run code locally, replace the placeholder `your_db_password` with a local secret stored outside the repo.
- **File extensions matter:** `register.txt` contains PHP code and should be treated as if it were `register.php` when testing or deploying; CI or local servers will need `.php` extension to execute.

**SQL and Security Patterns**
- **Observed pattern:** SQL queries are built by interpolating user input into strings (e.g., `'$username'`). When modifying or adding DB code, prefer prepared statements using `$conn->prepare(...)` and bind parameters to avoid SQL injection.
- **Password handling:** The project uses `password_hash(...)` for storing passwords. Continue using `password_hash` for creation and `password_verify` for login checks.

**Developer Workflows / Commands**
- **Quick local test (PowerShell):** Run a built-in PHP server from the project root to test pages:

```powershell
cd 'c:\Users\Kamote\Desktop\databasee'
php -S localhost:8000
```

- **Database:** The project expects a MySQL-compatible DB reachable by `db.php`. Current host is `sql107.infinityfree.com`—tests may require a local MySQL instance and updated `db.php` credentials.

**Conventions & Style**
- **No framework:** Code is plain PHP (no Composer, no frameworks). Keep changes minimal and consistent with current style (procedural/inline templates).
- **Error handling:** Errors are echoed directly from `$conn->error` in the example; when adding new DB operations, return the DB error string in the same form unless asked to introduce structured error handling.

**Integration Points**
- **Remote DB host:** `db.php` connects to an external host. Changing schema or connection behavior can impact remote hosting. Check `dbname` (`ezeeepeezyyy_6969_inventory`) before migrations.
- **HTML forms:** Forms post to their own file (no router). Keep `method="POST" action=""` pattern unless adding site-wide routing.

**Examples to Reference**
- Use `db.php` as the canonical DB connection snippet.
- Reference `register.txt` for form handling, use of `password_hash`, and current SQL insertion style.

**When to Ask the Maintainer**
- If you need to add new packages, change file layout, or modify how credentials are stored — ask before committing.
- If you intend to rename `register.txt` to `register.php` (recommended) confirm with the maintainer.

**Local Testing Checklist (for PRs)**
- Start PHP server: `php -S localhost:8000` in project root.
- Ensure `db.php` points to a reachable test DB (do not commit real credentials).
- Verify registration flow: open `/register.php` (or `/register.txt` if served as PHP) and confirm account creation with `password_hash` + DB insert.

If any of this is unclear or you'd like instructions to be expanded (routing, migrations, or automated tests), tell me which area to expand and I'll iterate.
