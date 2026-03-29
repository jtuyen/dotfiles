# Standalone zsh config for macOS without Oh My Zsh.
# Kept from the previous setup:
#   - git aliases/functions (from the Oh My Zsh git plugin)
#   - directory aliases/options (lsa, la, ll, l, auto_cd, pushd helpers)
#   - misc/grep/history helpers (history alias, grep colors, mkcd/take helpers, sudo alias)
#   - fzf integration
#   - fzf-tab
#   - vi-mode
#   - zsh-autocomplete
#   - zsh-syntax-highlighting

[[ -o interactive ]] || return

source_if_exists() {
  [[ -r "$1" ]] && source "$1"
}

# yazi wrapper that syncs the shell's cwd after exit.
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

export ZSH_PLUGIN_HOME="$HOME/.zsh/plugins"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_CACHE_DIR"

# Restore history behavior that OMZ previously configured.
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt extended_history hist_expire_dups_first hist_ignore_dups hist_ignore_all_dups hist_find_no_dups hist_ignore_space hist_verify inc_append_history share_history no_flow_control

setopt prompt_subst
autoload -Uz colors && colors

# Completion styles should be configured before zsh-autocomplete / compinit.
zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
[[ -n "$LS_COLORS" ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Enable vi bindings before zsh-autocomplete so its main keymap is viins.
source_if_exists "$ZSH_PLUGIN_HOME/vi-mode/vi-mode.plugin.zsh"

# zsh-autocomplete should be sourced near the top and before compdef calls.
source_if_exists "$ZSH_PLUGIN_HOME/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

# Oh My Zsh helpers/aliases, now sourced from ~/.zsh instead of ~/.oh-my-zsh.
source_if_exists "$HOME/.zsh/lib/functions.zsh"
source_if_exists "$HOME/.zsh/lib/directories.zsh"
source_if_exists "$HOME/.zsh/lib/history.zsh"
source_if_exists "$HOME/.zsh/lib/misc.zsh"
source_if_exists "$HOME/.zsh/lib/grep.zsh"
source_if_exists "$HOME/.zsh/lib/git.zsh"
source_if_exists "$ZSH_PLUGIN_HOME/git/git.plugin.zsh"

# Disable OMZ async git prompt wiring outside OMZ and use the direct functions.
precmd_functions=(${precmd_functions:#_defer_async_git_register})
unfunction _defer_async_git_register 2>/dev/null || true
git_prompt_info() { _omz_git_prompt_info; }
git_prompt_status() { _omz_git_prompt_status; }

# Prompt: robbyrussell-style prompt with hostname prefix.
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
PROMPT='%m %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} )%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

# Colored directory listings on macOS.
if (( $+commands[gls] )); then
  alias ls='gls --color=auto'
else
  alias ls='ls -G'
fi

# Prefer GNU grep if available on macOS.
if ! alias grep >/dev/null 2>&1 && (( $+commands[ggrep] )); then
  alias grep='ggrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}'
  alias egrep='ggrep -E'
  alias fgrep='ggrep -F'
fi

# fzf integration.
if [[ -d "$HOME/.fzf/bin" && "$PATH" != *"$HOME/.fzf/bin"* ]]; then
  export PATH="$PATH:$HOME/.fzf/bin"
fi
source_if_exists "$HOME/.fzf.zsh"
if [[ ! -r "$HOME/.fzf.zsh" ]] && (( $+commands[fzf] )); then
  eval "$(fzf --zsh 2>/dev/null)" || true
fi

if [[ -z "$FZF_DEFAULT_COMMAND" ]]; then
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  elif (( $+commands[rg] )); then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
  fi
fi

# fzf-tab wants to load after compinit but before widget-wrapping plugins.
source_if_exists "$ZSH_PLUGIN_HOME/fzf-tab/fzf-tab.plugin.zsh"

# Syntax highlighting.
source_if_exists "$ZSH_PLUGIN_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"

export NVM_DIR="$HOME/.nvm"
source_if_exists "$NVM_DIR/nvm.sh"
source_if_exists "$NVM_DIR/bash_completion"

source_if_exists "$HOME/.local/bin/env"

export GOENV_ROOT="$HOME/.goenv"
export BUN_INSTALL="$HOME/.bun"
export EDITOR="nvim"
export GOENV_PATH_ORDER=front
export _ZO_DOCTOR=0
export SSH_AUTH_SOCK="$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"

typeset -U path PATH
path=(
  "$BUN_INSTALL/bin"
  "$HOME/.nimble/bin"
  "$GOENV_ROOT/bin"
  "$HOME/.rbenv/bin"
  "$HOME/.lmstudio/bin"
  $path
)

if [[ -n "$GOPATH" ]]; then
  path=("$GOPATH/bin" $path)
fi

if (( $+commands[rbenv] )); then
  eval "$(rbenv init -)"
fi

if (( $+commands[goenv] )); then
  eval "$(goenv init -)"
fi

if (( $+commands[uv] )); then
  eval "$(uv generate-shell-completion zsh)"
fi

source_if_exists "$BUN_INSTALL/_bun"

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi
