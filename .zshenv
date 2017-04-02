zsh-functions(){
	functions | grep -o '^[^ ^=]*[ ]\?()' | \
		sed 's/\(.*\)[ ]*()/\1/'
}
zsh-aliases(){
	alias | sed 's/^\([^=]*\).*/\1/'
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
	man -k $* 2>&1 | grep "^$1\|^$2" \
		&& vim -c "SuperMan $*" \
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
		for fd in ${*:-/dev/stdin}; do
			echo -n $(head -n $(($(rand-chars 16 "[0-9]") % $(wc -l <$fd))) <$fd \
				| tail -n 1 | tr -d '\r')' '
		done
		echo
	done
}
wrap-to(){
	local cols=${1:-5}
	local len=$((${2:-$COLUMNS}/cols))
	local lsep=$'\u2595'' '
	local rsep=' '$'\u258f'
	len=$((len-${#lsep}-${#rsep}))
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

	local usep="$(printf '%'$((${2:-$COLUMNS}-3))'s ' '')"
	local bsep=' '$(sed 's/ /'$(printf '\u23ba')'/g' <<<$usep)'\n'
	usep=' '$(sed 's/ /'$(printf '\u23bd')'/g' <<<$usep)'\n'
	#local n=${#lines}
	#for ((k=0;k<$((n-m*cols));k++)); do lines="$lines\n"; done
	#let "n=$n+$((n-m*cols))"
	n=$(wc -l <<<$lines)
	#echo "$n lines, $m lines/column, $((m)) - $((m+m)) in first column"
	local -a arr=()

	empty=$(echo|wrap-to $cols $2)
	echo $lines | { k=1; while read line; do arr[k]=$line; let "k++"; done }
	echo -n $usep
	for ((row=0;row<m;row++)); do
		for ((col=0;col<cols;col++)); do
			line=${arr[col*m+row+1]}
			[ -z "$line" ] && printf '%s' $empty || printf '%s' $line
			#echo -n ${arr[col*m+row+1]}
		done
		echo
	done
	echo -n $bsep

#	local k=0
#	local l=0
#	while [ ${#lines} -gt 0 ]; do
#		let "k++"
#		arr[k]=$(head -n $m<<<$lines)
#		#lines=$(tail -n $((n-m)))
#		n=$((n-m))
#		lines=$(tail -n $n)
#	done
#	for ((i=0;i<m;i++)); do
#		for ((j=0;j<cols;j++)); do
#			col=${arr[j+1]}
#			printf "$(head -n $((i+1)) <<<${arr[j+1]} | tail -n1)"
#		done
#		echo
#	done


	#echo ${lines[1]}, ${lines[2]}
	#echo $(head -n 1 <<< $lines), $(head -n2 <<<$lines | tail -n1)
	#echo "n=$n; m=$m; lines:\n$lines"
#	for ((i=0;i<m;i++)); do
#		for ((j=0;j<cols;j++)); do
#			printf "%s" "$(head -n $((i*cols+j+1)) <<< $lines | tail -n 1)"
#		done
#		echo
#	done
}

find-definitions(){
	irhn "^[ \t]*.*(.*);\|^[ \t].*typedef.*\|^[ \t]*using.*" ${*:-include}
}
numbered(){
	lines=0
	files=""
	for arg in $*; do
		case "$arg" in
			-n ) lines=1 ;;
			-* ) ;;
			* ) files+="$arg " ;;
		esac
	done
	for i in $files; do
		file="$(echo $i | xargs)"
		if [[ "$lines" -gt 0 ]]; then
			cat -n "$file"
		else
			cat "$file"
		fi
	done
}

comments(){
	args=""
	langs=""
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
				* ) ;;
			esac
		fi
	done

	echo "$langs" | { while read lang; do
		if [[ "$invert" -gt 0 ]]; then
			case "$lang" in
				C ) numbered $* | sed 's/\/\/.*//g' ;;
				C++ ) numbered $* | sed 's/\/\*.*\*\///g' ;;
				* ) ;;
			esac
		else
			case "$lang" in
				C ) numbered $* | perl -lne 'print if /\/\// .. /$/' \
					| sed 's/\([ \t]*[0-9]*[ \t]*\).*\(\/\/.*\)/\1\2/g' ; ;;
				C++ ) numbered $* | perl -lne 'print if /\/\*/ .. /\*\//' \
					| sed 's/\([ \t]*[0-9]*[ \t]*\).*\(\/\*.*\*\/\).*/\1\2/g' ; ;;
				* ) numbered $* ; ;;
			esac
		fi
	done }
}

nongrep(){
	grep "$*" | grep -v grep
}

set-grep(){
	grep $* -a <(set)
}

nm-filter() {
	nm -gC $1 | grep ".* $2 .*"
}
demangle(){
	nm -S --demangle "$1" | cut -d' ' -f3-
}

dpkg-grep(){
	dpkg -l | grep "$1" | cut -d ' ' -f 3
}
hi(){
	lhs="\\\\e[7m"
	rhs="\\\\e[0m"
	line=""
	line_no=0
	pattern_no=1
	patterns=""
	pattern="$1"
	while read line; do
		any=0
		let "line_no++"
		while [[ "$#" -gt 0 ]]; do
			if [ echo $line | grep "$1" ]; then
				let "any=1"
			fi
			let "pattern=$1"
			shift
		done
		printf "%3d: %s\n" $line_no "$line"
	done
}
hi-make(){
	make $* | hi "\-o [^ ].*"
}
read-chars(){
	while [ $# -gt 0 ]; do
		for ((i=0;i<${#1};i++)); do
			echo "${1:$i:1}"
		done
		shift
		read-chars $*
	done
}
count-chars(){
	sed 's/\(.\)/\1\n/g' | \
		{i=0; while read j; do let "i=i+1"; done; echo $i}
}

to_hex(){
	val=${1:-0}
	len=${2:-2}
	src="0123456789abcdef"
	dest=""
	i=0
	val=$((val%(16**len)))
	while [ "$i" -lt $len ] && [ $val -ge 0 ] ; do
		dest=${src[val%16+1]}$dest
		val=$((val/16))
		let "i++"
	done
	echo $dest
}

prompt_chars() {
	local bt_prompt_chars
	bt_prompt_chars=""
	#if [[ ${#BULLETTRAIN_PROMPT_CHAR} -eq 1 ]]; then
		bt_prompt_chars="$BULLETTRAIN_PROMPT_CHAR"
	#fi
	if [[ $BULLETTRAIN_PROMPT_ROOT == true ]]; then
		bt_prompt_chars="%(!.%F{${co_root:-red}}${bt_prompt_chars}.%F{${co_user:-green}}${bt_prompt_chars}%f)"
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
			printf "\e[48;5;232m$sp\e[48;5;%dm   \e[0m" {$i..$((i+cols-1))} \
				&& echo
	else
		while [ $# -gt 1 ]; do
			j=1
			for ((i=$1;i<$2;i++,j++)); do
				if [[ $j -eq 1 ]]; then
					printf " $i"
				fi
				if [[ $j -eq 10 ]]; then
					j=0
				fi
				printf "\e[38;5;"$i"m\u2588\e[0m"
			done
		shift 2
		done
	fi
}

hrule(){
	for (( i=0; i<$COLUMNS; i++ )); do
		echo -n "."
	done
}

gmkd2html(){
	ifname="${1:-README.md}"
	ofname="${2:-${ifname//.md/.html}}"
	echo "<body class=markdown-body>" >$ofname
	github-markdown $ifname -f gfm -h >>$ofname
	echo "</body>" >>$ofname
}
