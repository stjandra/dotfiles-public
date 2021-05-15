#!/usr/bin/env bash

output() {
    echo "$@"
}

# The internal laptop display
internal="eDP1"
DP3="DP3"
DP2="DP2"

# Get connected screens.
mapfile -t screens < <( xrandr | grep " connected " | awk '{ print$1 }' )

output "${screens[*]}"

if [[ ${#screens[@]} == 1 ]]; then
    # Disable other outputs.
    output "Only 1 screen."
    xrandr --output "${screens[0]}" --primary
    xrandr --output "$DP2" --off
    xrandr --output "$DP3" --off
    exit 0
fi

if [[ " ${screens[*]} " =~ " ${DP3} " ]]; then
    # Set DP3 above internal.
    output "Has $DP3"
    xrandr --output "$DP3" --auto --above "$internal"
    xrandr --output "$DP3" --primary
fi

if [[ " ${screens[*]} " =~ " ${DP2} " ]]; then
    # Set DP2 to the left of internal.
    output "Has $DP2"
    xrandr --output "$DP2" --auto --left-of "$internal"
    xrandr --output "$DP2" --primary
fi
