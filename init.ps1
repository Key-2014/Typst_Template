<#
.SYNOPSIS
Initializes the parent repository with the Typst environment settings.

.DESCRIPTION
This script should be run after adding Typst_Template as a submodule.
It automatically copies the necessary GitHub Actions workflow, VS Code snippets,
and sets up the .gitignore file in the parent repository.
#>

$TemplateRoot = $PSScriptRoot
$DestRoot = (Get-Item -Path ".\").FullName

# Make sure we are not running this inside the template itself
if ($TemplateRoot -eq $DestRoot) {
    Write-Host "Please run this script from the root of your parent repository." -ForegroundColor Red
    Write-Host "Example: powershell -ExecutionPolicy Bypass -File .\lib\Typst_Template\init.ps1" -ForegroundColor Yellow
    exit
}

Write-Host "Setting up Typst Environment in: $DestRoot" -ForegroundColor Cyan

# 1. Copy GitHub Actions Workflow
$GhDir = Join-Path $DestRoot ".github\workflows"
if (-not (Test-Path $GhDir)) {
    New-Item -ItemType Directory -Path $GhDir -Force | Out-Null
}
Copy-Item (Join-Path $TemplateRoot ".github\workflows\compile-typst.yml") -Destination $GhDir -Force
Write-Host "[OK] Copied GitHub Actions workflow (compile-typst.yml)." -ForegroundColor Green

# 2. Copy VS Code Snippets
$VsCodeDir = Join-Path $DestRoot ".vscode"
if (-not (Test-Path $VsCodeDir)) {
    New-Item -ItemType Directory -Path $VsCodeDir -Force | Out-Null
}
Copy-Item (Join-Path $TemplateRoot ".vscode\typst.code-snippets") -Destination $VsCodeDir -Force
Write-Host "[OK] Copied VS Code snippets (typst.code-snippets)." -ForegroundColor Green

# 3. Setup .gitignore
$SourceGitignore = Join-Path $TemplateRoot ".gitignore"
$DestGitignore = Join-Path $DestRoot ".gitignore"

if (-not (Test-Path $DestGitignore)) {
    Copy-Item $SourceGitignore -Destination $DestGitignore
    Write-Host "[OK] Created .gitignore with PDF exclusion rules." -ForegroundColor Green
} else {
    $Content = Get-Content $DestGitignore -Raw
    if ($Content -notmatch "\*\.pdf") {
        Add-Content -Path $DestGitignore -Value "`n# Typst PDF exclusions`n*.pdf"
        Write-Host "[OK] Appended PDF exclusion rules to existing .gitignore." -ForegroundColor Green
    } else {
        Write-Host "[OK] .gitignore already contains PDF exclusion rules. Skipped." -ForegroundColor DarkGreen
    }
}

Write-Host "`nSetup complete! Your repository is now fully configured." -ForegroundColor Cyan
