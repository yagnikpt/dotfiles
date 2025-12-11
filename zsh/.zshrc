if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey -e
setopt globdots

# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="/usr/bin:$PATH"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

autoload -Uz compinit && compinit
zinit cdreplay -q

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

# oh my posh
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

plugins=(git git-commit tldr docker docker-compose azure dnf)

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# zoxide
eval "$(zoxide init zsh)"

# fzf
eval "$(fzf --zsh)"

# aliases
alias c="clear"
alias nv="nvim"
alias nvsu="sudoedit nvim"
alias zshconfig="nvim ~/.zshrc"
alias ls="eza --all --color=always --git --icons=always --no-time"
alias ff="gitfetch --graph-only; fastfetch;"
alias fb="flashback"
alias ds="du -h -s"
alias niriconfig="nvim ~/.config/niri/config.kdl"
alias dysk="dysk -c disk+used+use+free+size"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Android Sdk
export ANDROID_HOME=~/Android/Sdk
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
