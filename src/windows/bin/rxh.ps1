# rxh: the reflex command history of the repository or workspace you are in
# (reflex history), from any folder inside it.
#
#   rxh                  the latest 20 runs
#   rxh --last 50        more
#   rxh --failed         failed runs only
#   rxh --grep nx        runs whose command or output mention a word
#   rxh --show 1         the latest run in full (2 is the one before)
#   rxh --top            the most repeated commands, to promote

. (Join-Path $PSScriptRoot 'reflex-lib.ps1')

$reflex = Resolve-Reflex

if (-not $reflex) {
    [Console]::Error.WriteLine('rxh: no reflex history serves this folder')
    exit 2
}

if ($reflex.Root) { $env:REFLEX_ROOT = $reflex.Root }
& node $reflex.Cli history @args
exit $LASTEXITCODE
