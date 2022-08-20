#!/bin/zsh

source ~/.zshenv

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
for i in `ls ~/bar*.log`; do
    mv $i $i.old
done

read mon <<< "$(polybar -m | wc -l)"

if [[ ${mon} > 2 ]]; then 
    polybar -r bar-left --log=trace &> ~/barL.log & 
    polybar -r bar-right --log=trace &> ~/barR.log &
    polybar -r bar-center --log=trace &> ~/barC.log &

elif [[ ${mon} >1 ]]; then 
    read -d ' ' monA monB < <(awk -F: '{print $1}' <(polybar -m))

    # always there
    polybar bar-center &> ~/barC.log &
    if [[ ${monB} == ${SCREEN_LEFT} ]]; then
        polybar bar-left &> ~/barL.log &
    elif [[ ${monB} == ${SCREEN_RIGHT} ]]; then
        polybar bar-right ~/barR.log &
    fi
else    
    polybar bar-center &> ~/barC.log &
fi
