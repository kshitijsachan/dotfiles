# Kept small on purpose. Homebrew PATH setup lives in .zprofile.

# --- Options ---
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE
setopt AUTO_CD INTERACTIVE_COMMENTS

export EDITOR=hx VISUAL=hx
export BAT_THEME=ansi            # follow the terminal's colors
path=(~/.local/bin $path)        # uv tool installs land here

# --- Completion ---
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# --- Tools ---
(( $+commands[starship] )) && eval "$(starship init zsh)"
(( $+commands[zoxide] ))   && eval "$(zoxide init zsh)"
(( $+commands[fzf] ))      && source <(fzf --zsh)
(( $+commands[atuin] ))    && eval "$(atuin init zsh --disable-up-arrow)"  # owns Ctrl-R
(( $+commands[uv] ))       && eval "$(uv generate-shell-completion zsh)"

# --- Aliases ---
if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first'
  alias ll='eza -l --git --group-directories-first'
  alias la='ll -a'
  alias lt='eza --tree --level=2 --git-ignore'
fi
(( $+commands[bat] )) && alias cat='bat --paging=never'
alias g='git'
alias lg='lazygit'
alias zj='zellij'
alias venv='source .venv/bin/activate'

# yazi, but cd into wherever you were when you quit
y() {
  local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# --- Plugins (syntax highlighting must load last) ---
for plugin in \
  zsh-autosuggestions/zsh-autosuggestions.zsh \
  zsh-you-should-use/you-should-use.plugin.zsh \
  zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
do
  [[ -r $HOMEBREW_PREFIX/share/$plugin ]] && source $HOMEBREW_PREFIX/share/$plugin
done
unset plugin

[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
