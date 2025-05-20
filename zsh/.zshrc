# plugins
if command -v sheldon >/dev/null 2>&1; then
    eval "$(sheldon source)"
else
    function zsh-defer() {
        "$@"
    }
fi

# options
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000
HISTORY_IGNORE="(cd|clear|exit|env|pwd|l[sal])"

setopt inc_append_history   # 履歴をインクリメンタルに追加
setopt hist_ignore_all_dups # すでに同じものがある場合削除
setopt hist_ignore_space    # スペースから始まる履歴を追加しない
setopt hist_reduce_blanks   # 余計なスペースを削除
setopt hist_no_functions    # 関数定義を追加しない
setopt hist_no_store        # history関連を追加しない
setopt hist_verify          # 直接実行しない
setopt interactive_comments # コマンドラインでもコメントを使用可能にする
setopt no_beep              # ビープ音を消す
setopt ignore_eof           # C-dを無効化
setopt list_packed          # 表示をコンパクトに

# lazy load
zsh-defer source "$ZDOTDIR/hooks/lazy.zsh"

# prompt
source "$ZDOTDIR/hooks/prompt.zsh"

# greeting
source "$ZDOTDIR/hooks/greeting.zsh"
zsh_greeting
