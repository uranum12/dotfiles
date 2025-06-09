# my cli tools

## build

```sh
conan install . --output-folder=build --build=missing --settings=build_type=Release
cmake -G Ninja -B build --preset conan-release
```

