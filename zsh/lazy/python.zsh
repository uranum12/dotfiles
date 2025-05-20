# python
function py() {
    if [[ -n $VIRTUAL_ENV ]]; then
        $VIRTUAL_ENV/bin/python "$@"
    elif [[ -f ".venv/bin/python" ]]; then
        .venv/bin/python "$@"
    elif [[ -f "poetry.lock" ]]; then
        poetry run python "$@"
    elif [[ -f "Pipfile.lock" ]]; then
        pipenv run python "$@"
    elif [[ -f "pdm.lock" ]]; then
        pdm run python "$@"
    elif command -v uv >/dev/null 2>&1; then
        uv run "$@"
    else
        python "$@"
    fi
}
