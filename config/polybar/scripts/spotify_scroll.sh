
#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 20 \
        --delay 0.3 \
        --scroll-padding "  " \
        --match-command "$HOME/.config/polybar/scripts/spotify.sh --status" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "$HOME/.config/polybar/scripts/spotify.sh" &

wait