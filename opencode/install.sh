#!/usr/bin/env bash
set -euo pipefail
# WSL uses the Linux binary. The official installer detects OS and CPU.
case "$(uname -s)" in
  Linux|Darwin) ;;
  *) printf 'Run this installer on macOS, Linux or inside WSL.\n' >&2; exit 1 ;;
esac
if command -v opencode >/dev/null 2>&1; then
  printf 'OpenCode already available; skipping installation.\n'
elif [[ -x "$HOME/.opencode/bin/opencode" ]]; then
  export PATH="$HOME/.opencode/bin:$PATH"
  printf 'Using existing OpenCode in ~/.opencode/bin.\n'
else
  command -v curl >/dev/null 2>&1 || { printf 'Install curl first, then run this script again.\n' >&2; exit 1; }
  printf 'Installing OpenCode with the official installer...\n'
  curl -fsSL https://opencode.ai/install | bash
  export PATH="$HOME/.opencode/bin:$PATH"
  command -v opencode >/dev/null 2>&1 || { printf 'Installation finished but opencode is not on PATH. Restart your shell and check the installer output.\n' >&2; exit 1; }
fi


source_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
skills_dir="$HOME/.agents/skills"
backup_dir="$HOME/.local/state/dotfiles-opencode/backups/$(date +%Y%m%d-%H%M%S)-$$"
install_file() {
  local source_file="$1" destination="$2" relative="$3"
  mkdir -p -- "$(dirname -- "$destination")"
  if [[ -e "$destination" || -L "$destination" ]]; then
    if cmp -s -- "$source_file" "$destination"; then return; fi
    mkdir -p -- "$(dirname -- "$backup_dir/$relative")"
    cp -a -- "$destination" "$backup_dir/$relative"
  fi
  cp -- "$source_file" "$destination"
}
install_file "$source_dir/config/AGENTS.md" "$config_dir/AGENTS.md" config/AGENTS.md
while IFS= read -r -d '' file; do
  relative="${file#"$source_dir/config/agents/"}"
  install_file "$file" "$config_dir/agents/$relative" "config/agents/$relative"
done < <(find "$source_dir/config/agents" -type f -print0)
while IFS= read -r -d '' file; do
  relative="${file#"$source_dir/skills/"}"
  install_file "$file" "$skills_dir/$relative" "skills/$relative"
done < <(find "$source_dir/skills" -type f -print0)
printf 'Installed OpenCode agents, rules and Matt Pocock skills.\n'
if [[ -d "$backup_dir" ]]; then printf 'Backups: %s\n' "$backup_dir"; fi
printf 'Restart OpenCode. Verify with: opencode agent list; opencode debug skill\n'
