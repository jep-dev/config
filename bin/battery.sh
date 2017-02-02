#!/bin/bash
scale="${scale:-1}"

bat1='/sys/class/power_supply/BAT1'
bat_now=$(cat $bat1/charge_now)
bat_full=$(cat $bat1/charge_full)
# bat_pc=$(bc <<< "scale=2; $bat_now * 100 / $bat_full")
bat_pc=$(echo "scale=$scale; $bat_now * 100 / $bat_full" | bc)

echo -n "Battery: $bat_pc%"
# echo -n "$prefix$hi_prefix$bat_pc$hi_suffix$suffix"
on_ac_power && echo -n '+' || echo -n '-'

if [ $(echo "scale=0; $bat_pc < 10" | bc) -eq 1 ]; then
	$HOME/bin/urgent.sh -u critical "Battery low"
fi
