#!/bin/bash

usage(){
	echo "Usage: [$(dirname $0)/]$(basename $0) [[+|-] percentage]"
	exit 1
}
isfloat(){
	return $(echo "$1" | grep -Eq '^[0-9]+\.?[0-9]*$|^\.[0-9]+$')
}

bl="/sys/class/backlight"
raw=$(dirname $(grep -l raw "$bl"/*/type | head -n 1))
br=($(cat "$raw"/{,max_}brightness))
cur_pc=$(echo "scale=2; ${br[0]} * 100 / ${br[1]}" | bc)
[ -z "$1" ] && echo "$cur_pc%" && exit 0
if [ -z "$2" ]; then
	isfloat "$1" && new_pc="$1" || usage
elif [[ "$1" = '+' ]] || [[ "$1" = '-' ]]; then
	isfloat "$2" && new_pc=$(echo "scale=2; $cur_pc $1 $2" | bc) || usage
else
	usage
fi

new_pc=$(echo "scale=2; if($new_pc < 0) 0 else if($new_pc > 100) 100 else $new_pc" | bc)
new_val=$(echo "scale=0; $new_pc * ${br[1]} / 100" | bc)
sudo cp /dev/stdin "$raw"/brightness <<<$new_val
