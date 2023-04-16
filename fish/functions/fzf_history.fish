function fzf_history
    history merge
    set -l result (history | fzf-tmux -p 80% --height 30% -q (commandline))
    [ -n "$result" ]; and commandline -- $result
    commandline -f repaint
end
