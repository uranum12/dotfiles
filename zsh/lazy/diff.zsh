# diff
if command -v delta >/dev/null 2>&1; then
    function dif() {
        if [[ $# -ne 2 ]]; then
            echo "Usage: dif file1 file2"
            return 1
        fi

        if [[ ! -f "$1" || ! -f "$2" ]]; then
            echo "Both arguments must be valid files."
            return 1
        fi

        diff -u "$1" "$2" | delta
    }
fi
