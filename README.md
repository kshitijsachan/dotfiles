# dotfiles

macOS setup for Python + Helix, biased toward small, fast tools.

```bash
git clone https://github.com/kshitijsachan/dotfiles ~/dotfiles
~/dotfiles/install.sh
~/dotfiles/macos.sh   # optional system tweaks
```

`install.sh` installs Homebrew and everything in the [Brewfile](Brewfile), then
symlinks each file in `home/` to the same path under `~` (existing files are
backed up as `*.bak.<timestamp>`). Edit configs here; changes take effect live.

## What's in it

| Area | Tool |
|---|---|
| Terminal | Ghostty |
| Shell | zsh + starship, autosuggestions, fast-syntax-highlighting, you-should-use |
| Multiplexer | zellij (starts locked — `Ctrl-g` to unlock) |
| Editor | Helix with ty + ruff for Python |
| Python | uv for interpreters, venvs, packages and tools |
| History / nav | atuin (`Ctrl-R`), zoxide (`z`), fzf (`Ctrl-T`, `Alt-C`), yazi (`y`) |
| CLI | eza, bat, ripgrep, fd, dust, btop, tlrc, jq |
| Git | delta, lazygit (`lg`), gh |
| Windows | AeroSpace |
| Keyboard | Karabiner-Elements (Caps Lock → Esc tap / Ctrl hold) |
| Apps | 1Password, Raycast, Zen, Ice, Shottr, Stats, MonitorControl |

Theme is Catppuccin Mocha everywhere; bat and delta use `ansi` so they follow
the terminal.

## AeroSpace keys

| Keys | Action |
|---|---|
| `alt-h/j/k/l` | focus window |
| `alt-shift-h/j/k/l` | move window |
| `alt-1…9` / `alt-shift-1…9` | go to / send to workspace |
| `alt-tab` | previous workspace |
| `alt-enter` | new Ghostty window |
| `alt-f` | fullscreen |
| `alt-/` | toggle split direction |
| `alt-r`, then `h/j/k/l`, `=`, `esc` | resize mode |
| `alt-shift-;`, then `a`/`f`/`r`/`esc` | service: accordion, float, flatten, reload |

## One-time manual setup

1. **1Password** — sign in, then Settings → Developer → turn on
   *Use the SSH agent* and *Integrate with 1Password CLI*. Create or import an
   SSH key, add it to GitHub (both as an auth key and a signing key), and put
   the public key in `~/.gitconfig.local` to sign commits.
2. **Raycast** — System Settings → Keyboard → Keyboard Shortcuts → Spotlight:
   untick ⌘Space, then set Raycast's hotkey to ⌘Space.
3. **Karabiner-Elements** — allow its driver and Input Monitoring when prompted,
   then Complex Modifications → Add predefined rule → enable
   *Caps Lock: Esc when tapped, Ctrl when held*.
4. **AeroSpace / Ghostty** — grant Accessibility permission when prompted.
5. **Ice** — drag menu bar icons into the hidden section.

## Python workflow

```bash
uv init myproject && cd myproject   # new project
uv add numpy                        # add a dependency (creates .venv)
uv run python main.py               # run inside the venv
uv tool install ipython             # global CLI tools
```

Helix picks up `.venv` automatically for ty and ruff.

## Local overrides (not committed)

- `~/.gitconfig.local` — name, email, signing key
- `~/.zshrc.local` — machine-specific shell config
