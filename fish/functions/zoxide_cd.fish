function zoxide_cd
    if type -q zoxide
        if type -q exa
            set -l select (zoxide query -l | fzf-tmux -p 80% --height 30% --no-sort --preview='exa -ahl --icons {}')
            [ -n "$select" ]; and cd "$select"
        else
            set -l select (zoxide query -l | fzf-tmux -p 80% --height 30% --no-sort)
            [ -n "$select" ]; and cd "$select"
        end
        commandline -f repaint
    end
end
