[ -z "$ZSHRC_SOURCED" ] && export ZSHRC_SOURCED=0
[ -z "$ZSHRC_FORCE" ] && export ZSHRC_FORCE=0

export EDITOR='vim'
#export TERM="screen-256color"
export TERM='xterm-256color'

export ZSH=~/.oh-my-zsh

alias -g ~bak=~/Backups
alias -g ~cfg=~/workspace/config
alias -g ~dicts=~/workspace/dicts
alias -g ~dl=~/Downloads
alias -g ~mod=~/workspace/modular
alias -g ~omz=$ZSH
alias -g ~sdl=/usr/include/SDL2
alias -g ~ws=~/workspace

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

#dev
alias loopcmd='(){ while read; do $*; done }'

devs=('Makefile' 'mk' 'README' 'md' \
	'c' 'h' 'cpp' 'hpp' 'tpp' 's' 'lst' \
	'frag' 'vert' 'lua' 'py')
for d ($devs) { alias -s $d='$EDITOR' }
alias Makefile='(){
(){ $EDITOR ${1:-./Makefile} } ${^:-${1:-.}/{Makefile,*.mk}*(N)} }'
alias readme='(){
(){ $EDITOR ${1:-./README} } ${^:-${1:-.}/{README,*.md}*(N)} }'

alias win32-gcc='x86_64-w64-mingw32-gcc-win32'
alias win32-g++='x86_64-w64-mingw32-g++-win32'

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

#git
alias dryad='git add -An'
alias gaan='dryad'

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

export ZSH_THEME="bullet-train/bullet-train"
#export ZSH_THEME="powerlevel9k/powerlevel9k"

export co_user="231"
export co_root="221"
local co_wt="38;5;255"
local co_lg="38;5;155"
local co_dg="38;5;143"
local co_or="38;5;215"
local co_ye="38;5;221"

# BULLETTRAIN_PROMPT_CHAR=$at
BULLETTRAIN_EXEC_TIME_ELAPSED=0
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_DIR_CONTEXT_SHOW=false
BULLETTRAIN_GIT_COLORIZE_DIRTY=true
BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_PROMPT_SEPARATE_LINE=false
BULLETTRAIN_PROMPT_ORDER=(git dir time cmd_exec_time status)
typeset -A BT_FG=(DIR 216 TIME 224 EXEC_TIME 159 STATUS_ERROR 196)
typeset -A BT_BG=(DIR  52 TIME  53 EXEC_TIME  17 STATUS_ERROR  16)
for k in "${(@k)BT_FG}"; do export "BULLETTRAIN_"$k"_FG="${BT_FG[$k]}; done
for k in "${(@k)BT_BG}"; do export "BULLETTRAIN_"$k"_BG="${BT_BG[$k]}; done
BULLETTRAIN_GIT_FG=15
BULLETTRAIN_GIT_BG=16
BULLETTRAIN_GIT_COLORIZE_DIRTY_FG_COLOR=215
BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=16

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

GPG_TTY=$(tty)
export GPG_TTY

source ~/.zshenv
tmux start-server
