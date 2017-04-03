zsh-functions(){
	functions | grep -o '^[^ ^=]*[ ]\?()' | \
		sed 's/\(.*\)[ ]*()/\1/'
}
zsh-update(){
	[ "$1" = "-f" ] && export ZSHRC_FORCE=1
	source ~/.zshrc
}
sfilter(){
	script --flush -q -c "$1" /dev/null 2>/dev/null | \
		tee | grep ${${@:2}:-.*}
}

git-statuses(){
	old_pwd="$PWD"
	local dir="${1:-.}"
	local md=${2:-2}
	for d in $(find $dir -maxdepth $md -type d -regex ".*\.git\$" -print0); do
		([ -n "$d" ] && cd $d/.. && st=$(hub status -s) && \
			[ -n "$st" ] && pwd && echo "$st")
	done
}

findgrep(){
	find "${1:-.}" \! -readable -prune -o -name "${${@:2}:-.*}"
}
compgrep(){
	compgen | grep $* | columnate
}
vman(){
	man -k $* 2>&1 | grep "^$1\|^$2" && vim -c "SuperMan $*" \
		-c "%y z | bd | set buftype=nofile | 0put=@z | %!sed 's/    / /g'"
}

rand-chars(){
	m=${1:-1}
	p="${2:-[A-Za-z]}"
	j=0
	src=""
	dest=""
	while [[ "$j" -lt "$m" ]]; do
		src=$(grep -a -o "$p" -m 1 /dev/urandom | \
			tr -d '\n' | cut -b 1-$(($m-$j)))
		dest="$dest$src"
		let "j=$j+${#src}"
	done
	echo "$dest"
}
rand-line(){
	n=${1:-1}; shift
	for ((i=0;i<n;i++)); do
		for fd in $*; do
			echo -n $(head -n \
				$(($(rand-chars 16 "[0-9]") % $(wc -l <$fd))) <$fd | \
				tail -n 1 | tr -d '\r')' '
		done
		echo
	done
}
wrap-to(){
	local cols=${1:-5}
	#local len=$((${2:-$COLUMNS}/cols))
	local lsep=${3:-$'\u2595'' '}
	local rsep=${4:-' '$'\u258f'}
	len=$((${2:-$COLUMNS}/cols-${#lsep}-${#rsep}))
	local j=0
	local pre=$'\u2025'
	local post=$pre
	local i=''
	while read i; do
		local indent=''
		local first=1
		while [ "${#i}" -gt 0 ] || [ $first -eq 1 ]; do
			cur_len=$((len-${#indent}))
			if [ ${#i} -gt $cur_len ]; then
				abbr_len=$((len-${#post}-${#indent}))
				line=${i:0:$abbr_len}$post
				i=${i:$abbr_len}
			else
				line=$i
				i=''
			fi
			let "first=0"
			printf '%s%s%-'$cur_len's%s\n' "$lsep" "$indent" "$line" "$rsep"
			#printf $lsep'%s%-'$cur_len's'$rsep'\n' \
			#	"$indent" "$line"
			indent=$pre
		done
	done
}
columnate(){
	local cols=${1:-5}
	lines="$(wrap-to $cols $2)"
	local n=$(wc -l <<<$lines)
	local m=$((n/cols+1))
	local lsep=${3:-$'\u2595'' '}
	local rsep=${4:-' '$'\u258f'}

	local usep="$(printf '%'$((${2:-$COLUMNS}-1-${#lsep}-${#rsep}))'s ' '')"
	local bsep=' '$(sed 's/ /'$(printf '\u23ba')'/g' <<<$usep)'\n'
	usep=' '$(sed 's/ /_/g' <<<$usep)'\n'
	n=$(wc -l <<<$lines)
	local -a arr=()

	empty=$(echo|wrap-to $cols $2)
	echo $lines | { k=1; while read line; do arr[k]=$line; let "k++"; done }
	echo -n $usep
	for ((row=0;row<m;row++)); do
		for ((col=0;col<cols;col++)); do
			line=${arr[col*m+row+1]}
			[ -z "$line" ] && printf '%s' $empty || printf '%s' $line
		done
		echo
	done
	echo -n $bsep
}

comments(){
	args=""
	langs=""
	files=()
	lines=0
	skip=0
	invert=0
	for arg in $*; do
		if [[ "$skip" -gt 0 ]]; then
			langs+="${arg//,/\\n}"
			skip=0
		else
			case "$arg" in
				-v ) invert=1 ;;
				-l=* ) langs+="${${arg//-l=/}//,/\\n}" ;;
				-l ) skip=1 ;;
				-n ) lines=1 ;;
				* ) files+=$arg ;;
			esac
		fi
	done

	echo "$langs" | { while read lang; do
		if [[ "$invert" -gt 0 ]]; then
			case "$lang" in
				C ) cat -n $files | sed 's/\/\/.*//g' ;;
				C++ ) cat -n $files | sed 's/\/\*.*\*\///g' ;;
				* ) ;;
			esac
		else
			case "$lang" in
				C ) cat -n $files | perl -lne 'print if /\/\// .. /$/' | \
					sed 's/\([ \t]*[0-9]*[ \t]*\).*\(\/\/.*\)/\1\2/g' ;;
				C++ ) cat -n $files | perl -lne 'print if /\/\*/ .. /\*\//' | \
					sed 's/\([ \t]*[0-9]*[ \t]*\).*\(\/\*.*\*\/\).*/\1\2/g' ;;
				* ) cat -n $files ;;
			esac
		fi
	done }
}

nongrep(){grep $* | grep -v grep}
nm-filter(){nm -gC $1 | grep ".* $2 .*"}
demangle(){nm -S --demangle "$1" | cut -d ' ' -f3-}

to_hex(){
	val=${1:-0}; len=${2:-8}
	val=$((val%(16**len)))
	src="0123456789abcdef"
	i=0
	while [ "$i" -lt $len ] && [ $val -ge 0 ] ; do
		echo -n ${src[val%16+1]}
		val=$((val/16))
		let "i++"
	done | rev && echo
}

prompt_chars() {
	local bt_prompt_chars="$BULLETTRAIN_PROMPT_CHAR"
	if [[ $BULLETTRAIN_PROMPT_ROOT == true ]]; then
		bt_prompt_chars="%(!.%F{${co_root:-red}}${bt_prompt_chars}.\
%F{${co_user:-green}}${bt_prompt_chars}%f)"
	fi
	if [[ $BULLETTRAIN_PROMPT_SEPARATE_LINE == false ]]; then
		bt_prompt_chars="${bt_prompt_chars}"
	fi
	echo -n $bt_prompt_chars' '
}

color-range(){
	if [ "$1" = "-a" ]; then
		sp=' '
		cols=${2:-16}
		title="\e[7m %3d \e[0m\ue0b0$sp"
		printf "  $sp"
		printf "$sp\e[7m%2d \e[0m" {0..$((cols-1))}
		echo
		for i ({0..255..$cols}) \
			printf "%3i" $i && \
			printf "\e[48;5;232m$sp\e[48;5;%dm   \e[0m" \
				{$i..$((i+cols-1))} \
			&& echo
	else
		while [ $# -gt 1 ]; do
			j=1
			for ((i=$1;i<$2;i++)); do
				if [ "$j" -eq 1 ]; then
					printf " $i"
				fi
				if [[ $j -eq 10 ]]; then
					j=0
				fi
				printf "\e[38;5;"$i"m\u2588\e[0m"
				let "j++"
			done
		shift 2
		done
	fi
}

gmkd2html(){
	ifname="${1:-README.md}"
	ofname="${2:-${ifname//.md/.html}}"
	echo "<body class=markdown-body>" >$ofname
	github-markdown $ifname -f gfm -h >>$ofname
	echo "</body>" >>$ofname
}
