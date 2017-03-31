
[ -n "$TMUX" ] && printf "\033]2;tmux/zsh\033\\"
[ -z "$ZSHRC_SOURCED" ] && export ZSHRC_SOURCED=0
[ -z "$ZSHRC_FORCE" ] && export ZSHRC_FORCE=0

export EDITOR='vim'
export TERM="screen-256color"
export ZSH=~/.oh-my-zsh

alias please='sudo'
alias fucking='sudo'

zsh-update(){
	if [ "$1" = "-f" ]; then export ZSHRC_FORCE=1; fi
	# [[ "$1" = "-f" ]] && export ZSHRC_FORCE=1
	source ~/.zshrc
}
#alias zsh-update='source ~/.zshrc'
alias zshconfig='$EDITOR ~/.zshrc && zsh-update'
alias zshenv='$EDITOR ~/.zshenv && zsh-update'
alias tmuxconfig='$EDITOR ~/.tmux.conf && tmux source-file ~/.tmux.conf'

#info
alias tree="tree --charset=ascii"
alias list='cat -n | sed "s/^[ ]*\([0-9]*\)[ \t]*\(.*\)/\1. \2/"'
alias compgen='sort -u <(ls $path 2>/dev/null) <(zsh-functions) <(zsh-aliases)'
alias compgrep='compgen | grep'
alias listgrep='list $@ | grep'

compdef vman="man"
alias irhn='grep -IrHn'
alias todo='irhn TODO'

#vim
alias vi='vim'
alias vimu='vim +PluginInstall +qall'
alias vimconfig='$EDITOR ~/.vimrc'
alias vim="stty stop '' -ixoff ; $EDITOR"

#dev
alias win32-gcc='x86_64-w64-mingw32-gcc-win32'
alias win32-g++='x86_64-w64-mingw32-g++-win32'
devs=('.*Makefile' 'mk' 'c' 'h' 'cpp' 'hpp' 'frag' 'vert' 'lua' 'py' 's' 'lst')
for d (${devs[@]}) alias -s "$d"='$EDITOR';

alias dryad='git add -An'

#media
alias -s mp3='vlc'

alias lessh='LESSOPEN="| source-highlight %s -o STDOUT" less -M '

alias filter-sed='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
alias Makefile='$EDITOR Makefile'
alias readme='$EDITOR README.md'
alias sloc='xargs wc -l'
alias find-sloc='find . -type f | grep $dev | sloc | column | grep "[0-9]* "'
alias wrap-column="sed -e 's/.\{'$(($COLUMNS/2-4))'\}/&\n/g' | column"

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

#misc
alias ns='notify-send'
alias nsc='notify-send -u critical'

alias washer='sleep 1800 && nsc "Washer"'
alias dryer='sleep 2700 && nsc "Dryer"'

#net
alias firefox='firefox --new-tab'
alias -s com='firefox'
alias -s org='firefox'

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
plugins=(git gitfast github wd zsh-_url-httplink)

ZSH_THEME="bullet-train/bullet-train"

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
#BULLETTRAIN_CUSTOM_FG=15

if [ "$ZSHRC_SOURCED" -eq 0 ] || [ "$ZSHRC_FORCE" -eq 1 ]; then
	source $ZSH/oh-my-zsh.sh
	source ~/bin/completions/tmuxinator.zsh
fi

#export UPDATE_FPS=10
#export UPDATE_DELAY=$((1.0/$UPDATE_FPS))

export ZSHRC_SOURCED=$((ZSHRC_SOURCED+1))

pidof thd >/dev/null || sudo ~/bin/thd.sh

export PROMPT="$(tr -d '\n' <<< $PROMPT)"
alias grep >&/dev/null && \
	unalias grep && alias grep='grep --color=auto'

export GREP_COLORS=\
	'sl='$co_wt';;1:mt='$co_lg':cx=2:se='$co_wt';;1:fn='$co_dg':ln='$co_dg
export LS_COLORS="${LS_COLORS//ex=[^:]*/ex=$co_or}"
export LS_COLORS="${LS_COLORS//fi=[^:]*/fi=$co_dg}"
export LS_COLORS="${LS_COLORS//di=[^:]*/di=$co_ye}"
source ~/.zshenv
