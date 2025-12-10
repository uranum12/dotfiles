# plugins
if command -v sheldon >/dev/null 2>&1; then
    eval "$(sheldon source)"
else
    function zsh-defer() {
        "$@"
    }
fi

# history options
unset HISTFILE
SAVEHIST=0
HISTSIZE=100000
HISTORY_IGNORE="(cd|clear|exit|env|pwd|l[sal])"
setopt hist_ignore_all_dups # すでに同じものがある場合削除
setopt hist_ignore_space    # スペースから始まる履歴を追加しない

# options
setopt interactive_comments # コマンドラインでもコメントを使用可能にする
setopt no_beep              # ビープ音を消す
setopt ignore_eof           # C-dを無効化
setopt list_packed          # 表示をコンパクトに

# keybind
bindkey -d
bindkey -e

# lazy load
zsh-defer source "$ZDOTDIR/hooks/lazy.zsh"

# prompt
setopt promptsubst
PROMPT='$(zprompt $?)'

# greeting
zgreeting
