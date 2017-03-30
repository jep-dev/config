#!/usr/bin/zsh

dim='#[dim]'
bold='#[bold]'
def='#[default]'
none='#[none]'
inv='#[reverse]'
bk='#[fg=0]'

# Config
#vert=' @ '
#vert=' '$'\u24ff''  '
#vert=' '$'\u2b9e'' '
#vert=' '$'\u2b50'' '
#2aa2 29c1
#vert=' '$inv' '$'\u29c1'' '$none' '
#vert=' '$'\u2847'' '
vert=' '$'\u273e'' '
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

#cb=('#862d59' '#862d2d' '#862d59' '#862d86' '#592d86' '#2d2d86' '#2d5986' \
#	'#2d8686' '#2d8659' '#2d862d' '#59862d' '#86862d' '#86592d' '#862d2d')
#cb=('#2d8659' '#2d8686' '#2d8659' '#2d862d' '#59862d' '#86862d' '#86592d' \
#	'#862d2d' '#862d59' '#862d86' '#592d86' '#2d2d86' '#2d5986' '#2d8686')
#cf=(15 15 15 15 15 15 15 15 15 15 15 15 15  15)
#ci=( 1  0  1  0  0  0  0  0  0  0  0  0  0 -11)
#cb=('#4d1f7a' '#1f367a' '#4d1f7a' '#7a1f63' '#7a1f1f'
#	'#7a631f' '#4d7a1f' '#1f7a36' '#1f7a7a' '#1f367a')
cb=(
'#f7d46d'
'#f76d6d'
'#f7d46d'
'#b2f76d'
'#6df790'
'#6df7f7'
'#6d90f7'
'#b26df7'
'#f76dd4'
'#f76d6d'
)
#cf=(15 15 15 15 15 15 15 15 15 15)
cf=(16 16 16 16 16 16 16 16 16 16)
ci=( 1  0  1  0  0  0  0  0  0 -7)
#cb=(214 208 214 221 222 223)
#cf=( 16  16  16  16  16  16)
#ci=(  1   0   1   0   0  -1)
#cb=('colour'${^cb})
cf=('colour'${^cf})

cn=${#cb}

{
	printf '%s\n' "$(battery.sh -g)" "$HOST$vert$USER"
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
