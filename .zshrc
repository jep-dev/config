#!/usr/bin/zsh
# setopt SOURCE_TRACE

export ZSH=~/.antigen/bundles/robbyrussell/oh-my-zsh
if [ "x$ZSHRC_SOURCED" = "x" ]; then
	export ZSHRC_SOURCED="$(date)"

	export DISABLE_AUTO_UPDATE=true
	export DISABLE_UPDATE_PROMPT=true

	export EDITOR='vim'
	export TERM="xterm-256color"
	# export TERM="screen-256color"
	set -o vi

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
	alias zshconfig='$EDITOR ~/.zshrc'
	alias zshenv='$EDITOR ~/.zshenv'
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

	alias irhn='grep -IrHn'
	alias todo='irhn TODO'

	#vim
	alias vi='vim'
	alias vimu='vim +PluginInstall +qall'
	alias vimconfig='$EDITOR ~/.vimrc'
	alias vim="stty stop '' -ixoff ; TERM=screen-256color $EDITOR"

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
	old_ifs=$IFS
	export IFS=:
	export PATH="$new_path"
	export LD_LIBRARY_PATH="$new_ldpath"
	export IFS=$old_ifs

	COMPLETION_WAITING_DOTS="true"
	plugins=(git gitfast github zsh-_url-httplink)

	export ZSH_THEME="bullet-train/bullet-train"

	BULLETTRAIN_PROMPT_CHAR=$' \U03BB. '

	BULLETTRAIN_PROMPT_ORDER=(custom dir git)
	BULLETTRAIN_CUSTOM_BG=161
	BULLETTRAIN_DIR_BG=91
	BULLETTRAIN_GIT_BG=57

	BULLETTRAIN_CUSTOM_FG=231
	BULLETTRAIN_DIR_FG=231
	BULLETTRAIN_GIT_FG=231


	BULLETTRAIN_CUSTOM_MSG="%m"
	BULLETTRAIN_PROMPT_SEPARATE_LINE=false
	BULLETTRAIN_PROMPT_ADD_NEWLINE=false
	BULLETTRAIN_CONTEXT_HOSTNAME='%m'


	# export ZSH=~/.oh-my-zsh
	source ~/workspace/antigen/antigen.zsh
	antigen use oh-my-zsh
	antigen bundle git
	antigen bundle zsh-users/zsh-syntax-highlighting
	antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train
	#antigen bundle bhilburn/powerlevel9k
	antigen apply
	antigen theme bullet-train

	ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=214,italic
	ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=155,italic
	ZSH_HIGHLIGHT_STYLES[path]=none
	ZSH_HIGHLIGHT_STYLES[globbing]=none
# 	zle_highlight=(region:none special:none region_highlight:none \
# 		suffix:none isearch:none paste:none underline:none)
	# source $ZSH/oh-my-zsh.sh

	## Credit to github.com/msabramo anyway
	function git_prompt_info() {
		ref=$(git symbolic-ref HEAD 2> /dev/null) || return
		echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}"\
			"$ZSH_THEME_GIT_PROMPT_SUFFIX"
	}

	alias grep >&/dev/null && \
		unalias grep && alias grep='grep --color=auto'

	local co_wt="38;5;255"
	local co_lg="38;5;155"
	local co_dg="38;5;143"
	local co_or="38;5;215"
	local co_ye="38;5;221"
	export GREP_COLORS='fn='$co_wt':ln='$co_wt':sl='$co_wt';;1:mt='$co_lg':'\
	'cx=2:se='$co_wt
	eval "$(dircolors -b ~/.dircolors)"
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

	source ~/.zshenv
else
	ZSHRC_SOURCED="$(date)"
	export ZSH_SOURCED
fi

GPG_TTY=$(tty)
export GPG_TTY
export LC_ALL=en_US.UTF-8
