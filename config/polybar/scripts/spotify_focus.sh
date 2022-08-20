#!/bin/zsh
if [[ -n $(pgrep "spotify$") ]]; then
    IFS=: 
    echo hi
    
    read crap winid < <(grep -Eo 'Window\sid\:\s[0-9]*' <(xwininfo -int -name "$(playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}')") | tr -d '')
    unset crap
    if [[ ! -n ${winid} ]]; then
        WINNAME="Spotify Premium"
        read crap winid < <(grep -Eo 'Window\sid\:\s[0-9]*' <(xwininfo -int -name "${WINNAME}") | tr -d '')
        unset crap
    fi
    if [[ ! -n ${winid} ]]; then
        WINNAME="Spotify"
        read crap winid < <(grep -Eo 'Window\sid\:\s[0-9]*' <(xwininfo -int -name "${WINNAME}") | tr -d '')
        unset crap
    fi

    
    i3-msg "[id=$winid] focus"
else
    spotify-adblock &
    echo ih 
fi
