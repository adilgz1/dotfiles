# Powerful but minimal zsh configuration
# Author: Radley E. Sidwell-Lewis
# GitHub: https://www.github.com/radleylewis/zsh
#
# Uses:
#   Plugins:      fast-syntax-highlighting, zsh-autosuggestions,
#                 zsh-history-substring-search, zsh-vi-mode
#   Prompt:       starship
#   Navigation:   zoxide, fzf, fd
#   CLI tools:    eza, bat, nvim, ripgrep
#   Node:         nvm
#
# =========================================================
# For commands that differ between MacOS and Linux
# =========================================================
case "$(uname)" in
  Darwin)
    export VIMTEX_VIEWER="skim"
    SED_INPLACE=(-i '')
    ;;
  Linux)
    export VIMTEX_VIEWER="zathura"
    SED_INPLACE=(-i)
    ;;
esac

# =========================================================
# History
# =========================================================

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# =========================================================
# Shell behaviour
# =========================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# =========================================================
# Smart directory navigation 
# =========================================================

# Initialize zoxide
eval "$(zoxide init zsh)"

# =========================================================
# Completion
# =========================================================

# Load completion system
autoload -Uz compinit

# Initialize completion with cached metadata file
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower

# =========================================================
# Fuzzy finder
# =========================================================

# macOS / Homebrew (Apple Silicon)
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# macOS / Homebrew (Intel)
if [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# Arch
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# Ubuntu
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# =========================================================
# Modular Config Files
# =========================================================

# fzf configuration
source "$ZDOTDIR/fzf.zsh"

# Aliases
source "$ZDOTDIR/aliases.zsh"

# Custom keybindings
source "$ZDOTDIR/bindings.zsh"

# Plugins and plugin manager
source "$ZDOTDIR/plugins.zsh"

# Prompt/theme
source "$ZDOTDIR/prompt.zsh"




## set yazi to open with y
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

## shell command to create new latex file from template
newtex() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: newtex <template-name> <new-file.tex> [title]"
    echo "Available templates:"
    ls ~/latex/templates/*.tex | xargs -n1 basename
    return 1
  fi

  local template="$HOME/latex/templates/$1.tex"
  local target="$2"
  local title="$3"

  if [ ! -f "$template" ]; then
    echo "Template '$1' not found."
    return 1
  fi

  if [ -f "$target" ]; then
    echo "File '$target' already exists. Aborting."
    return 1
  fi

  ## auto subtitute the string 'TITLE' in the latex template with the third argument of newtex
  ## e.g newtex worksheet algebra_hw3.tex "Algebra Homework 3"
  cp "$template" "$target"
  [ -n "$title" ] && sed "${SED_INPLACE[@]}" "s/TITLE/$title/" "$target"
  ### opens the new file in nvim
  #nvim "$target"
}

## setting up autocomplete for template names
_newtex_templates() {
  local -a templates
  templates=(${(f)"$(ls ~/latex/templates/*.tex 2>/dev/null | xargs -n1 basename | sed 's/\.tex$//')"})
  _describe 'template' templates
}

compdef _newtex_templates newtex



## source tmux aliases file in tmux config folder
source ~/.config/tmux/aliases.sh
export PATH="$HOME/.local/bin:$PATH"
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$HOME/.dotnet:$PATH"
# =========================================================
# Node / NVM
# =========================================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
