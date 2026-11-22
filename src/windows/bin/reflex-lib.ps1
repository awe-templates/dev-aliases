# Shared by prx and rxh: finds the reflex CLI that serves the current folder.
# The Windows port of src/macos/bin/reflex-lib.sh.
#
# Resolve-Reflex returns $null when no reflex serves this folder, else an
# object with
#   Cli   the reflex.mts to run with node
#   Root  the folder to pass as REFLEX_ROOT, or empty for a repository
#
# Two places are recognized, nearest first:
#   1. a repository whose package.json has a "reflex": "node <path>" script;
#   2. a parent folder whose .claude/settings.json wires the reflex hooks (a
#      workspace of several repositories), served by the shared CLI below.
#
# REFLEX_CLI overrides the shared CLI's location.

$script:ReflexSharedCli = if ($env:REFLEX_CLI) {
    $env:REFLEX_CLI
} else {
    Join-Path $HOME 'Desktop\gh\nn\ngeen-platform\tools\external-plugins\reflex-plugin\cli\reflex.mts'
}

function Resolve-Reflex {
    # The superproject when called inside a submodule, else the repository root.
    $root = git rev-parse --show-superproject-working-tree 2>$null
    if (-not $root) { $root = git rev-parse --show-toplevel 2>$null }

    if ($root -and (Test-Path (Join-Path $root 'package.json'))) {
        $package = Get-Content (Join-Path $root 'package.json') -Raw
        if ($package -match '"reflex"\s*:\s*"node ([^"]+)"') {
            $entry = Join-Path $root $Matches[1]
            if (Test-Path $entry) {
                return [pscustomobject]@{ Cli = $entry; Root = '' }
            }
        }
    }

    if (-not (Test-Path $script:ReflexSharedCli)) { return $null }

    $dir = (Get-Location).ProviderPath
    while ($dir) {
        $settings = Join-Path $dir '.claude\settings.json'
        if ((Test-Path $settings) -and (Select-String -Path $settings -Pattern 'reflex.mts' -SimpleMatch -Quiet)) {
            return [pscustomobject]@{ Cli = $script:ReflexSharedCli; Root = $dir }
        }
        $dir = Split-Path $dir -Parent
    }

    return $null
}

# reflex run starts the command with "$SHELL -c". Windows sets no SHELL, so
# point it at Git Bash when it is installed; the commands are bash commands.
function Get-ReflexShell {
    if ($env:SHELL) { return $env:SHELL }

    $candidates = @(
        (Join-Path $env:ProgramFiles 'Git\bin\bash.exe'),
        (Get-Command bash.exe -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty Source)
    )

    foreach ($candidate in $candidates) {
        if ($candidate -and (Test-Path $candidate)) { return $candidate }
    }

    return $null
}
