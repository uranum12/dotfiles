# aliases
alias cp="cp -i"
alias mv="mv -i"

if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons"
    alias la="eza -a --icons"
    alias ll="eza -ahl --icons --time-style relative --group-directories-first"
    alias tree="eza -Thl --icons --time-style relative --group-directories-first"
else
    alias la="ls -a --color"
    alias ll="ls -al --color"
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

# mise
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

# rye
if [ -e "$HOME/.rye/env" ]; then
    source "$HOME/.rye/env"
fi

# zabrze
if command -v zabrze >/dev/null 2>&1; then
    eval "$(zabrze init --bind-keys)"
fi

# zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    function zoxide_cd() {
        local src=$(zoxide query -l | fzf-tmux -p 80% --height 30% --no-sort --preview="eza -ahl --icons --color always --time-style relative --group-directories-first {}")
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
        local src=$(ghq list | fzf-tmux -p 80% --height 30% --preview="eza -ahl --icons --color always --time-style relative --group-directories-first $(ghq root)/{}")
        if [ -n "$src" ]; then
            BUFFER="cd $(ghq root)/$src"
            CURSOR=$#BUFFER
        fi
        zle reset-prompt
    }
    zle -N ghq_repo
    bindkey '^g' ghq_repo
fi

# python
function py() {
    if [[ -n $VIRTUAL_ENV ]]; then
        $VIRTUAL_ENV/bin/python "$@"
    elif [[ -f ".venv/bin/python" ]]; then
        .venv/bin/python "$@"
    elif [[ -f "poetry.lock" ]]; then
        poetry run python "$@"
    elif [[ -f "Pipfile.lock" ]]; then
        pipenv run python "$@"
    elif [[ -f "pdm.lock" ]]; then
        pdm run python "$@"
    elif command -v uv >/dev/null 2>&1; then
        uv run "$@"
    else
        python "$@"
    fi
}

# diff
if command -v delta >/dev/null 2>&1; then
    function dif() {
        if [[ $# -ne 2 ]]; then
           echo "Usage: dif file1 file2"
           return 1
        fi

        if [[ ! -f "$1" || ! -f "$2" ]]; then
            echo "Both arguments must be valid files."
            return 1
        fi

        diff -u "$1" "$2" | delta
    }
fi

