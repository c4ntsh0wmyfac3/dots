autoload -Uz vcs_info
precmd_functions+=( vcs_info )

# Configure vcs_info styles
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f %c%u'
zstyle ':vcs_info:git:*' actionformats '%F{green}(%b|%a)%f %c%u'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}+%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}*%f'

setopt prompt_subst

# Set the prompt: upper line with full path and Git info, lower line for input
PROMPT='%F{blue}%~%f ${vcs_info_msg_0_}
%F{green}➜ %f'

export GOROOT=/usr/lib/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOBIN
export PATH="$HOME/.tmuxifier/bin:$PATH"
export EDITOR='nvim'

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"
export ATUIN_NOBIND="true"
bindkey '^r' atuin-up-search-viins

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory

bindkey '^E' clear-screen
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

alias ls='ls --color=auto'
zstyle ':completion:*' list-colors ''
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
fi

source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^F' autosuggest-accept

source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
