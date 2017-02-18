fpath=(~/bin/completions $fpath)

zsh-functions(){
	functions | sed -e "s/\([A-Za-z0-9_\-]\)[ ]*().*/\1/" -e "tx" -e "d" -e ":x"
}
zsh-aliases(){
	alias | sed -e "s/^\([A-Za-z0-9_\-]*\)=.*/\1/" -e "tx" -e "d" -e ":x"
}

sfilter(){
	script --flush -q -c "$1" /dev/null 2>/dev/null | \
		tee | grep ${${@:2}:-.*}
}

git-statuses(){
	old_pwd="$PWD"
	local dir="${1:-.}"
	for d in $(find $dir -type d -regex ".*\.git" -print0); do
		([ -n "$d" ] && cd $d/.. && st=$(hub status -s) && \
			[ -n "$st" ] && pwd && echo "$st")
	done
#	local cur=$(pwd)
#	local dir="${1:-.}"
#	for d in $dir $dir/*; do
#		if [ -d "$d" ] && [ -d "$d/.git" ]; then
#			pushd $d >/dev/null
#			git status -s | {
#				while read i; do
#					echo $d: $i
#				done
#			}
#			popd >/dev/null
#		fi
#	done
#	cd "$cur" >/dev/null
}

findgrep(){
	find "${1:-.}" \! -readable -prune -o -name "${${@:2}:-.*}"
}
vman(){
	man -k $* 2>&1 | grep "^$1\|^$2" \
		&& vim -c "SuperMan $*" \
		-c "%y z | bd | set buftype=nofile | 0put=@z | %!sed 's/    / /g'"
}

columnate(){
	delim=${1:-' '}
	delim_size=${#delim}
	fill=${3:-' '}
	fill_size=${#fill}
	M=${2:-$COLUMNS}
	sep_pre="\e[7m"
	sep_post="\e[0m"
	N=$(($M/2-$delim_size-${#sep_pre}-${#sep_post}))

	while read i; do
		lhs=${i%%$1*}; rhs=${i#*$1}; sep=$delim
		while [ -n "$lhs$rhs" ]; do
			lhs_head=${lhs:0:$N}; rhs_head=${rhs:0:$N}
			printf "%"$N"s"$sep_pre"%"$delim_size"s"$sep_post"%-"$N"s\n" \
				"$lhs_head" "$sep" "$rhs_head"
			lhs=${lhs:$N}; rhs=${rhs:$N}; sep=
		done
	done
}

find-definitions(){
	{ [ -z $1 ] && find include -type f || find $1 -type f } |
		{ while read i; do {
			p1="[ \t]*\(.*\)(\(.*\));"; r1="\1 (\2)"
			p2="[ \t]*\(.*typedef .*\)"; r2="\1"
			p3="[ \t]*\(.*using .*\)"; r3="\1"
			sed -e "s/$p1/$r1/" -e "tx" -e "d" -e ":x" $i
			sed -e "s/$p2/$r2/" -e "tx" -e "d" -e ":x" $i
			sed -e "s/$p3/$r3/" -e "tx" -e "d" -e ":x" $i
		}; done }
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

color-range(){
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
}

slider(){
        if [ $# -eq 1 ]; then
                local str=$(echo -n "\u2591\u2592\u2593\u2588\u2588\u2593\u2592")
                let "str_len=7"
                for ((i=0;i<$1*$UPDATE_FPS;i++)); do
                        for ((j=0;j<$COLUMNS;j++)); do
                                printf "${str:($j+$i)%$str_len:1}"
                        done
                        sleep $UPDATE_DELAY
                        echo -n "\r"
                done
                echo -n '\r'
        fi
}

hrule(){
        for (( i=0; i<$COLUMNS; i++ )); do
                echo -n "."
        done
}


progress(){
	lborder=""
	rborder=""
	filler="\u2588"
	separator="$(($1*100/$2))%"
	spacer=" "
	total=$(($COLUMNS-$#lborder-$#rborder-$#separator-1))
	filled=$(($1*$total/$2))
	empty=$(($total-$filled))
	index=$(($1*4/$2))
	startshade=""
	endshade="\e[0m"
	if [ $index -eq 0 ]; then
		startshade="\e[38;5;1m";
	elif [ $index -eq 1 ]; then
		startshade="\e[38;5;3m";
	elif [ $index -eq 2 ]; then
		startshade="\e[38;5;2m";
	else
		startshade+="\e[38;5;2m";
	fi
	echo -n "$lborder$startshade"
	for (( i=0; i<$filled; i++ )); do
		echo -n $filler
	done
	echo -n "\e[7m$separator\e[0m$startshade\ue0b0"
	for (( i=0; i<$empty; i++ )); do
		echo -n $spacer
	done
	echo -n "$endshade$rborder"
}
