if test -e ~/.asdf/asdf.fish
    source ~/.asdf/asdf.fish
end

if status is-interactive
    if type -q zoxide
        zoxide init fish | source
    end

    if type -q exa
        alias ls "exa --icons"
        alias la "exa -a --icons"
        alias ll "exa -ahl --icons"
        alias tree "exa -Thl --icons"
    else
        alias la "ls -a"
        alias ll "ls -al"
    end

    abbr -a c 'clear'
    abbr -a v 'nvim'
    abbr -a t 'tmux'
    abbr -a .. 'cd ..'
    abbr -a rr 'rm -rf'

    abbr -a g 'git'
    abbr -a ga 'git add'
    abbr -a gc 'git commit'
    abbr -a gcm 'git commit -m'
    abbr -a gs 'git status -sb'
    abbr -a gd 'git diff'
    abbr -a gds 'git diff --cached'
    abbr -a gb 'git branch -a'
    abbr -a gp 'git push'
    abbr -a gch 'git checkout'
    abbr -a gw 'git worktree'
    abbr -a gl 'git log --graph --oneline'
    abbr -a glog 'git log --graph -n 10'
    abbr -a gtag 'git tag'
    abbr -a gsub 'git submodule'
    abbr -a lg 'lazygit'
    abbr -a gg 'ghq get'

    abbr -a d 'docker'
    abbr -a dc 'docker-compose'
end

