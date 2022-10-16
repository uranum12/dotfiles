function fish_greeting
    set c red green yellow blue magenta cyan white brred brgreen bryellow brblue brmagenta brcyan brwhite
    set oc $c[(math (random) % (count $c) + 1)]
    set mc $c[(math (random) % (count $c) + 1)]
    set ic $c[(math (random) % (count $c) + 1)]
    fish_logo $oc $mc $ic
end
