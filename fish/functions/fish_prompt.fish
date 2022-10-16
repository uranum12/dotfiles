function fish_prompt
    # status
    if test $status -eq 0
        set_color 5FD700 | read -f color_status
    else
        set_color FF0000 | read -f color_status
    end

    # pwd
    set_color -o 00AFFF | read -f color_anchors
    set_color 0087AF | read -f color_dirs
    set -f pwd_markers .git .svn .node-version .python-version .tool-versions Cargo.toml go.mod package.json
    if set -f split_pwd (string replace -r "^$HOME" '~' $PWD | string split /)
        set -f split_output $split_pwd[1..]
	set split_output[-1] "$color_anchors$split_output[-1]$color_dirs"
    else
        set -f split_output $color_anchors'~'
    end
    i=1 for dir_section in $split_pwd[2..-2]
        string join / $split_pwd[..$i] | string replace '~' $HOME | read -l parent_dir
        math $i+1 | read i
	if path is $parent_dir/$dir_section/$pwd_markers
	    set split_output[$i] "$color_anchors$dir_section$color_dirs"
	end
    end

    # git
    set_color normal | read -f color_reset
    set_color 5FD700 | read -f color_location
    if git branch --show-current 2>/dev/null | read -f location
        set location $color_location$location
    else if test $pipestatus[1] != 0
        set -f location ""
    else if git tag --points-at HEAD | string join ' ' | read -fa location
	set location (string join ' ' '#'$color_location{$location}$color_reset)
    else
        git rev-parse --short HEAD | read -f location
        set location @$color_location$location
    end

    echo
    echo (string join / "$color_dirs$split_output[1]" $split_output[2..]) $color_reset$location
    echo -n $color_status'❯ '$color_reset
end
