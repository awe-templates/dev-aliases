# shellcheck shell=bash
# Shared by prx and rxh: finds the reflex CLI that serves the current folder.
#
# resolve_reflex sets
#   reflex_cli   the reflex.mts to run with node
#   reflex_root  the folder to pass as REFLEX_ROOT, or empty for a repository
# and returns 1 when no reflex serves this folder.
#
# Two places are recognised, nearest first:
#   1. a repository whose package.json has a "reflex": "node <path>" script;
#   2. a parent folder whose .claude/settings.json wires the reflex hooks (a
#      workspace of several repositories), served by the shared CLI below, so
#      prx in a terminal and Claude Code sessions there keep one history.
#
# REFLEX_CLI overrides the shared CLI's location.

reflex_shared_cli="${REFLEX_CLI:-$HOME/Desktop/gh/nn/ngeen-platform/tools/external-plugins/reflex-plugin/cli/reflex.mts}"

resolve_reflex() {
  reflex_cli=""
  reflex_root=""

  local root entry dir

  # The superproject when called inside a submodule, else the repository root.
  root=$(git rev-parse --show-superproject-working-tree 2>/dev/null)
  [ -z "$root" ] && root=$(git rev-parse --show-toplevel 2>/dev/null)

  if [ -n "$root" ] && [ -f "$root/package.json" ]; then
    # Read the script without starting node.
    entry=$(sed -n 's/.*"reflex"[[:space:]]*:[[:space:]]*"node \([^"]*\)".*/\1/p' "$root/package.json" | head -n 1)

    if [ -n "$entry" ] && [ -f "$root/$entry" ]; then
      reflex_cli="$root/$entry"
      return 0
    fi
  fi

  [ -f "$reflex_shared_cli" ] || return 1

  dir="$PWD"
  while [ "$dir" != "/" ]; do
    if [ -f "$dir/.claude/settings.json" ] && grep -q "reflex.mts" "$dir/.claude/settings.json"; then
      reflex_cli="$reflex_shared_cli"
      reflex_root="$dir"
      return 0
    fi
    dir=$(dirname "$dir")
  done

  return 1
}
