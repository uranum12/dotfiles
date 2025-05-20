# history
function history_add() {
    emulate -L zsh
    [[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}

autoload -Uz add-zsh-hook
add-zsh-hook zshaddhistory history_add

function history_select() {
    fc -RI
    if [ -n "$BUFFER" ]; then
        local hist=$(history -r -n 1 | fzf-tmux -p 80% --height 30% -q "$BUFFER")
    else
        local hist=$(history -r -n 1 | fzf-tmux -p 80% --height 30%)
    fi
    if [ -n "$hist" ]; then
        BUFFER="$hist"
        CURSOR=$#BUFFER
    fi
    zle reset-prompt
}

zle -N history_select
bindkey '^r' history_select
