#!/usr/bin/zsh

bold='#[bold]'
def='#[default]'
none='#[none]'
inv='#[reverse]'
bk='#[fg=0]'

# Config
vert=' @ '
#vert=$'\u26fe'' ' # user/host separator
lbra=$'\ue0b2' # left bracket
rbra=$'\ue0b0' # right bracket

#cb=(24 28 24 55 160 166 100 28) # backgrounds
#cf=(15 15 15 15  15  15  15 15)
# ci=( 1  0   1  0  0   0   0  -4) # bg index direction

#cb=( 95 203  95 101 247)
#cb=( 95 131 95  65 143 143)
#cf=( 16  16 16  16  16  16)
#ci=(  1   0  1   0   1  -1)
sw=2 # index of center segment

#cf=($(for i (${cb[@]}) echo $((i>245?232:255))))
#cf=('colour'${^cf})
#cb=('colour'${^cb})

cb=('#993380' '#993333' '#993380' '#663399' '#334d99' '#339999' \
	'#33994d' '#338899' '#33995e' '#559933' '#999133' '#993333')
cf=(16 16 16 16 16 16 16 16 16 16 16 16)
ci=( 1  0  1  0  0  0  0  0  0  0  0 -9)
cf=('colour'${^cf})

cn=${#cb}

{
	printf '%s\n%s%s%s\n' "$(battery.sh -g)" "$USER" "$vert" "$HOST"
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
