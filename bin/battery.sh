#!/usr/bin/zsh

scale="${scale:-1}"
bat1='/sys/class/power_supply/BAT1'
cur=$(cat $bat1/charge_now)
max=$(cat $bat1/charge_full)

empty=$'\u25a2'
blocks=($'\u25a7' $'\u25a9' $'\u25a0')
last=${#blocks}
min=$((last-1))
maj=10
space=''
#charging=$'\u2296'
#on_ac_power && charging=$'\u2295'
charging='-'
on_ac_power && charging='+'
if [ "$1" = "-g" ]; then
	split=($(echo "scale=3; a=$cur/$max*$maj;" \
		"scale=0; maj=a/1; min=a%1*$min; maj\nmin/1" | bc))
	out=''
	for ((i=0;i<$maj;i++)); do
		if [ "$i" -lt "${split[1]}" ]; then out+=${blocks[last]}$space
		elif [ "$i" -eq "${split[1]}" ]; then out+=${blocks[${split[2]}+1]}$space
		else out+=$empty$space; fi
	done
	echo -n "$out $charging"
else
	pc=$(echo "scale=$scale; $cur * 100 / $max" | bc)
	prefix="${1:-}"
	suffixes=($(printf '\u26A1\n-'))
	on_ac_power
	suffix=" ${suffixes[$?+1]}${2:-}"
	printf "$prefix$pc%%$suffix"
fi

