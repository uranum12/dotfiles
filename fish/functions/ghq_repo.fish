function ghq_repo
    if type -q ghq
        if type -q exa
            set -l select (ghq list | fzf-tmux -p 80% --height 30% --preview='exa -ahl --icons {}')
            [ -n "$select" ]; and cd (ghq root)"/$select"
        else
            set -l select (ghq list | fzf-tmux -p 80% --height 30%)
            [ -n "$select" ]; and cd (ghq root)"/$select"
        end
        commandline -f repaint
    end
end
