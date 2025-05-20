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
