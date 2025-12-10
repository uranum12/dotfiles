# history
local tmpfile=$(mktemp)
zhist list --recent --zsh-history > "$tmpfile"
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

__history_fzf_select() {
    emulate -L zsh
    local list_opts="$1"
    local query_opt=""
    local hist

    [[ -n "$BUFFER" ]] && query_opt="-q $BUFFER"

    hist=$(
        zhist list $list_opts --fzf \
        | fzf-tmux \
            --read0 \
            --delimiter='\t' \
            --with-nth=1 \
            -p 80% \
            --height 30% \
            --preview='echo -e {2..} | bat --language=zsh --number --color=always --paging=never' \
            $query_opt \
        | cut -f2-
    )

    if [[ -n "$hist" ]]; then
        BUFFER="$hist"
        CURSOR=${#BUFFER}
    fi

    zle reset-prompt
}

history_select() {
    __history_fzf_select "--recent"
}

zle -N history_select
bindkey '^r' history_select

history_select_all() {
    __history_fzf_select "--all"
}

zle -N history_select_all
bindkey '^t' history_select_all
