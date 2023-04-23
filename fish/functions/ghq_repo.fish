function ghq_repo
    if type -q ghq
        set -l ghq_root (ghq root)
        if type -q exa
            set -l select (ghq list | fzf-tmux -p 80% --height 30% --preview="exa -ahl --icons $ghq_root/{}")
            [ -n "$select" ]; and cd "$ghq_root/$select"
        else
            set -l select (ghq list | fzf-tmux -p 80% --height 30%)
            [ -n "$select" ]; and cd "$ghq_root/$select"
        end
        commandline -f repaint
    end
end
