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
	# Show ranges of xterm-256 colors, or the entire table with -a
	color-range(){
		buf='\n'
		for line ({0..5}) {
			for block ({0..5}) {
				[ $((block%2)) -eq 1 ] \
					&& buf=$buf' ' \
					|| buf=$buf$(printf ' %3i ' $((16+6*(block+6*line))))
				for cell ({0..5}) {
					index=$((16+cell+6*(block+6*line)))
					buf=$buf$(printf $'\e[48;5;'$index$'m')
					[ $(((line^block^cell)%2)) -eq 0 ] \
						&& buf=$buf$(printf $'\e[38;5;231m\\\e[m') \
						|| buf=$buf$(printf $'\e[38;5;232m/\e[m')
					#buf=$buf$'+\e[m'
				}
				#buf=$buf' '
			}
			buf=$buf'\n'
		}
		buf=$buf'\n4-bit '
		for block ({0..7}) {
			inner=$(printf $'\e[38;5;231m\\\e[38;5;232m/\e[39m')
			buf=$buf$(printf $' \e[4'$block$'m'$inner$'\e[49m')
			buf=$buf$(printf $' \e[10'$block$'m'$inner$'\e[49m')
		}
		buf=$buf$'\e[m\n'
		echo $buf
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
		for arg; do
			if [ -r $arg ]; then
				ftype="Generic"
				lines=$(cat $arg)
				real_lines="$lines"
				n_lines=$(wc -l $arg)
				case $arg in
					*.[ch] | *.[cht]pp )
						ftype="C"
						if [[ "$arg" =~ '.*pp' ]]; then
							ftype="C++"
							real_lines=$(sed ':n N
								:s { s/\/\*\(.*\)\*\///; Tn }
								/\/\*/bs' <<<$lines);
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
				lines=$(echo $lines | grep -o '.*[^ ^\t]+.*')
				# lines=$(grep -o '.*[^ ^\t]+.*' <<<"$lines")
				# lines="$(echo -n $lines | grep -o '.*[^ ^\t].*')"
				echo "$(echo $real_lines | wc -l)/$(wc -l $arg)" \
					"(as $ftype)"
				#echo $real_lines
			fi
		done
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
	vman(){
		man -k $* 2>&1 | grep "^$1\|^$2" && vim -c "SuperMan $*" \
			-c "%y z | bd | set buftype=nofile | 0put=@z | %!sed 's/    / /g'"
	}

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
