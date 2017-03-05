
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
alias grep="grep --color=always"
alias tree="tree --charset=ascii"
alias list='cat -n'
alias compgen='sort -u <(ls $path 2>/dev/null) <(zsh-functions) <(zsh-aliases)'
alias compgrep='compgen | grep'
alias listgrep='list $@ | grep'

compdef vman="man"
alias todo='grep -IrHn TODO'

#vim
alias vi='vim'
alias vimu='vim +PluginInstall +qall'
alias vimconfig='$EDITOR ~/.vimrc'
alias vim="stty stop '' -ixoff ; $EDITOR"

#dev
alias win32-gcc='x86_64-w64-mingw32-gcc-win32'
alias win32-g++='x86_64-w64-mingw32-g++-win32'
dev="Makefile\|\.mk$\|\.[ch]$\|\.[ch]pp$\|\.frag$\|\.vert$"
dev+="\|\.lua$\|\.py$\|\.s$\|\.lst$"
alias -s c='$EDITOR' cpp='$EDITOR' tpp='$EDITOR' h='$EDITOR' hpp='$EDITOR' mk='$EDITOR'
alias -s lua='$EDITOR' frag='$EDITOR' vert='$EDITOR'

#media
alias -s mp3='vlc'

alias lessh='LESSOPEN="| source-highlight %s -o STDOUT" less -M '

alias filter-sed='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
alias Makefile='$EDITOR Makefile'
alias readme='$EDITOR `ls -R | grep -i readme`'
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
alias dryer='sleep 2700 && notify-send -u critical "Dryer"'
alias washer='sleep 1800 && notify-send -u critical "Washer"'

#net
alias firefox='firefox --new-tab'
alias -s com='firefox'
alias -s org='firefox'

if [ "$ZSHRC_SOURCED" -eq 0 ]; then
	#env
	local new_path=(
	"$HOME/bin"
	"/usr/local/sbin"
	"/usr/local/bin"
	"/usr/sbin"
	"/usr/bin"
	"/usr/games"
	"/usr/local/games"
	"/sbin"
	"/bin")
	local new_manpath=(
	"$HOME/.man"
	"/usr/local/man"
	"$HOME/.linuxbrew/share/man")

	new_ldpath=(
	"$HOME/lib"
	"$HOME/Downloads/llvm/lib"
	"/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu"
	"/usr/lib/python2.7/config-x86_64-linux-gnu"
	"/usr/local/lib"
	"/usr/lib"
	"/lib")
	old_ifs="$IFS"
	export IFS=":"
	export PATH="${new_path[*]}"
	export MANPATH="${new_manpath[*]}:$MANPATH"
	export LD_LIBRARY_PATH="${new_ldpath[*]}:$LD_LIBRARY_PATH"
	export IFS="$old_ifs"
	export fpath=(~/bin/completions $fpath)
fi


COMPLETION_WAITING_DOTS="true"
plugins=(git gitfast github wd zsh-_url-httplink)

ZSH_THEME="bullet-train/bullet-train"
BULLETTRAIN_PROMPT_SEPARATE_LINE=false
BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_STATUS_BG=black
BULLETTRAIN_EXEC_TIME_FG=cyan
BULLETTRAIN_EXEC_TIME_BG=black
BULLETTRAIN_TIME_BG=black
BULLETTRAIN_TIME_FG=white
BULLETTRAIN_NVM_FG=white
BULLETTRAIN_NVM_BG=black
BULLETTRAIN_PROMPT_ORDER=( time status custom context \
	dir go git hg cmd_exec_time )
# echo "ZSHRC_SOURCED=$ZSHRC_SOURCED, ZSHRC_FORCE=$ZSHRC_FORCE"
if [ "$ZSHRC_SOURCED" -eq 0 ] || [ "$ZSHRC_FORCE" -eq 1 ]; then
	#zsh
	source $ZSH/oh-my-zsh.sh
	source ~/bin/completions/tmuxinator.zsh
fi

export UPDATE_FPS=10
export UPDATE_DELAY=$((1.0/$UPDATE_FPS))

unalias grep
alias grep='grep --color=auto'

export PROMPT="$(tr -d '\n' <<< $PROMPT)"
export PS1="$(tr -d '\n' <<< $PS1)"
export PS2="$(tr -d '\n' <<< $PS2)"
export PS3="$(tr -d '\n' <<< $PS3)"
export PS4="$(tr -d '\n' <<< $PS4)"

export ZSHRC_SOURCED=$(($ZSHRC_SOURCED+1))

pidof thd >/dev/null || sudo ~/bin/thd.sh

source ~/.zshenv
