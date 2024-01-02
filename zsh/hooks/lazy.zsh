# aliases
alias cp="cp -i"
alias mv="mv -i"

if command -v exa >/dev/null 2>&1; then
    alias ls="exa --icons"
    alias la="exa -a --icons"
    alias ll="exa -ahl --icons"
    alias tree="exa -Thl --icons"
else
    alias la="ls -a"
    alias ll="ls -al"
fi

if command -v trash >/dev/null 2>&1; then
    alias rm="trash -F"
fi

# history
function zshaddhistory() {
    emulate -L zsh
    [[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}
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

# asdf
if [ -e "$HOME/.asdf/asdf.sh" ]; then
    source "$HOME/.asdf/asdf.sh"
fi

# rye
if [ -e "$HOME/.rye/env" ]; then
    source "$HOME/.rye/env"
fi

# zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    function zoxide_cd() {
        local src=$(zoxide query -l | fzf-tmux -p 80% --height 30% --no-sort --preview="exa -ahl --icons {}")
        if [ -n "$src" ]; then
            BUFFER="cd $src"
            CURSOR=$#BUFFER
        fi
        zle reset-prompt
    }
    zle -N zoxide_cd
    bindkey '^d' zoxide_cd
fi

# ghq
if command -v ghq >/dev/null 2>&1; then
    function ghq_repo() {
        local src=$(ghq list | fzf-tmux -p 80% --height 30% --preview="exa -ahl --icons $(ghq root)/{}")
        if [ -n "$src" ]; then
            BUFFER="cd $(ghq root)/$src"
            CURSOR=$#BUFFER
        fi
        zle reset-prompt
    }
    zle -N ghq_repo
    bindkey '^g' ghq_repo
fi

