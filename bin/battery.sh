#!/usr/bin/zsh

scale="${scale:-1}"
bat1='/sys/class/power_supply/BAT1'
cur=$(cat $bat1/charge_now)
max=$(cat $bat1/charge_full)

empty=$'\u25a2'
#blocks=($'\u25a7' $'\u25a9' $'\u25a0')
#last=${#blocks}
#min=$((last-1))
maj=10
#space=''
#charging=$'\u2296'
#on_ac_power && charging=$'\u2295'

#charging='-'
#on_ac_power && charging='+'
#charging=$'\u3280'
#on_ac_power && charging=$'\u3289'
charging=$'\u26a1'
on_ac_power || charging=$'\u2718'

if [ "$1" = "-g" ]; then
	case "${2:-3}" in
		1) blocks=($'\u25a7' $'\u25a9' $'\u25a0')
			empty=$'\u25a2'
			;;
		2) blocks=('\u24ea ' '\u2460 ' '\u2461 ' '\u2462 ' '\u2463 ' '\u2464 '
			'\u2465 ' '\u2466 ' '\u2467 ' '\u2468 ' '\u3248 ') #'\u2469 ')
			empty='\u24ea '
			;;
		3) blocks=('\u2bcf' '\u2bcd' '\u2b1b')
			#empty='\u2bcf'
			empty='\u2b1e'
			;;
		*) blocks=(' ' '#')
			empty=' '
			;;
	esac
	last=${#blocks}
	min=$((last-1))
	#cur=53
	#max=100
	split=($(echo "scale=3; a=$cur/$max*$maj;" \
		"scale=0; maj=a/1; min=a%1*$min; maj\nmin/1" | bc))
	out=''
	for ((i=0;i<$maj;i++)); do
		if [ "$i" -lt "${split[1]}" ]; then out+=${blocks[last]}$space
		elif [ "$i" -eq "${split[1]}" ]; then out+=${blocks[${split[2]}+1]}$space
		else out+=$empty$space; fi
	done
	echo -n "$charging $out"
else
	pc=$(echo "scale=$scale; $cur * 100 / $max" | bc)
	prefix="${1:-}"
	suffixes=($(printf '\u26A1\n-'))
	on_ac_power
	suffix=" ${suffixes[$?+1]}${2:-}"
	printf "$prefix$pc%%$suffix"
fi

