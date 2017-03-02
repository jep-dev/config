#!/bin/bash

bat="$(battery.sh)"

pane_pid="$(tmux display -p '#{pane_pid}')"
sep=$(printf " \u26a1 ")
lbra=$(printf "\ue0b3")
rbra=$(printf "\ue0b1")

pane_ps="$(pstree -Ap $pane_pid)"
last_pid="$(sed 's/.*(\([0-9]*\))$/\1/' <<< $pane_ps)"
last_args="$(ps --no-headers -o args -p $last_pid)"

printf "%7s%10s$sep%-10s $lbra%s$rbra%5s%s%5s%s" \
	"$bat" "$(uname -n)" "$USER" "$PWD" "" "$pane_ps" "" "($last_args)"
