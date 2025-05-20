# greeting
function zsh_greeting() {
    local c="%F{$((RANDOM % 15 + 1))}"
    print -P "     %F{11}______________%f            *        /     %F{11}o%f"
    print -P "  ==%F{11}(_____(o(___(_()%f                   /"
    print -P "          /|\\\\             %F{9}o%f      |    *            *"
    print -P "         / | \\\\${c}┌─┐┌─┐┬ ┬%f         -+-        +"
    print -P "        /  |  ${c}┌─┘└─┐├─┤%f          |              %F{12}o%f"
    print -P "       /      ${c}└─┘└─┘┴ ┴%f     *          ~+"
}
