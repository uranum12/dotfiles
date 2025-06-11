# my cli tools

## build

```sh
meson setup build --prefix $HOME/.local
meson compile -C build
meson install -C build --skip-subprojects
```

