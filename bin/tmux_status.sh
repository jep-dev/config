#!/usr/bin/zsh

dim='#[dim]'
bold='#[bold]'
def='#[default]'
none='#[none]'
inv='#[reverse]'
bk='#[fg=0]'

# Config
vert=' '$'\u2731'' ' # host/user separator
lbra=$'\ue0b2' # lhs segment separator
rbra=$'\ue0b0' # rhs segment separator

join_segments(){
	sw=${1:-2}
	cb=('#ffb265' '#ff6565' '#ffb265' '#feff65' '#b2ff65' '#66ff65' '#65ffb2'
		'#65feff' '#65b2ff' '#6566ff' '#b265ff' '#ff65fe' '#ff65b2' '#ff6565')
	ci=(1 0 1 0 0 0 0 0 0 0 0 0 0 -11)
	cf=('colour'${^cf})
	cn=${#cb}

	j=1
	while read i; do
		fmb='#[bg='${cb[j]}']'; fmab=${fmb//bg/fg}
		#fmf='#[fg='${cf[j]}']'; fmaf=${fmf//fg/bg}
		fmf='#[fg=colour232]'; fmaf=${fmf//fg/bg}
		[ $j -ge $sw ] && post=$fmab$rbra && pre=$inv$bk$fmab$rbra$def
		[ $j -le $sw ] && pre=$bk$fmab$lbra
		[ $j -lt $sw ] && post=$inv$bk$fmab$lbra$def
		printf '%s' $pre$fmb$fmf' '$i' '$def$post$def
		[ ${ci[j]} -ne 0 ] && dj=${ci[j]}
		j=$((j+dj))
	done
}

side=${1:-'-l'}
if [ "$side" = "-l" ]; then
	{
		printf '%s\n' "$(battery.sh -g)" "$HOST$vert$USER"
		ps ho args t $(tmux display -p -F '#{pane_tty}')
		#echo -n {a..x}'\n'
	} | join_segments
elif [ "$side" = '-r' ]; then
	time.sh 'wide' | join_segments 1
fi
