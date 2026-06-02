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

# 2. Copy VS Code Snippets & Settings
$VsCodeDir = Join-Path $DestRoot ".vscode"
if (-not (Test-Path $VsCodeDir)) {
    New-Item -ItemType Directory -Path $VsCodeDir -Force | Out-Null
}
Copy-Item (Join-Path $TemplateRoot ".vscode\typst.code-snippets") -Destination $VsCodeDir -Force
Write-Host "[OK] Copied VS Code snippets (typst.code-snippets)." -ForegroundColor Green

$SourceSettings = Join-Path $TemplateRoot ".vscode\settings.json"
$DestSettings = Join-Path $VsCodeDir "settings.json"

if (Test-Path $DestSettings) {
    try {
        $JsonContent = Get-Content $DestSettings -Raw | ConvertFrom-Json
        
        # Ensure "[typst]" section exists and is a PSCustomObject
        if ($null -eq $JsonContent) {
            $JsonContent = New-Object PSObject
        }
        
        if ($null -eq $JsonContent.'[typst]' -or $JsonContent.'[typst]' -isnot [System.Management.Automation.PSCustomObject]) {
            # If not present or not an object, create/overwrite it
            $JsonContent | Add-Member -MemberType NoteProperty -Name '[typst]' -Value (New-Object PSObject) -Force
        }
        
        $Typst = $JsonContent.'[typst]'
        
        # Ensure "editor.quickSuggestions" exists and is a PSCustomObject
        if ($null -eq $Typst.'editor.quickSuggestions' -or $Typst.'editor.quickSuggestions' -isnot [System.Management.Automation.PSCustomObject]) {
            if ($null -ne $Typst.'editor.quickSuggestions') {
                # Remove if it exists but is not an object (e.g. a boolean) to allow nested properties
                $Typst.psobject.Properties.Remove('editor.quickSuggestions')
            }
            $Typst | Add-Member -MemberType NoteProperty -Name 'editor.quickSuggestions' -Value (New-Object PSObject) -Force
        }
        
        $QuickSuggestions = $Typst.'editor.quickSuggestions'
        
        # Set strings to true
        if ($null -eq $QuickSuggestions.'strings') {
            $QuickSuggestions | Add-Member -MemberType NoteProperty -Name 'strings' -Value $true -Force
        } else {
            $QuickSuggestions.'strings' = $true
        }
        
        # Write merged JSON back to destination settings file
        $MergedJson = ConvertTo-Json $JsonContent -Depth 100
        Set-Content -Path $DestSettings -Value $MergedJson -Encoding utf8
        Write-Host "[OK] Merged VS Code settings ([typst] editor.quickSuggestions.strings = true) into existing settings.json." -ForegroundColor Green
    } catch {
        Write-Host "[Warning] Failed to merge VS Code settings into existing settings.json. Error: $_" -ForegroundColor Yellow
        Write-Host "Please manually add the following to your settings.json:" -ForegroundColor Yellow
        Write-Host "{`n  `"[typst]`": {`n    `"editor.quickSuggestions`": {`n      `"strings`": true`n    }`n  }`n}" -ForegroundColor Yellow
    }
} else {
    Copy-Item $SourceSettings -Destination $DestSettings -Force
    Write-Host "[OK] Copied VS Code settings (settings.json)." -ForegroundColor Green
}

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
