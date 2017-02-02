#!/bin/bash

if [ -z $1 ]; then
	exit 0
fi

cur=$(cat /sys/class/backlight/intel_backlight/brightness)
max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
cur_pc=$(echo "scale=2; $cur * 100 / $max" | bc)
# cur_pc=$(($cur * 100 / $max))
# cur_rem=$(($(($cur * 100)) % $max / 100))

case "$1" in
	'+' )
		if [ -z "$2" ]; then
			set -- "$1" 2
		fi
		new_pc=$(echo "scale=2; $cur_pc + $2" | bc)
		# new_pc=$(($cur_pc + $2));
		;;
	'-' )
		if [ -z "$2" ]; then
			set -- "$1" 1
		fi
		new_pc=$(echo "scale=2; $cur_pc - $2" | bc)
		# new_pc=$(($cur_pc - $2));
		;;
esac

if [ -z "$new_pc" ]; then
	let "new_pc=$1"
	# new_pc="$2"
fi

if [ $(echo "scale=2; $new_pc < 0" | bc) -eq 1 ]; then
	new_pc=0
elif [ $(echo "scale=2; $new_pc > 100" | bc) -eq 1 ]; then
	new_pc=100
fi

new_val=$(echo "scale=0; $new_pc * $max / 100" | bc)
# echo "old=$cur_pc; old_val=$cur; new=$new_pc; new_val=$new_val"

echo $new_val | \
	sudo cp /dev/stdin /sys/class/backlight/intel_backlight/brightness
