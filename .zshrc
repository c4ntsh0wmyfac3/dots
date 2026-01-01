HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
bindkey -v
bindkey "^?" backward-delete-char
bindkey '^R' history-incremental-search-backward
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey -M vicmd 'p' up-line-or-beginning-search
bindkey -M vicmd 'n' down-line-or-beginning-search
alias n='nvim'
alias tn='tmux new -s '
alias tna='tmux'
alias ta='tmux attach'
alias tas='tmux attach -t '
alias tk='tmux kill-session -t '
alias tka='tmux kill-server'
bindkey '^E' clear-screen
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
bindkey '^F' autosuggest-accept
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^?' backward-delete-char

setopt PROMPT_SUBST
export KEYTIMEOUT=1
eval "$(zoxide init --cmd cd zsh)"


VIM_INS_MODE="%F{cyan}[I]%f"
VIM_NOR_MODE="%F{yellow}[N]%f"
CURRENT_VI_MODE=$VIM_INS_MODE

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    CURRENT_VI_MODE=$VIM_NOR_MODE
    echo -ne '\e[1 q' # Мигающее нижнее подчеркивание
  else
    CURRENT_VI_MODE=$VIM_INS_MODE
    echo -ne '\e[3 q' # Мигающая вертикальная черта
  fi
  zle reset-prompt
}

zle -N zle-keymap-select
echo -ne '\e[3 q'

function zle-line-init {
    CURRENT_VI_MODE=$VIM_INS_MODE
    echo -ne '\e[3 q'
    zle reset-prompt
}
zle -N zle-line-init

git_custom_status() {
  local branch=$(git branch --show-current 2>/dev/null)
  [[ -z "$branch" ]] && return

  local stat=$(git status --porcelain 2>/dev/null)
  local indicators=""
  
  if echo "$stat" | grep -q '??'; then
    indicators+="%F{red}@%f" 
  fi

  if echo "$stat" | grep -q '^.[AMD]'; then
    indicators+="%F{yellow}*%f"
  fi

  if echo "$stat" | grep -q '^[AMD]'; then
    indicators+="%F{green}+%f"
  fi

  echo "%F{magenta}(%F{cyan}$branch%F{magenta})%f$indicators"
}

PROMPT='%F{blue}%~$(git_custom_status)%F{green}>%f'
RPROMPT='${CURRENT_VI_MODE}%(?.%F{green}^%f.%F{red}!)%F{gray}%T%f'
