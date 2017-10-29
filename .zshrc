#!/usr/bin/zsh

if [ -z "$ZSHRC_SOURCED" ]; then
	export ZSHRC_SOURCED=0

	export DISABLE_AUTO_UPDATE=true
	export DISABLE_UPDATE_PROMPT=true

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
	alias -g ~sdl=~/workspace/SDL2
	alias -g ~sdl-doc=~/workspace/sdl2-docs/docs
	alias -g ~ws=~/workspace

	alias please='sudo'
	alias fucking='sudo'

	#term
	alias zshconfig='$EDITOR ~/.zshrc && zsh-update'
	alias zshenv='$EDITOR ~/.zshenv && zsh-update'
	alias zsh-aliases='alias | sed "s/^\([^=]*\).*/\1/"'
	alias tmuxconfig='$EDITOR ~/.tmux.conf && tmux source-file ~/.tmux.conf'

	#info
	alias tree="tree --charset=ascii"
	alias list='cat -n | sed "s/^[ ]*\([0-9]*\)[ \t]*\(.*\)/\1. \2/"'
	alias compgen='sort -u <(ls $path 2>/dev/null) <(zsh-functions) <(zsh-aliases)'
	alias compgrep='(){ compgen | grep $* }'
	alias count-chars='sed "s/\(.\)/\1\n/g" | grep -o ".\+" | wc -l'
	alias filter-sed='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
	alias wrap-column="sed -e 's/.\{'$(($COLUMNS/2-4))'\}/&\n/g' | column"
	alias set-grep='set|grep -a'
	alias files='(){find $(cat) -type f | difftree "/" " "} <<<'

	# compdef vman="man"
	alias irhn='grep -IrHn'
	alias todo='irhn TODO'

	#vim
	alias vi='vim'
	alias vimu='vim +PluginInstall +qall'
	alias vimconfig='$EDITOR ~/.vimrc'
	alias vim="stty stop '' -ixoff ; $EDITOR"

	#dev
	alias loopcmd='(){ while read; do $*; done }'
	alias lmake='(){ { make $* } 2>&1 | less }'

	ed_sources=('c' 'h' 'cpp' 'hpp' 'tpp' 'cpp')
	ed_scripts=('Makefile' 'mk' 'in' 'lua')
	ed_confs=('conf' 'rc')
	ed_markups=('README' 'md' 'html' 'css' 'php' 'index')
	ed_files=($ed_sources $ed_scripts $ed_confs $ed_markups $ed_files)
	for d ($ed_files) alias -s $d='$EDITOR'

	# This line makes python scripts execute by default
	alias -s py='python3'
	# It can be in ed_scripts if you want to edit by default

	#media
	alias -s mp3='vlc'

	# alias lessh='LESSOPEN="| source-highlight %s -o STDOUT" less -M '

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

	new_path=($HOME'/bin' $PATH)
	new_ldpath=($HOME'/lib' $HOME'/Downloads/llvm/lib'
		$HOME'/workspace/glew-2.1.0/lib'
		'/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu'
		'/usr/lib/python2.7/config-x86_64-linux-gnu'
		'/usr/lib/' $LD_LIBRARY_PATH)
	#new_manpath=($HOME'/.man' $HOME'/.local/share/man/')
	old_ifs=$IFS
	export IFS=:
	export PATH="$new_path"
	#export MANPATH="$MANPATH"':'"$new_manpath"
	export LD_LIBRARY_PATH="$new_ldpath"
	export IFS=$old_ifs

	COMPLETION_WAITING_DOTS="true"
	plugins=(git gitfast github zsh-_url-httplink)

	export ZSH_THEME="powerlevel9k/powerlevel9k"

	export co_user="231"
	export co_root="221"
	local co_wt="38;5;255"
	local co_lg="38;5;155"
	local co_dg="38;5;143"
	local co_or="38;5;215"
	local co_ye="38;5;221"

	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir status)
	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
	POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
	POWERLEVEL9K_SHORTEN_DELIMITER=$'\u2026'
	POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
	POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
	# POWERLEVEL9K_VCS_ICON=$'\U1f19a'
	# POWERLEVEL9K_GIT_GITHUB_ICON=$'\U1f19a'
	POWERLEVEL9K_HIDE_BRANCH_ICON=true
	POWERLEVEL9K_VCS_HIDE_TAGS=true
	POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY=false
	POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
	POWERLEVEL9K_DIR_BACKGROUND=16
	POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=16
	POWERLEVEL9K_DIR_HOME_BACKGROUND=16
	POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=16
	POWERLEVEL9K_VCS_CLEAN_BACKGROUND=16
	POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=16
	POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=16
	POWERLEVEL9K_TIME_BACKGROUND=16
	POWERLEVEL9K_STATUS_OK_BACKGROUND=16
	POWERLEVEL9K_STATUS_ERROR_BACKGROUND=16

	POWERLEVEL9K_DIR_FOREGROUND=15
	POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=15
	POWERLEVEL9K_DIR_HOME_FOREGROUND=15
	POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=15
	POWERLEVEL9K_VCS_CLEAN_FOREGROUND=15
	POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=15
	POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=15
	POWERLEVEL9K_TIME_FOREGROUND=15
	POWERLEVEL9K_STATUS_OK_FOREGROUND=15
	POWERLEVEL9K_STATUS_ERROR_FOREGROUND=15

	# BULLETTRAIN_PROMPT_CHAR='\u29fd '
	# BULLETTRAIN_GIT_ADDED="\u200a\u271c"
	# BULLETTRAIN_GIT_UNTRACKED="\u200a\U1f7a7"
	# BULLETTRAIN_GIT_MODIFIED="\u200a\U1f7b4"
	# BULLETTRAIN_GIT_DELETED="\u200a\U1f196"
	# BULLETTRAIN_GIT_AHEAD="\u200a\U1f81d"
	# BULLETTRAIN_GIT_BEHIND="\u200a\U1f81f"
	# BULLETTRAIN_GIT_RENAMED="\u200a\U1f14b"
	# BULLETTRAIN_GIT_DIVERGED="\u200a\U1f313"
	# BULLETTRAIN_GIT_CLEAN="\u200a\U1f197\u200a"
	# BULLETTRAIN_GIT_DIRTY=""
	# BULLETTRAIN_GIT_FG=159
	# BULLETTRAIN_GIT_BG=232
	# BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=232
	# BULLETTRAIN_GIT_EXTENDED=true

	source $ZSH/oh-my-zsh.sh

	## Potential fix for Git delay, currently not helping
	##   No delay from key presses; only hitting 'enter' (no command),
	##   ctrl+l (refresh), and on command exit. Clearly due to prompt.
	##   Removing VCS element fixes delay as a workaround.
	## Credit to github.com/msabramo anyway
	function git_prompt_info() {
		ref=$(git symbolic-ref HEAD 2> /dev/null) || return
		echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}"\
			"$ZSH_THEME_GIT_PROMPT_SUFFIX"
	}

	alias grep >&/dev/null && \
		unalias grep && alias grep='grep --color=auto'

	export GREP_COLORS='fn='$co_wt':ln='$co_wt':sl='$co_wt';;1:mt='$co_lg':'\
	'cx=2:se='$co_wt
	eval "$(dircolors -b ~/.dircolors)"
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

	source ~/.zshenv
	# tmux start-server
fi
export ZSHRC_SOURCED=$((ZSHRC_SOURCED+1))

GPG_TTY=$(tty)
export GPG_TTY
