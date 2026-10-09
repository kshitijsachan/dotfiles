#!/usr/bin/env bash
# Bootstrap a Mac from this repo. Safe to re-run.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$1"; }

# --- Homebrew ---
if ! command -v brew >/dev/null && [[ ! -x /opt/homebrew/bin/brew ]]; then
  step "Installing Homebrew (asks for your password)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

step "Installing Brewfile packages"
brew tap nikitabobko/tap
brew trust --cask nikitabobko/tap/aerospace   # third-party taps need explicit trust
brew bundle --file="$DOTFILES/Brewfile"

# --- Symlinks: every file under home/ is linked to the same path under ~ ---
step "Linking dotfiles"
cd "$DOTFILES/home"
find . -type f ! -name .DS_Store | while read -r f; do
  rel="${f#./}"
  src="$DOTFILES/home/$rel"
  dst="$HOME/$rel"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"
    echo "  backed up existing $rel"
  fi
  ln -sfn "$src" "$dst"
  echo "  $rel"
done
chmod 700 "$HOME/.ssh"

if [[ ! -f "$HOME/.gitconfig.local" ]]; then
  cp "$DOTFILES/gitconfig.local.example" "$HOME/.gitconfig.local"
  echo "  created ~/.gitconfig.local — edit it with your name/email"
fi

# --- Python ---
step "Setting up Python (uv)"
uv python install
uv tool install --upgrade ty

step "Done"
cat <<'EOF'
Next:
  1. Open a new Ghostty window (or run: exec zsh)
  2. Edit ~/.gitconfig.local with your name and email
  3. Optional macOS tweaks: ./macos.sh
  4. See README.md for the one-time app setup (1Password, Raycast, AeroSpace)
EOF
