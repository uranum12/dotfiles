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
