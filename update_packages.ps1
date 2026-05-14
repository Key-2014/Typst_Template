# update_packages.ps1
# Fetch latest packages from the Typst package registry and update versions in .typ files.

Write-Host "Fetching latest Typst packages from the registry..." -ForegroundColor Cyan
$data = Invoke-RestMethod -Uri "https://packages.typst.org/preview/index.json"

# Find the latest version for each package
$latestVersions = @{}
foreach ($pkg in $data) {
    $name = $pkg.name
    $verString = $pkg.version
    try {
        $ver = [System.Version]$verString
        if (-not $latestVersions.ContainsKey($name) -or $latestVersions[$name].Version -lt $ver) {
            $latestVersions[$name] = @{ Version = $ver; String = $verString }
        }
    } catch {
        # Fallback if version string is not standard x.y.z
        if (-not $latestVersions.ContainsKey($name)) {
            $latestVersions[$name] = @{ Version = [System.Version]"0.0.0"; String = $verString }
        }
    }
}

$files = Get-ChildItem -Filter "*.typ" -Recurse
$updatedCount = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    # Regex to match: @preview/package-name:1.2.3
    $pattern = '(@preview/([a-zA-Z0-9_-]+)):([0-9\.]+)'
    $matches = [regex]::Matches($content, $pattern)
    
    $fileUpdated = $false
    foreach ($m in $matches) {
        $fullMatch = $m.Groups[0].Value
        $pkgPrefix = $m.Groups[1].Value
        $pkgName   = $m.Groups[2].Value
        $currentVer = $m.Groups[3].Value
        
        if ($latestVersions.ContainsKey($pkgName)) {
            $latestVer = $latestVersions[$pkgName].String
            if ($currentVer -ne $latestVer) {
                Write-Host "Updating $pkgName in $($file.Name): $currentVer -> $latestVer" -ForegroundColor Green
                $content = $content.Replace($fullMatch, "${pkgPrefix}:${latestVer}")
                $fileUpdated = $true
            }
        }
    }
    
    if ($fileUpdated) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        $updatedCount++
    }
}

if ($updatedCount -eq 0) {
    Write-Host "All packages are already up to date!" -ForegroundColor Cyan
} else {
    Write-Host "Successfully updated packages in $updatedCount file(s)." -ForegroundColor Green
}
