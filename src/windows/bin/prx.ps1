# prx: run a shell command through the reflex proxy, so the command and its
# output land in the reflex history (.reflex/command-executions.json) of the
# repository or workspace you are in. Where no reflex serves the folder, it
# simply runs the command, so prx is safe to use anywhere.
#
#   prx 'git status --short | wc -l'   quote it when it has pipes, && or $
#   prx git log --oneline -3
#
# The command runs in Git Bash (reflex run needs a POSIX shell). prx.cmd
# beside this file lets cmd.exe and scripts call it too.

if ($args.Count -eq 0) {
    [Console]::Error.WriteLine('usage: prx <command>   (quote it when it has pipes, && or $)')
    exit 2
}

$command = $args -join ' '

. (Join-Path $PSScriptRoot 'reflex-lib.ps1')

$shell = Get-ReflexShell
$reflex = Resolve-Reflex

if ($reflex -and $shell) {
    if ($reflex.Root) { $env:REFLEX_ROOT = $reflex.Root }
    $env:SHELL = $shell
    $env:REFLEX_CWD = (Get-Location).ProviderPath
    & node $reflex.Cli run -- $command
    exit $LASTEXITCODE
}

if ($reflex) {
    [Console]::Error.WriteLine('prx: no Git Bash found, so the command runs unrecorded')
}

if ($shell) {
    & $shell -c $command
} else {
    & powershell -NoProfile -Command $command
}
exit $LASTEXITCODE
