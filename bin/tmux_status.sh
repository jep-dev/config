#!/usr/bin/zsh

dim='#[dim]'
bold='#[bold]'
def='#[default]'
none='#[none]'
inv='#[reverse]'
bk='#[fg=0]'

# Config
vert=' '$'\u273b'' ' # host/user separator
lbra=$'\ue0b2' # lhs segment separator
rbra=$'\ue0b0' # rhs segment separator
sw=2 # index where lhs/rhs segment separator switches

cb=(
'#320f56'
'#0f2156'
'#320f56'
'#560f0f'
'#560f0f'
'#56440f'
'#33560f'
'#0f5621'
'#0f5656'
'#0f2156'

#	'#f7d46d'
#	'#f76d6d'
#	'#f7d46d'
#	'#b2f76d'
#	'#6df790'
#	'#6df7f7'
#	'#6d90f7'
#	'#b26df7'
#	'#f76dd4'
#	'#f76d6d'

# dark to light
#'colour208' 'colour202' 'colour208' 'colour214' 'colour220' 'colour221' 'colour222'
# light to dark
#'colour220' 'colour222' 'colour220' 'colour214' 'colour208' 'colour202' 'colour208'
)
cf=(15 15 15 15 15 15 15 15 15)
ci=( 1  0  1  0  0  0  0  0 -6)
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
