<#
.SYNOPSIS
  Helper script to add, commit and push the current project to a GitHub repo over HTTPS.

.DESCRIPTION
  This script is intended to be run locally on your machine. It will:
    - verify `git` is available
    - ensure the current folder is a git repo (initialize if needed)
    - add changed files
    - commit with a default message if there are staged changes
    - add or set the remote `origin` to the provided HTTPS URL
    - push the `main` branch to `origin`

.PARAMETER RemoteUrl
  (Optional) HTTPS remote URL for your `IMS` repo, e.g. https://github.com/your-username/IMS.git

.EXAMPLE
  .\push_to_IMS.ps1 -RemoteUrl 'https://github.com/your-username/IMS.git'

  Runs the script and pushes to the specified remote.
#>

param(
    [string]$RemoteUrl
)

function Fail([string]$msg){
    Write-Error $msg
    exit 1
}

Write-Host "Running push_to_IMS.ps1 from: $PWD"

# Check git
try {
    git --version > $null 2>&1
} catch {
    Fail "git is not installed or not on PATH. Install Git and re-run this script."
}

# Ensure inside repo or init
$isRepo = $false
try {
    $isRepo = (git rev-parse --is-inside-work-tree) -eq 'true'
} catch {
    $isRepo = $false
}

if (-not $isRepo) {
    Write-Host "Not a git repo — initializing repository..."
    git init || Fail "git init failed"
}

# Stage files (only relevant project files)
Write-Host "Staging files..."
git add .github/copilot-instructions.md register.txt 2>$null
git add . 2>$null

# Commit if there are changes
$status = git status --porcelain
if ($status) {
    $msg = "chore: add copilot instructions"
    git commit -m "$msg" || Fail "git commit failed"
} else {
    Write-Host "No changes to commit."
}

# Configure remote
if (-not $RemoteUrl) {
    $RemoteUrl = Read-Host "Enter HTTPS remote URL for your IMS repo (e.g. https://github.com/you/IMS.git)"
}
if (-not $RemoteUrl) { Fail "Remote URL is required." }

# If origin exists, set-url; otherwise add
try {
    $existing = git remote get-url origin 2>$null
    if ($existing) {
        Write-Host "Updating existing remote 'origin' to $RemoteUrl"
        git remote set-url origin $RemoteUrl || Fail "git remote set-url failed"
    }
} catch {
    Write-Host "Adding remote 'origin' -> $RemoteUrl"
    git remote add origin $RemoteUrl || Fail "git remote add failed"
}

# Ensure branch main exists and push
try {
    git branch --show-current | Out-Null
} catch {
    # no-op
}

try {
    git branch -M main 2>$null
} catch {
    # ignore
}

Write-Host "Pushing to origin main..."
git push -u origin main || Fail "git push failed — check credentials and remote URL"

Write-Host "Push completed successfully."
