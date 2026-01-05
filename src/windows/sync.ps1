# ---------------------
# Sync Custom PowerShell Aliases
# ---------------------

# Define all aliases as functions
$aliases = @'
# Basic
function c { cls }
function l { Get-ChildItem -Force }

# Docker
function docup { docker compose up }
function docupd { docker compose up -d }

# Node
function nap { node app.js }
function tap { ts-node app.ts }

# NPM
function ni { npm i }
function nil { npm i --legacy-peer-deps }
function nrn {
    if (Test-Path "./node_modules") {
        Remove-Item -Recurse -Force "./node_modules"
        Write-Host "Removed ./node_modules directory"
    }
    if (Test-Path "./package-lock.json") {
        Remove-Item -Force "./package-lock.json"
        Write-Host "Removed ./package-lock.json file"
    }
}

# NPM General Scripts
function nrd { npm run dev }
function nrs { npm run start }

# PNPM
function pi { pnpm i }
function piw { pnpm i --workspace-root }
function prn {
    if (Test-Path "./node_modules") {
        Remove-Item -Recurse -Force "./node_modules"
        Write-Host "Removed ./node_modules directory"
    }
    if (Test-Path "./pnpm-lock.yaml") {
        Remove-Item -Force "./pnpm-lock.yaml"
        Write-Host "Removed ./pnpm-lock.yaml file"
    }
}

# PNPM General Scripts
function prd { pnpm dev }
function prs { pnpm start }
function prt { pnpm test }
function prb { pnpm build }
function up { pnpm self-update }

# Composer
function ci { composer install }
function cu { composer update }
function ct { composer test }
function crv {
    if (Test-Path "./vendor") {
        Remove-Item -Recurse -Force "./vendor"
        Write-Host "Removed ./vendor directory"
    }
    if (Test-Path "./composer.lock") {
        Remove-Item -Force "./composer.lock"
        Write-Host "Removed ./composer.lock file"
    }
}

# Angular
function ngs { ng serve --host 0.0.0.0 --port 4200 --disable-host-check --live-reload=false }
function ngss { ng serve --host 0.0.0.0 --port 4444 --disable-host-check --live-reload=false }

# Laravel
function pak { php artisan key:generate }
function pas { php artisan serve --port=8000 }
function pass { php artisan serve --port=9000 }
function pam { php artisan migrate }
function pamf { php artisan migrate:fresh }
function pamfs { php artisan migrate:fresh --seed }
function pamr { php artisan migrate:rollback }
function paop { php artisan optimize }
function paopc { php artisan optimize:clear }
function pat { php artisan test }

# PHP
function phps { php -S 127.0.0.1:8000 index.php }
function phpfix { php vendor/bin/php-cs-fixer fix ./ }
function phpstan { ./vendor/bin/phpstan analyse --memory-limit=2G }
function pint { ./vendor/bin/pint }

# Utility
function kp {
    param([int]$port)
    $process = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess -Unique
    if ($process) {
        Stop-Process -Id $process -Force
        Write-Host "Killed process on port $port"
    } else {
        Write-Host "No process found on port $port"
    }
}

# Claude
function cc { claude }
function ccd { claude --dangerously-skip-permissions }
'@

# PowerShell profile path
$profilePath = $PROFILE

# Check if profile exists, create if not
if (-not (Test-Path $profilePath)) {
    New-Item -Path $profilePath -ItemType File -Force | Out-Null
    Write-Host "Created new PowerShell profile at $profilePath"
}

# Read current profile content
$profileContent = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue
if ($null -eq $profileContent) {
    $profileContent = ""
}

# Create backup
$backupPath = "$profilePath.bak"
Copy-Item $profilePath $backupPath -Force
Write-Host "Backup created at $backupPath"

# Remove existing region if present
$regionPattern = '(?s)#region dev aliases.*?#endregion'
$profileContent = $profileContent -replace $regionPattern, ''

# Trim extra newlines
$profileContent = $profileContent.TrimEnd()

# Add new region with aliases
$newRegion = @"

#region dev aliases
$aliases
#endregion
"@

$profileContent = $profileContent + $newRegion

# Write back to profile
Set-Content -Path $profilePath -Value $profileContent -Force

# Remove backup
Remove-Item $backupPath -Force

Write-Host "Aliases synced to PowerShell profile successfully!"
Write-Host "Run '. `$PROFILE' or restart PowerShell to apply changes."
