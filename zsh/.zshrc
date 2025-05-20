# source command override technique
function source {
    ensure_zcompiled $1
    builtin source $1
}
function ensure_zcompiled {
    local compiled="$1.zwc"
    if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
        zcompile $1
    fi
}
ensure_zcompiled "$ZDOTDIR/.zshrc"

# plugins
if command -v sheldon >/dev/null 2>&1; then
    sheldon_cache="$ZDOTDIR/hooks/sheldon.zsh"
    sheldon_toml="$HOME/.config/sheldon/plugins.toml"
    if [[ ! -r "$sheldon_cache" || $sheldon_toml -nt "$sheldon_cache" ]]; then
        sheldon source > $sheldon_cache
    fi
    source "$sheldon_cache"
    unset sheldon_cache sheldon_toml
else
    function zsh-defer() { $@ }
fi

# options
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000
HISTORY_IGNORE="(cd|clear|exit|env|pwd|l[sal])"

setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_ignore_all_dups  # すでに同じものがある場合削除
setopt hist_ignore_space     # スペースから始まる履歴を追加しない
setopt hist_reduce_blanks    # 余計なスペースを削除
setopt hist_no_functions     # 関数定義を追加しない
setopt hist_no_store         # history関連を追加しない
setopt hist_verify           # 直接実行しない
setopt interactive_comments  # コマンドラインでもコメントを使用可能にする
setopt no_beep               # ビープ音を消す
setopt ignore_eof            # C-dを無効化
setopt list_packed           # 表示をコンパクトに

# completion
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# lazy load
zsh-defer source "$ZDOTDIR/hooks/lazy.zsh"

# prompt
function zsh_prompt() {
    local git_status=""
    local ssh_host=""
    local venv_prompt=""

    git_status=$(git branch --show-current 2>/dev/null)
    if [ $? -eq 0 ]; then
        if [ -z "$git_status" ]; then
            git_status=$(git tag --points-at HEAD)
            if [ -z "$git_status" ]; then
                git_status="@%F{2}$(git rev-parse --short HEAD)%f"
            else
                git_status="#%F{2}${git_status//$'\n'/%f #%F{2\}}" # }"
                git_status="${git_status% #}%f"
            fi
        else
            git_status="%F{2}$git_status%f"
        fi
    fi

    if [ -n "$SSH_CONNECTION" ]; then
        ssh_host="%F{3}%n%f@%F{3}%m%f:"
    fi

    if [ -n "$VIRTUAL_ENV" ]; then
        venv_prompt="(${VIRTUAL_ENV##*/}) "
    fi

    echo -e "$ssh_host%F{4}%~%f $git_status\n$venv_prompt%(?.%F{2}.%F{1})❯%f "
}
function precmd() {
    PROMPT=$(zsh_prompt)
}

# greeting
function zsh_greeting() {
    local c="%F{$((RANDOM % 15 + 1))}"
    print -P "     %F{11}______________%f            *        /     %F{11}o%f"
    print -P "  ==%F{11}(_____(o(___(_()%f                   /"
    print -P "          /|\\\\             %F{9}o%f      |    *            *"
    print -P "         / | \\\\${c}┌─┐┌─┐┬ ┬%f         -+-        +"
    print -P "        /  |  ${c}┌─┘└─┐├─┤%f          |              %F{12}o%f"
    print -P "       /      ${c}└─┘└─┘┴ ┴%f     *          ~+"
}
zsh_greeting

# source command override technique
zsh-defer unfunction source

