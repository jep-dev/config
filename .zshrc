[ -z "$ZSHRC_SOURCED" ] && export ZSHRC_SOURCED=0
[ -z "$ZSHRC_FORCE" ] && export ZSHRC_FORCE=0

export EDITOR='vim'
#export TERM="screen-256color"
export TERM='xterm-256color'
export ZSH=~/.oh-my-zsh

alias -g ~ws=~/workspace
alias -g ~cfg=~/workspace/config
alias -g ~bak=~/Backups
alias -g ~dl=~/Downloads
alias -g ~mod=~/workspace/modular
alias -g ~dicts=~/workspace/dicts

alias please='sudo'
alias fucking='sudo'


alias zshconfig='$EDITOR ~/.zshrc && zsh-update'
alias zshenv='$EDITOR ~/.zshenv && zsh-update'

#term
alias zsh-aliases='alias | sed "s/^\([^=]*\).*/\1/"'
alias tmuxconfig='$EDITOR ~/.tmux.conf && tmux source-file ~/.tmux.conf'

#info
alias tree="tree --charset=ascii"
alias list='cat -n | sed "s/^[ ]*\([0-9]*\)[ \t]*\(.*\)/\1. \2/"'
alias compgen='sort -u <(ls $path 2>/dev/null) <(zsh-functions) <(zsh-aliases)'
alias count-chars='sed "s/\(.\)/\1\n/g" | grep -o ".\+" | wc -l'
alias filter-sed='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
alias wrap-column="sed -e 's/.\{'$(($COLUMNS/2-4))'\}/&\n/g' | column"
alias set-grep='set|grep -a'
#alias files='(){find $(cat) | difftree "/" " "} <<<'
alias files='(){find $(cat) -type f | difftree "/" " "} <<<'


compdef vman="man"
alias irhn='grep -IrHn'
alias todo='irhn TODO'

#vim
alias vi='vim'
alias vimu='vim +PluginInstall +qall'
alias vimconfig='$EDITOR ~/.vimrc'
alias vim="stty stop '' -ixoff ; $EDITOR"
vim-cmd(){
	# local infile="$(mktemp --suffix=$1)"
	# local outfile="$(mktemp)"
#	shift
#	vim $1 -c "${*:2}" $infile
#	cat $outfile
#	rm $outfile
}
#vim-keys(){
#	# ft="$1"
#	# [ $# -gt 1 ] && shift
#	vim-cmd ':set filetype='$1 ' | :map'
#	# vim-cmd-plaintext 'set filetype='"$ft" | :map' $@
#}


vim-cmd(){
	outfile="$(mktemp --suffix=$1)"
	trap 'rm '"$outfile" EXIT; {
		vim $outfile -c "$2" >/dev/tty
		cat $outfile
	}
}

vim-hi(){
	# vim-cmd "$1" "${
	vim-cmd $1 $2
	#vim $infile -c 'runtime syntax/hitest.vim | TOhtml | w! | q! | q!'
	#awk -v 'a=0' -v 'b=0' \
	#	'/<style/{a=1}/<!--/{D;if(a) b=1}/-->/{a=0;b=0}a && b' $outfile
	#rm $infile $outfile
	# vim-cmd $1 ${*:2}' | runtime syntax/hitest.vim | TOhtml | :w! $outfile'
	# vim-cmd ':set filetype='$1' | :runtime syntax/hitest.vim'
}

#dev
devs=('Makefile' 'mk' 'README' 'md' \
	'c' 'h' 'cpp' 'hpp' 's' 'lst' \
	'frag' 'vert' 'lua' 'py')
alias win32-gcc='x86_64-w64-mingw32-gcc-win32'
alias win32-g++='x86_64-w64-mingw32-g++-win32'

for d ($devs) { alias -s $d='$EDITOR' }
# for d ($devs) { alias -s $d='$EDITOR' }

# alias Makefile='$EDITOR Makefile'
alias makefile='(){ (){ $EDITOR ${1:-./Makefile} } ${^:-${1:-.}/{Makefile,*.mk}*(N)} }'
# alias readme='$EDITOR README'
alias readme='(){ (){ $EDITOR ${1:-./README} } ${^:-${1:-.}/{README,*.md}*(N)} }'

#alias sloc='(){ printf "\r" | wc -l $(dev-grep $*) }'
#		| awk -v 'a=1' -v 'b=1' \
#			'/\/\*/{a=0;b=0}/\*\//{a=1}{if(a&&b) print; if(a) b=1}'

sloc-real(){
	for arg; do
		if [ -r $arg ]; then
			ftype="Generic"
			lines=$(cat $arg)

			#echo $(printf '%q' $lines)
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

alias dryad='git add -An'
alias gaan='dryad'

#media
alias -s mp3='vlc'

alias lessh='LESSOPEN="| source-highlight %s -o STDOUT" less -M '


#apt
alias autoremove='_ apt-get autoremove'
alias clean='_ apt-get clean'
alias repo='_ add-apt-repository'
alias dist-upgrade='_ apt-get dist-upgrade'
alias install='_ apt-get install'
alias purge='_ apt-get purge'
alias remove='_ apt-get remove'
alias search='apt-cache search'
alias update='_ apt-get update'
alias upgrade='_ apt-get upgrade'
alias dpkg-grep='dpkg -l | cut -d " " -f 3 | grep'

#misc
alias ns='notify-send'
alias nsc='notify-send -u critical'

alias washer='sleep 1800 && nsc "Washer"'
alias dryer='sleep 2700 && nsc "Dryer"'

alias hrule='sed "s/././g" <(printf "%"$COLUMNS"s" "")'

#net
alias firefox='firefox --new-tab'
alias browser='firefox'
google_base='https://google.com'
alias -s com='browser' org='browser' net='browser'
alias google='web-search "google.com/search?q="'
alias google-images='web-search "google.com/search?tbm=isch&q="'
alias gimgs='google-images'
alias duckduckgo='web-search "duckduckgo.com/?q="'
alias ddg='duckduckgo'
alias duckduckgo-images='web-search "duckduckgo.com/?ia=images&iax=1&q="'
alias ddgimgs='duckduckgo-images'
alias wiki='web-search "en.wikipedia.org/w/index.php?search="'
alias youtube='web-search "youtube.com/results?q="'

# alias bak_='(){ ${3:-tar cvf} $1 $2 }'
alias bak='(){
src="$(realpath ${3:-.})";
name="$(basename $src)";
cmd="${1:-tar}"
dest="$(realpath ${2:-~/Backups/bak/})";
suffix="$(date +%s)"
[ -d "$dest" ] || mkdir "$dest";
if [[ "${cmd:-tar}" =~ "tar.*" ]]; then
tar $4 cf "$dest/$name-$suffix.tar" "$src";
else
cp -R $4 "$src" "$dest/$name-$suffix";
fi
}'

if [ "$ZSHRC_SOURCED" -eq 0 ]; then
	new_path=($HOME'/bin' $HOME'/workspace/markdown/bin'
		'/opt/shashlik/bin' $PATH)
	new_ldpath=($HOME'/lib' $HOME'/Downloads/llvm/lib'
		'/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu'
		'/usr/lib/python2.7/config-x86_64-linux-gnu'
		$LD_LIBRARY_PATH)
	new_manpath=($HOME'/.man')
	old_ifs=$IFS
	export IFS=:
	export PATH="$new_path"
	export MANPATH="$new_manpath"":$MANPATH"
	export LD_LIBRARY_PATH="$new_ldpath"
	export IFS=$old_ifs
fi


COMPLETION_WAITING_DOTS="true"
plugins=(git gitfast github zsh-_url-httplink)

ZSH_THEME="bullet-train/bullet-train"

export co_user="231"
export co_root="221"
local co_wt="38;5;255"
local co_lg="38;5;155"
local co_dg="38;5;143"
local co_or="38;5;215"
local co_ye="38;5;221"
local at=$(printf "\u273b")

BULLETTRAIN_PROMPT_ORDER=(time custom dir git cmd_exec_time status)
BULLETTRAIN_PROMPT_SEPARATE_LINE=false
BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_DIR_CONTEXT_SHOW=false
BULLETTRAIN_CUSTOM_MSG="\$(printf '%%n %s %%m' $at)"
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_EXEC_TIME_ELAPSED=0
BULLETTRAIN_PROMPT_CHAR=$at

BG_PALETTE=(202 208 214 220 220 221 222)
BULLETTRAIN_TIME_BG=${BG_PALETTE[1]}
BULLETTRAIN_CUSTOM_BG=${BG_PALETTE[2]}
BULLETTRAIN_DIR_BG=${BG_PALETTE[3]}
BULLETTRAIN_GIT_BG=${BG_PALETTE[4]}
BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=${BG_PALETTE[4]}
BULLETTRAIN_STATUS_BG=${BG_PALETTE[6]}
BULLETTRAIN_STATUS_ERROR_BG=${BG_PALETTE[6]}
BULLETTRAIN_EXEC_TIME_BG=${BG_PALETTE[5]}

for v ('TIME_FG' 'CUSTOM_FG' 'CONTEXT_FG' 'DIR_FG'
	'GIT_FG' 'GIT_COLORIZE_DIRTY_FG_COLOR'
	'STATUS_FG' 'STATUS_ERROR_FG' 'EXEC_TIME_FG') \
		export "BULLETTRAIN_$v"=16;

if [ "$ZSHRC_SOURCED" -eq 0 ] || [ "$ZSHRC_FORCE" -eq 1 ]; then
	source $ZSH/oh-my-zsh.sh
fi

export ZSHRC_SOURCED=$((ZSHRC_SOURCED+1))

pidof thd >/dev/null || sudo ~/bin/thd.sh

alias grep >&/dev/null && \
	unalias grep && alias grep='grep --color=auto'

export GREP_COLORS='sl='$co_wt';;1:mt='$co_lg':'\
'cx=2:se='$co_wt';;1:fn='$co_dg':ln='$co_dg
eval "$(dircolors -b ~/.dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

source ~/.zshenv
