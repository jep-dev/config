[ -z "$ZSHRC_SOURCED" ] && export ZSHRC_SOURCED=0

export EDITOR='vim'
export TERM="screen-256color"

export ZSH=~/.oh-my-zsh

alias -g ~bak=~/Backups
alias -g ~cfg=~/workspace/config
alias -g ~dicts=~/workspace/dicts
alias -g ~dl=~/Downloads
alias -g ~ff=~/.mozilla/firefox
alias -g ~mod=~/workspace/modular
alias -g ~omz=$ZSH
alias -g ~sb=~/sandbox
alias -g ~sdl=~/workspace/SDL2
alias -g ~sdl-doc=~/workspace/sdl2-docs/docs
alias -g ~ws=~/workspace

alias please='sudo'
alias fucking='sudo'


alias zshconfig='$EDITOR ~/.zshrc && zsh-update'
alias zshenv='$EDITOR ~/.zshenv && zsh-update'

#term
alias alaconfig='$EDITOR ~/.config/alacritty/alacritty.yml'
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

ed_sources=('c' 'h' 'cpp' 'hpp' 'tpp' 'cpp')
ed_scripts=('Makefile' 'mk' 'in' 'lua' 'py')
ed_confs=('conf' 'rc')
ed_markups=('README' 'md' 'html' 'css' 'php' 'index')
ed_files=($ed_sources $ed_scripts $ed_confs $ed_markups $ed_files)
for d ($ed_files) alias -s $d='$EDITOR'

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
alias firefox='GTK_THEME="Redmond" firefox --new-tab'
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

new_path=($HOME'/bin' $HOME'/workspace/markdown/bin'
	'/opt/shashlik/bin' $PATH)
new_ldpath=($HOME'/lib' $HOME'/Downloads/llvm/lib'
	$HOME'/workspace/glew-2.1.0/lib'
	'/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu'
	'/usr/lib/python2.7/config-x86_64-linux-gnu'
	$LD_LIBRARY_PATH)
new_manpath=($HOME'/.man' $HOME'/.local/share/man/cplusplus.com/')
old_ifs=$IFS
export IFS=:
export PATH="$new_path"
export MANPATH="$new_manpath"':'"$MANPATH"
export LD_LIBRARY_PATH="$new_ldpath"
export IFS=$old_ifs


COMPLETION_WAITING_DOTS="true"
plugins=(git gitfast github zsh-_url-httplink)

export ZSH_THEME="bullet-train/bullet-train"

export co_user="231"
export co_root="221"
local co_wt="38;5;255"
local co_lg="38;5;155"
local co_dg="38;5;143"
local co_or="38;5;215"
local co_ye="38;5;221"

BULLETTRAIN_PROMPT_CHAR=$'\u232a'
BULLETTRAIN_CUSTOM_MSG=$'${$(git_prompt_status)// /}'
BULLETTRAIN_DIR_EXTENDED=false
BULLETTRAIN_EXEC_TIME_ELAPSED=0
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_DIR_CONTEXT_SHOW=false
BULLETTRAIN_GIT_EXTENDED=false
BULLETTRAIN_GIT_COLORIZE_DIRTY=true
BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_PROMPT_SEPARATE_LINE=false
BULLETTRAIN_PROMPT_ORDER=(git custom dir cmd_exec_time status)

typeset -A BT_FG BT_BG
BT_FG=(DIR 228 TIME  15)
#BT_FG=(DIR 228 TIME  15 EXEC_TIME  16 STATUS 16 STATUS_ERROR 16 CUSTOM 16)
BT_BG=(DIR 64 TIME 107 CUSTOM 16)
for k in "${(@U)BULLETTRAIN_PROMPT_ORDER}"; do
	export 'BULLETTRAIN_'$k'_FG='"${BT_FG[$k]:-16}"
	export 'BULLETTRAIN_'$k'_BG='"${BT_BG[$k]:-155}"
done
BULLETTRAIN_STATUS_FG=16
BULLETTRAIN_STATUS_BG=15
BULLETTRAIN_STATUS_ERROR_FG=16
BULLETTRAIN_STATUS_ERROR_BG=15
BULLETTRAIN_GIT_FG=15
BULLETTRAIN_GIT_BG=16
BULLETTRAIN_GIT_COLORIZE_DIRTY_FG_COLOR=15
BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=16

source $ZSH/oh-my-zsh.sh
export ZSHRC_SOURCED=$((ZSHRC_SOURCED+1))

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
