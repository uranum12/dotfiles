# path
typeset -U path
path=(
    "$HOME/.deno/bin"(N-/)
    "$HOME/.bun/bin"(N-/)
    "$HOME/.cargo/bin"(N-/)
    "$HOME/.local/bin"(N-/)
    "$HOME/.local/share/mise/shims"(N-/)
    $path
)

