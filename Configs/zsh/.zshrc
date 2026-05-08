# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

bindkey -e
setopt globdots

bindkey ' ' magic-space

chpwd() {
  if [[ -d .venv ]]; then
    source .venv/bin/activate
  elif [[ -d venv ]]; then
    source venv/bin/activate
  fi
}

alias -s json=jless
alias -s md=glow
alias -s go='$EDITOR'
alias -s rs='$EDITOR'
alias -s txt=bat
alias -s log=bat
alias -s py='$EDITOR'
alias -s js='$EDITOR'
alias -s ts='$EDITOR'
alias -s html=open

alias -g NE='2>/dev/null'
alias -g NO='>/dev/null'
alias -g NUL='>/dev/null 2>&1'
alias -g J='| jq'
alias -g C='| wlcopy'

function clear-screen-and-scrollback() {
  echoti civis >"$TTY"
  printf '%b' '\e[H\e[2J\e[3J' >"$TTY"
  echoti cnorm >"$TTY"
  zle redisplay
}
zle -N clear-screen-and-scrollback
bindkey '^X^L' clear-screen-and-scrollback

# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export HOMEBREW_NO_ENV_HINTS=1

eval "$(fnm env --use-on-cd --shell zsh)"
export PATH="/usr/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/go/bin"

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

plugins=(git git-commit tldr docker docker-compose dnf)

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
alias rmf="rm -rf"
alias nv="nvim"
alias nvsu="sudoedit nvim"
alias zshconfig="nvim ~/.zshrc"
alias ls="eza --all --color=always --git --icons=always --no-time"
alias ff="fastfetch"
alias fb="flashback"
alias ds="du -h -s"
alias niriconfig="nvim ~/.config/niri/config.kdl"
alias dysk="dysk -c disk+used+use+free+size"
alias anime="curd"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Android Sdk
export ANDROID_HOME=~/Android/Sdk
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# harsh todo

# Preserve the existing Tab widget before Forge setup can override it.
# This lives outside the managed block so forge setup won't clobber it.
_FORGE_PREV_TAB_WIDGET=$(bindkey '^I' 2>/dev/null | awk '{print $2}')

# >>> forge initialize >>>
# !! Contents within this block are managed by 'forge zsh setup' !!
# !! Do not edit manually - changes will be overwritten !!

# Add required zsh plugins if not already present
if [[ ! " ${plugins[@]} " =~ " zsh-autosuggestions " ]]; then
    plugins+=(zsh-autosuggestions)
fi
if [[ ! " ${plugins[@]} " =~ " zsh-syntax-highlighting " ]]; then
    plugins+=(zsh-syntax-highlighting)
fi

# Load forge shell plugin (commands, completions, keybindings) if not already loaded
if [[ -z "$_FORGE_PLUGIN_LOADED" ]]; then
    eval "$(forge zsh plugin)"
fi

# Load forge shell theme (prompt with AI context) if not already loaded
if [[ -z "$_FORGE_THEME_LOADED" ]]; then
    eval "$(forge zsh theme)"
fi
# <<< forge initialize >>>

# Forge Tab override: only use Forge completion when the input line starts
# with ":". Otherwise, fall back to the widget that was bound before Forge.
if (( $+functions[forge-completion] )); then
    forge-smart-complete() {
        if [[ ${LBUFFER##[[:space:]]} == :* ]]; then
            zle forge-completion
        else
            if [[ -n "${_FORGE_PREV_TAB_WIDGET:-}" ]]; then
                zle "${_FORGE_PREV_TAB_WIDGET}"
            else
                zle expand-or-complete
            fi
        fi
    }
    zle -N forge-smart-complete
    bindkey '^I' forge-smart-complete
fi
