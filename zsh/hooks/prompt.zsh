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
