#!/usr/bin/zsh

bold='#[bold]'
def='#[default]'
none='#[none]'
inv='#[reverse]'

# Config
# vert=$'\u26fe'' ' # user/host separator
vert=$'\u26fe'' ' # user/host separator
lbra=$'\ue0b2' # left bracket
rbra=$'\ue0b0' # right bracket
# cb=(252 255 240 236) # backgrounds
#cb=(53 88 53 18 22)
cb=(53 52 52 53 18 22)
ci=( 1  2  1  0  0 -1) # bg index jump table
sw=2 # index of center segment

cf=($(for i (${cb[@]}) echo $((i>245?232:255))))
bk='#[fg=0]'
cf=('colour'${^cf})
cb=('colour'${^cb})
cn=${#cb}

{
	printf '%s\n%s %s %s\n' "$(battery.sh -g)" "$USER" "$vert" "$HOST"
	ps ho args t $(tmux display -p -F '#{pane_tty}')
} | {
	j=1
	while read i; do
		fmb='#[bg='${cb[j]}']'; fmab=${fmb//bg/fg}
		fmf='#[fg='${cf[j]}']'; fmaf=${fmf//fg/bg}
		[ $j -ge $sw ] && post=$fmab$rbra && pre=$inv$bk$fmab$rbra$def
		[ $j -le $sw ] && pre=$bk$fmab$lbra
		[ $j -lt $sw ] && post=$inv$bk$fmab$lbra$def
		printf '%s' $pre$fmb$fmf' '$i' '$def$post$def
		[ ${ci[j]} -ne 0 ] && dj=${ci[j]}
		j=$((j+dj))
		#j=$((j+ci[j]))
	done
}
