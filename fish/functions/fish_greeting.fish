function fish_greeting
    set c red green yellow blue magenta cyan white brred brgreen bryellow brblue brmagenta brcyan brwhite
    set o (set_color $c[(math (random) % (count $c) + 1)])
    set m (set_color $c[(math (random) % (count $c) + 1)])
    set i (set_color $c[(math (random) % (count $c) + 1)])
    set b (set_color blue)
    set n (set_color normal)
    echo '                 '$o'___'
    echo '  ___======____='$m'-'$i'-'$m'-='$o')'
    echo '/T            \_'$i'--='$m'=='$o')'
    echo '[ \ '$m'('$i'O'$m')   '$o'\~    \_'$i'-='$m'='$o')'
    echo ' \      / )J'$m'~~    '$o'\\'$i'-='$o')'
    echo '  \\\\___/  )JJ'$m'~'$i'~~   '$o'\)'
    echo '   \_____/JJJ'$m'~~'$i'~~    '$o'\\'
    echo '   '$m'/ '$o'\  '$i', \\'$o'J'$m'~~~'$i'~~     '$m'\\'
    echo '  (-'$i'\)'$o'\='$m'|'$i'\\\\\\'$m'~~'$i'~~       '$m'L_'$i'_'
    echo '  '$m'('$o'\\'$m'\\)  ('$i'\\'$m'\\\)'$o'_           '$i'\=='$m'__'
    echo '   '$o'\V    '$m'\\\\'$o'\) =='$m'=_____   '$i'\\\\\\\\'$m'\\\\'
    echo '          '$o'\V)     \_) '$m'\\\\'$i'\\\\JJ\\'$m'J\)'
    echo '                      '$o'/'$m'J'$i'\\'$m'J'$o'T\\'$m'JJJ'$o'J)'$b'  ┌─┐┬┌─┐┬ ┬'
    echo '                      '$o'(J'$m'JJ'$o'| \UUU)'$b'  ├┤ │└─┐├─┤'
    echo '                       '$o'(UU)      '$b'  └  ┴└─┘┴ ┴'$n
end



