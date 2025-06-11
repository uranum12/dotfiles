# history
local tmpfile=$(mktemp)
zhist list --recent > "$tmpfile"
fc -IR "$tmpfile"
rm "$tmpfile"
unset tmpfile

function history_add() {
    emulate -L zsh
    [[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}

function history_preexec() {
    __history_cmd=$1
    __history_cwd=$(pwd)
    typeset -g __history_cmd __history_cwd
}

function history_precmd() {
    local ret=$?
    zhist add -c "$__history_cmd" -d "$__history_cwd" -r "$ret"
}

autoload -Uz add-zsh-hook
add-zsh-hook zshaddhistory history_add
add-zsh-hook preexec history_preexec
add-zsh-hook precmd history_precmd

function history_select() {
    if [ -n "$BUFFER" ]; then
        local hist=$(zhist list | fzf-tmux -p 80% --height 30% -q "$BUFFER")
    else
        local hist=$(zhist list | fzf-tmux -p 80% --height 30%)
    fi
    if [ -n "$hist" ]; then
        BUFFER="$hist"
        CURSOR=$#BUFFER
    fi
    zle reset-prompt
}

zle -N history_select
bindkey '^r' history_select

function history_select_all() {
    if [ -n "$BUFFER" ]; then
        local hist=$(zhist list -a | fzf-tmux -p 80% --height 30% -q "$BUFFER")
    else
        local hist=$(zhist list -a | fzf-tmux -p 80% --height 30%)
    fi
    if [ -n "$hist" ]; then
        BUFFER="$hist"
        CURSOR=$#BUFFER
    fi
    zle reset-prompt
}

zle -N history_select_all
bindkey '^t' history_select_all
