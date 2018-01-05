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
	#alias ivim="(){ \vim -es '+:hi Normal ctermfg=155' /dev/stdin }"
	alias iovim="(){ \vim -es $@ '+:wq! /dev/stdout' /dev/stdin }"
	alias ivim='fname=$(mktemp /tmp/XXXXXXXX) && cat >> $fname && \vim $fname'
	alias vimu='vim +PluginInstall +qall'
	alias vimconfig='$EDITOR ~/.vimrc'
	alias vim="stty stop '' -ixoff ; TERM=screen-256color $EDITOR"

	#dev
	alias loopcmd='(){ while read; do $*; done }'
	alias lmake='(){ { make $* } 2>&1 | less }'

	ed_sources=('c' 'h' 'cpp' 'hpp' 'tpp' 'cpp')
	ed_scripts=('Makefile' 'mk' 'in' 'lua')
	ed_confs=('conf' 'rc' 'vim')
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
	alias -s com='browser' org='browser' net='browser'

	new_path=($HOME'/bin' $PATH)
	new_ldpath=($HOME'/lib' $HOME'/Downloads/llvm/lib'
		$HOME'/workspace/glew-2.1.0/lib'
		$HOME'/.local/lib/python2.7/site-packages'
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


	# Discovered batch assignment techniques:
	# 1. Iterate over a name group sharing expansions/values
	for bt_target ('AWS' 'CONTEXT' 'CUSTOM' 'DIR' 'ELIXIR' 'TIME' \
			'GIT' 'GIT_COLORIZE_DIRTY' 'GO' 'NVM' 'PERL' 'RUBY' \
			'SCREEN' 'STATUS' 'VIRTUALENV') \
		let "BULLETTRAIN_"$bt_target{"_FG=231","_BG=232"}
	# 2. Iterate over an expansion/value group sharing names
	for bt_config (CONTEXT_BG=232 CUSTOM_BG=53 DIR_BG=53 GIT_BG=232 \
		DIR_CONTEXT_SHOW=true \
		PROMPT_SEPARATE_LINE=false PROMPT_ADD_NEWLINE=false) \
		let "BULLETTRAIN_$bt_config"


	# export ZSH=~/.oh-my-zsh
	source ~/workspace/antigen/antigen.zsh
	antigen use oh-my-zsh
	antigen bundle git
	antigen bundle zsh-users/zsh-syntax-highlighting
	antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train
	#antigen bundle bhilburn/powerlevel9k
	antigen apply
	antigen theme bullet-train
	## Credit to github.com/msabramo anyway
	setopt prompt_subst
	function git_prompt_info() {
		ref=$(git symbolic-ref HEAD 2> /dev/null) || return
		res="${ref#refs/heads/}"
		if [ -z "$res" ]; then echo; return; fi

		cf=231 fcf='%F{'$cf'}' bcf='%K{'$cf'}'
		cm=232 fcm='%F{'$cm'}' bcm='%K{'$cm'}'
		cb=53 fcb='%F{'$cb'}' bcb='%K{'$cb'}'

		#lhs=$fcm$'\Ue0b2'$bcm$fcb$'\Ue0b2'
		lhs=$bcm$fcb$'\Ue0b2'$bcb$fcm$' \Ue0b2'
		lhs=$lhs$bcm$fcb$'\Ue0b2'$bcb$fcf'  '
		rhs=' '
		prefix=$ZSH_THEME_GIT_PROMPT_PREFIX
		suffix=$ZSH_THEME_GIT_PROMPT_SUFFIX
		echo "$lhs$prefix$res$suffix$rhs"
	}
	RPROMPT='$(git_prompt_info)'
	BULLETTRAIN_PROMPT_ORDER=(dir) #git custom)
	BULLETTRAIN_CUSTOM_MSG=$'\U03BB'
	BULLETTRAIN_CONTEXT_HOSTNAME='%D'
	BULLETTRAIN_PROMPT_CHAR=$' \U03BB. '


	typeset -A ZSH_HIGHLIGHT_STYLES zle_highlight
	zle_highlight=()
	ZSH_HIGHLIGHT_STYLES=(\
		alias 'fg=155,bold' \
		command 'fg=155,bold' \
		function 'fg=155,bold' \
	)
		# alias 'fg=231,bold' command 'fg=87' \
		# comment 'fg=111' default 'fg=153' \
		# globbing 'fg=22,bold' path 'fg=48' \
		# reserved-words 'fg=219' \
		# unknown-token 'fg=220,bold')


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

	export GCC_COLORS='error=01;31:warning=01;35:'\
		'note=01;36:caret=01;32:locus=01:quote=01'

	source ~/.zshenv
else
	ZSHRC_SOURCED="$(date)"
	export ZSH_SOURCED
fi

GPG_TTY=$(tty)
export GPG_TTY
export LC_ALL=en_US.UTF-8
