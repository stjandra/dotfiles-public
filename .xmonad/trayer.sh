#!/usr/bin/env bash

start_trayer() {
    trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut false --expand true --monitor 1 --transparent true --alpha 0 --tint 0x2e3440 --height 20 &
}

restart_trayer() {

    killall trayer
    start_trayer

    # Ugly hack to fix artifacts on Dropbox icon.
    sleep 8
    killall trayer
    start_trayer
}

restart_trayer &
