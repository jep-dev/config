#!/usr/bin/zsh
#if [ -n "$ZSHRC_SOURCED" ]; then
	# Wrap lines and format to $1 columns
	columnate(){
		local cols="${cols:-${1:-5}}"
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
	# Show ranges of xterm-256 colors
	color-range(){
		ltex='\\'
		rtex='/'
		[ -z $1 ] && { ltex=' '; rtex=' '; }
		buf='\n   0 '
		z=$(printf $'\e[38;5;231m'$ltex$'\e[38;5;232m'$rtex)
		for block ({0..15}) {
			buf=$buf$(printf $'\e[48;5;'$block$'m'$z$'\e[m ')
			[ $block -eq 7 ] && buf=$buf'8 '
		}
		buf=$buf'\n\n'
		for line ({0..5}) {
			for block ({0..5}) {
				[ $((block%2)) -eq 1 ] \
					&& buf=$buf' ' \
					|| buf=$buf$(printf ' %3i ' $((16+6*(block+6*line))))
				for cell ({0..5}) {
					index=$((16+cell+6*(block+6*line)))
					buf=$buf$(printf $'\e[48;5;'$index$'m')
					[ $(((line^block^cell)%2)) -eq 0 ] \
						&& buf=$buf$(printf \
						$'\e[38;5;231m'$rtex$'\e[m') \
						|| buf=$buf$(printf \
						$'\e[38;5;232m'$ltex$'\e[m')
				}
			}
			buf=$buf'\n'
		}
		buf=$buf$'\e[m\n 232 '
		for i ({0..1}) {
			for j ({0..11}) {
				buf=$buf$(printf $'\e[48;5;'$((232+i*12+j))'m'$z$'\e[m')
			}
			buf=$buf' '
		}
		echo $buf'\n'
	}



	# Extract comments from files by language
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
			case "$lang" in
				C++ ) pattern='/\/\**/{a=1};/\*\//{b=1}'; match=$((1-invert))
					cat -n $files | awk -v'a=0' -v'b=0' \
						$pattern'{if(a=='$match') print $0; if(b) a=0 && b=0 }' ;;
				C ) irhn '[ \t]*//.*' $files ;;
				* ) ;;
			esac
		done }
	}


	# Search the path, functions, and aliases with regex
	#compgrep(){
		#compgen | grep "$1" ${*:2}
	#}
	# Extract functions from compiled objects
	demangle(){nm -S --demangle "$1" | cut -d ' ' -f3-}

	dev-grep(){
		foreach x in $devs; do
			y=({{1:-.}/*\.$x} {{1:-.}/$x\.*}) 2>/dev/null
			# y=(${1:-.}/**/*$x) 2>/dev/null
			printf '%s\n' $y
		done
	}

	# files2(){
	# 	for f ("$1") echo "$2$f" && [ -d $f ] && files2 "$(ls $2$f)" "$2"
	# }

	# Check brief statuses of git-managed subdirectories
	git-statuses(){
		old_pwd="$PWD"
		local dir="${1:-.}"
		local md=${2:-2}
		for d in $(find $dir -maxdepth $md -type d -regex ".*\.git\$" -print0); do
			([ -n "$d" ] && cd $d/.. && st=$(hub status -s) && \
				[ -n "$st" ] && pwd && echo "$st")
		done
	}
	# Convert a github markdown file to html
	gmkd2html(){
		ifname="${1:-README.md}"
		ofname="${2:-${ifname//.md/.html}}"
		echo "<body class=markdown-body>" >$ofname
		github-markdown $ifname -f gfm -h >>$ofname
		echo "</body>" >>$ofname
	}

	recent(){
		format='%T@ %h %f'
		if [ "$1" = "-l" ] || [ "$1" = "--list" ]; then
			format="$format %TA, %Tb %Td %TH:%TM"
			shift
		fi
		find ${@:-{include,src,app}/*} -type f -printf "$format\n" | uniq | sort -r | {
			nj=0
			nk=0
			nwd=0
			nm=0
			nt=0
			while read i j k w m d t; do
				aj=($aj "$j"); mj=${#j}; [[ $mj -gt $nj ]] && nj=$mj
				ak=($ak "$k"); mk=${#k}; [[ $mk -gt $nk ]] && nk=$mk
				aw=($aw "$w"); mw=${#w}; [[ $mw -gt $nw ]] && nw=$mw
				am=($am "$m"); mm=${#m}; [[ $mm -gt $nm ]] && nm=$mm
				ad=($ad "$d"); md=${#d}; [[ $md -gt $nd ]] && nd=$md
				at=($at "$t"); mt=${#t}; [[ $mt -gt $nt ]] && nt=$mt
			done
			for it ({1..${#aj}}) {
				printf "%${nj}s %-${nk}s  %${nw}s %${nm}s %2s  %${nt}s"'\n' \
					"${aj[it]}" "${ak[it]}" "${aw[it]}" "${am[it]}" "${ad[it]}" "${at[it]}"
			}
		# TODO - Why are entries doubled without another call to uniq?
		} | uniq

	}
	# loopcmd(){
	# 	while read; do $*; done
	# }
	# Search inside compiled objects
	nm-filter(){nm -gC $1 | grep ".* $2 .*"}
	# Edit best match for Makefile
	Makefile() {
		files=(${^:-${1:-.}/{Makefile,Makefile.*,*.mk}*(N)})
		$EDITOR ${${files[1]}:-./Makefile}
	}

	# Prompt Character
	prompt_chars() {
	  local bt_prompt_chars
	  bt_prompt_chars=""

	  echo -n "${BULLETTRAIN_PROMPT_CHAR}"
	#   if [[ ${#BULLETTRAIN_PROMPT_CHAR} -eq 1 ]]; then
	#     bt_prompt_chars="${BULLETTRAIN_PROMPT_CHAR}"
	#   fi

	#   if [[ $BULLETTRAIN_PROMPT_ROOT == true ]]; then
	#     bt_prompt_chars="%(!.%F{red}# .%F{green}${bt_prompt_chars}%f)"
	#   fi

	#   if [[ $BULLETTRAIN_PROMPT_SEPARATE_LINE == false ]]; then
	#     bt_prompt_chars="${bt_prompt_chars}"
	#   fi

	#   echo -n $bt_prompt_chars
	}

	# prompt_end() {
	# 	if [[ -n $CURRENT_BG ]]; then
	# 		echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
	# 	else
	# 		echo -n "%{%k%}"
	# 	fi
	# 	echo -n "%{%f%}%B"
	# 	CURRENT_BG='%{%k'$FG'%}'
	# }
	# 
	# prompt_segment() {
	#   local bg fg
	#   [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
	#   [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
	#   if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
	#     echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
	#   else
	#     echo -n "%{$bg%}%{$fg%} "
	#   fi
	#   CURRENT_BG=$1
	#   [[ -n $3 ]] && echo -n '%B '$3' '$'\u200b'
	# }

	readme() {
		files=(${^:-${1:-.}/{README,*.md}*(N)})
		$EDITOR ${${files[1]}:-./README}
	}
	# Get the first $1 random characters matching the set $2
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
	rem-query(){
		fds=${1:-'.'}
		for file in $fds; do
			# TODO
		done
	}
	# Get the first $1 random lines from the remaining args (file descriptors)
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
	# Work in progress; strips empty lines and known comments before counting lines
	sloc-real(){
		n=0
		m=0
		for arg; do
			if [ -r $arg ]; then
				ftype="Generic"
				lines=$(cat $arg)
				case $arg in
					*.[ch] | *.[cht]pp )
						ftype="C"
						if [[ "$arg" =~ '.*pp' ]]; then
							ftype="C++"
							# Overlapping comments are handled as though C++ comments take
							# precedence
							real_lines=$(tr '\n' '\r' <<<$lines \
								| sed 's/\/[*]\+[^*]*[*]\+\///g' | tr '\r' '\n' \
								| sed 's/\/\/.*//g;/^[ \t]*$/d')
							mi=$(wc -l <<<$real_lines)
							ni=$(wc -l <$arg)
							let "m=m+mi"
							let "n=n+ni"
							echo "$mi\t$ni\t$ftype\t$arg"
							# TODO fix later statements instead of repeating the above
							continue
							#real_lines=$(sed ':n N
								#:s { s/\/\*\(.*\)\*\///; Tn }
								#/\/\*/bs' <<<$lines);
						fi
						real_lines=$(sed 's/\/\/.*//' <<<$lines)
						;;
					Makefile )
						ftype="Makefile"
						real_lines="$(grep -v '^\ *#' $arg)"
						;;
					* )
						real_lines="$lines"
						#ftype="${arg//*./}"
						;;
				esac
				real_lines=$(echo $real_lines | grep -o '.*[^ ^\t].*')
				mi=$(wc -l <<<$real_lines)
				ni=$(wc -l <$arg)
				let "m=m+mi"
				let "n=n+ni"
				echo "$mi\t$ni\t$ftype\t$arg"
			fi
		done
		echo "Total: $m real lines out of $n"
	}

	# Filter the output of a (potentially) interactive subprocess
	sfilter(){
		script --flush -q -c "$1" /dev/null 2>/dev/null | \
			tee | grep ${${@:2}:-.*}
	}
	snail(){
		msg=${1-'\u1d34\u1d35'}
		printf $'\e[1m'$msg$'\U1f40c__'
	}
	countdown(){
		t0=$(date +%s)
		t1=$(date -d "$1" +%s)
		secs=$((t1-t0))
		fmt="%s is %s away.\n"
		if [[ "$t0" -ge "$t1" ]]; then
			secs=$((-1*$secs))
			fmt="%s was %s ago.\n"
		fi
		t1=$(date -d "$1" '+%R %m/%d')
		t1="${2+'$2' (}$t1${2+)}"
		#t1="${2+'$2' (}"$(date -d "$1" "+%R %m/%d")"${2+)}"
		mins=$((secs/60%60))
		hours=$((secs/3600%24))
		days=$((secs/86400))

		any=""
		out=""
		if [[ "$days" -gt 0 ]]; then
			out="$days"d
			any=1
		fi
		if [[ "$hours" -gt 0 ]]; then
			[[ -n "$any" ]] && out="$out, "
			out="$out""$hours"h
			any=1
		fi
		if [[ "$mins" -gt 0 ]]; then
			[[ -n "$any" ]] && out="$out, "
			out="$out""$mins"m
		fi
		printf "$fmt" "$t1" "$out"
	}
	# Convert a decimal $1 to a hexadecimal; zero-pad to length $2
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

	# Export keys in readable format
	#   (more useful before adopting mnemonic key bindings)
	# tmux-keys(){
	# 	tmux list-keys | grep -v prefix | \
	# 		sed 's/[ ]\+/ /g;s/root \|\-T \|bind\-key //g' | sort | \
	# 		sed 's/^[^ ]*\| .\{0,40\}\( \|$\)/&\n\t/g'
	# }

	# Run Vim command and pipe to stdout via temporary file
	vim-cmd(){
		outfile="$(mktemp --suffix=$1)"
		trap 'rm '"$outfile" EXIT; {
			vim $outfile -c "$2" >/dev/tty
			cat $outfile
		}
	}

	vim-hi(){
		vim-cmd $1 $2
		#vim $infile -c 'runtime syntax/hitest.vim | TOhtml | w! | q! | q!'
		#awk -v 'a=0' -v 'b=0' \
		#	'/<style/{a=1}/<!--/{D;if(a) b=1}/-->/{a=0;b=0}a && b' $outfile
		#rm $infile $outfile
		# vim-cmd $1 ${*:2}' | runtime syntax/hitest.vim | TOhtml | :w! $outfile'
		# vim-cmd ':set filetype='$1' | :runtime syntax/hitest.vim'
	}

	# Search man pages and view with vim instead of pager
#	vman(){
#		man -k $* 2>&1 | grep "^$1\|^$2" && vim -c "SuperMan $*" \
#			-c "%y z | bd | set buftype=nofile | 0put=@z | %!sed 's/    / /g'"
#	}

	# web-select(){
	# 	local callback="${1:-$browser}"; shift
	# 	declare -A locations
	# 	locations=(\
	# 		['google']='https://google.com' \
	# 		['duckduckgo']='https://duckduckgo.com' \
	# 	)
	# 	shorthands=(['ddg']='duckduckgo')
	# 	for s in "${!shorthands[@]}"; do
	# 		locations+=([$s] = ${locations[${shorthands[$s]}]})
	# 	done
	# }

	web-search(){
		query="$1"; shift
		first=1
		for arg in $*; do
			[ "$first" -eq 1 ] && first=0 || query+='+'
			query+=$arg
		done
		firefox "$query"
	}
	# Wrap input to $1 columns, $2 total per line; frame columns with $3, $4
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
	# Extract zsh function names
	zsh-functions(){
		functions | grep -o '^[^ ^=]*[ ]\?()' | \
			sed 's/\(.*\)[ ]*()/\1/'
	}
	# Re-source zsh unless (conservatively, unless forcing with $1=-f)
	zsh-update(){
		[ "$1" = "-f" ] && export ZSHRC_SOURCED=""
			# export ZSHRC_FORCE=1
		source ~/.zshrc
	}
# fi
