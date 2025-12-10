# completion
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# edit command line by editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line

# aliases
alias cp="cp -i"
alias mv="mv -i"

if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons"
    alias la="eza -a --icons"
    alias ll="eza -ahl --icons --time-style relative --group-directories-first"
    alias tree="eza -Thl --icons --time-style relative --group-directories-first"
else
    alias ls="ls --color"
    alias la="ls -a --color"
    alias ll="ls -al --color"
fi

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

for hook_file in ${ZDOTDIR}/lazy/*.zsh(.); do
    source "$hook_file"
done
unset hook_file
