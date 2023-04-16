function fish_title
    set -q argv[1]; or set argv fish
    set -l pwd (fish_prompt_pwd_dir_length=1 prompt_pwd)
    echo "$pwd ❯ $argv"
end
