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
sw=2 # index where lhs/rhs segment separator switches

join_segments(){
	cb=('#bf9f3f' '#bf3f3f'
		'#bf9f3f' '#7fbf3f'
		'#3fbf5f' '#3fbfbf'
		'#3f5fbf' '#7f3fbf'
		'#bf3f9f' '#bf3f3f')
	cf=(16 16 16 16 16 16 16 16 16 16)
	ci=( 1  0  1  0  0  0  0  0  0 -7)
	cf=('colour'${^cf})
	cn=${#cb}

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
	done
}

side=${1:-'-l'}
if [ "$side" = "-l" ]; then
	{
		printf '%s\n' "$(battery.sh -g)" "$HOST$vert$USER"
		ps ho args t $(tmux display -p -F '#{pane_tty}')
		#echo -n {a..q}'\n'
	} | join_segments
elif [ "$side" = '-r' ]; then
	{ echo && time.sh 'wide' } | join_segments
fi
