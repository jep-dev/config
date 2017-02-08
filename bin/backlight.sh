#!/bin/bash

if [ -z $1 ]; then
	exit 0
fi

cur=$(cat /sys/class/backlight/intel_backlight/brightness)
max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
cur_pc=$(echo "scale=2; $cur * 100 / $max" | bc)

case "$1" in
	'+' )
		[ -z "$2" ] && set -- "$1" 2
		new_pc=$(echo "scale=2; $cur_pc + $2" | bc)
		;;
	'-' )
		[ -z "$2" ] && set -- "$1" 1
		new_pc=$(echo "scale=2; $cur_pc - $2" | bc)
		;;
esac

if [ -z "$new_pc" ]; then
	new_pc=$(echo $1)
	# new_pc="$2"
fi

if [ $(echo "scale=2; $new_pc < 0" | bc) -eq 1 ]; then
	new_pc="0"
elif [ $(echo "scale=2; $new_pc > 100" | bc) -eq 1 ]; then
	new_pc="100"
fi

new_val=$(echo "scale=0; $new_pc * $max / 100" | bc)
# echo "old=$cur_pc; old_val=$cur; new=$new_pc; new_val=$new_val"

echo $new_val | \
	sudo cp /dev/stdin /sys/class/backlight/intel_backlight/brightness
