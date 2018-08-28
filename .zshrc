#!/usr/bin/zsh
# setopt SOURCE_TRACE

export testing="$(date)"

if [ "x$ZSHRC_SOURCED" = "x" ]; then
	export ZSH=~/.antigen/bundles/robbyrussell/oh-my-zsh

	export DISABLE_AUTO_UPDATE=true
	export DISABLE_UPDATE_PROMPT=true
	ZSHRC_SOURCED=0
fi
export EDITOR='vim'
export LESS="-Rx4"
export TERM="xterm-256color"
# export TERM="screen-256color"
set -o vi

autoload -U run-help
autoload -Uz run-help-git run-help-ip run-help-openssl run-help-p4 \
	run-help-sudo run-help-svk run-help-svn
alias run-help >/dev/null && unalias run-help
alias help=run-help
KEYTIMEOUT=200

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
export FLAME=~/workspace/FlameGraph

#goodcop-badcop
alias please='sudo'
alias fucking='sudo'

#term
alias resource='source $ZSH/oh-my-zsh.sh'
alias restyle='(){ export ZSH_THEME="$@" && resource }'
alias zshconfig='$EDITOR ~/.zshrc'
alias zshenv='$EDITOR ~/.zshenv'
alias zsh-aliases='alias | sed "s/^\([^=]*\).*/\1/"'
alias tmuxconfig='$EDITOR ~/.tmux.conf && tmux source-file ~/.tmux.conf'

## Credit to github.com/msabramo anyway
setopt prompt_subst
function git_prompt_info() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	res="${ref#refs/heads/}"
	[[ -n "$res" ]] && echo -n $'%F{22}\ue0b2%K{22}%F{221} '\
		"$ZSH_THEME_GIT_PROMPT_PREFIX$res"\
			"$ZSH_THEME_GIT_PROMPT_SUFFIX%f%k"
}

if [ "$ZSHRC_SOURCED" = "0" ]; then
	alias tree="tree --charset=ascii"
	alias firefox='GTK_THEME="Redmond" firefox --new-tab'
	#new_ldpath=($HOME'/lib' $HOME'/Downloads/llvm/lib'
	#	$HOME'/.local/lib/python2.7/site-packages'

	#new_manpath=($MANPATH /usr/local/share/man/man3 ~/.local/share/man/cplusplus.com ~/.local/share/man
		#~/.local/share/man/man3 ~/.local/share/man/man3)
	new_ldpath=(
		$HOME{{,/Downloads/llvm}/lib,/.local/lib/python2.7/site-packages}
		/usr/local/lib/
		/usr/lib{{/python3.5/config-3.5m,/python2.7/config}-x86_64-linux-gnu,})

	{
		old_ifs=$IFS
		IFS=:
		old_manpath=$(manpath 2>/dev/null)
		export MANPATH=$HOME/.local/share/man:$old_manpath
		export path=(~/bin $path)
		#export PATH="$PATH:~/bin"
		#echo "PATH -> '$PATH'"
		export LD_LIBRARY_PATH="$new_ldpath:$LD_LIBRARY_PATH"
		IFS=$old_ifs
	}
	COMPLETION_WAITING_DOTS="true"
	plugins=(git gitfast github zsh-_url-httplink)
fi

# Discovered batch assignment techniques:
# 1. Iterate over a name group sharing expansions/values
for bt_target ('AWS' 'CONTEXT' 'CUSTOM' 'DIR' 'ELIXIR' 'TIME' \
		'GIT' 'GIT_COLORIZE_DIRTY' 'GO' 'NVM' 'PERL' 'RUBY' \
		'SCREEN' 'STATUS' 'VIRTUALENV') \
	let "BULLETTRAIN_"$bt_target{"_FG=231","_BG=232"}
# 2. Iterate over an expansion/value group sharing names
for bt_config (CONTEXT_BG=232 CUSTOM_BG=22 DIR_BG=22 GIT_BG=232 \
	DIR_CONTEXT_SHOW=true \
	PROMPT_SEPARATE_LINE=false PROMPT_ADD_NEWLINE=false) \
	let "BULLETTRAIN_$bt_config"

if [[ "$ZSHRC_SOURCED" -eq 0 ]]; then
	export ZSH_THEME="bullet-train/bullet-train"
	source ~/workspace/antigen/antigen.zsh
	antigen use oh-my-zsh
	antigen bundle git
	antigen bundle srijanshetty/zsh-pip-completion
	antigen bundle zsh-users/zsh-syntax-highlighting
	antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train
	antigen apply
	antigen theme bullet-train
fi

#info
alias list='cat -n | sed "s/^[ ]*\([0-9]*\)[ \t]*\(.*\)/\1. \2/"'
alias compgen='sort -u <(ls $path 2>/dev/null) <(zsh-functions) <(zsh-aliases)'
alias compgrep='(){ compgen | grep $* }'
alias count-chars='sed "s/\(.\)/\1\n/g" | grep -o ".\+" | wc -l'
alias filter-sed='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
alias wrap-column="sed -e 's/.\{'$(($COLUMNS/2-4))'\}/&\n/g' | column"
alias set-grep='set|grep -a'
alias files='(){find $(cat) -type f | difftree "/" " "} <<<'

#search
#alias pegrep='ps auxf | grep -v grep | egrep'
alias pegrep='ps Tho pid,args | grep -v grep | egrep' #'| grep -v grep | egrep'
alias irhn='grep -IirHn'
alias rhn='grep -irHn'
alias todo='irhn TODO'

#vim
alias vi='vim'
alias iovim="(){ \vim -es $@ '+:wq! /dev/stdout' /dev/stdin }"
alias ivim='(){ vim =($*) }'
export VMAN_FLAGS='+"set bt=nofile bh=wipe nobl noswf ro" +"set nonu"'
alias catvim='(){ vim =($@) $VMAN_FLAGS +"set ft=man nonu" }'
vman(){ vim =(man $@) $VMAN_FLAGS +"set ft=man nonu" }
#alias vman='catvim man'

# Testing completions for vman as if for man
fpath=(~/bin/vman $fpath)
setopt complete_aliases

alias vimu='vim +PluginInstall +qall'
alias vimconfig='$EDITOR ~/.vimrc'

#dev
alias loopcmd='(){ while read; do $*; done }'
alias lmake='(){ make $* 2>&1 | less }'

ed_sources=('c' 'h' 'cpp' 'hpp' 'tpp' 'cpp')
ed_scripts=('Makefile' 'mk' 'in' 'lua')
ed_confs=('conf' 'rc' 'vim' 'vimrc')
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
alias alternatives='please update-alternatives'
alias autoremove='please apt-get autoremove'
alias clean='please apt-get clean'
alias repo='please add-apt-repository'
alias dist-upgrade='please apt-get dist-upgrade'
alias install='please apt-get install'
alias purge='fucking apt-get purge'
alias remove='fucking apt-get remove'
alias search='(){ apt-cache search $@ | grep $@ }'
alias update='please apt-get update'
alias upgrade='please apt-get upgrade'
alias dpkg-grep="dpkg -l | tr -s ' ' | cut -d' ' -f2,3 | grep -i"

#misc
alias hrule='sed s/././g <(printf %$COLUMNS""s)'

#git
alias dryad='git add -An' #(dry-add)

#net
alias a2replace='(){please a2dismod $1 && please a2enmod $2 && please service apache2 restart}'
alias browser='firefox'
alias -s com='browser' org='browser' net='browser'

if [[ "$ZSHRC_SOURCED" -eq "0" ]]; then
	ANDROID=$HOME'/android-sdk'
	export PATH="$HOME/bin:$ANDROID/tools:$PATH"
fi


RPROMPT='$(git_prompt_info)'
BULLETTRAIN_PROMPT_ORDER=(dir time cmd_exec_time)
#, git custom
#BULLETTRAIN_CUSTOM_MSG=$'\u03BB'
#BULLETTRAIN_CONTEXT_HOSTNAME='%D'
BULLETTRAIN_PROMPT_CHAR=$' \u03BB. '
BULLETTRAIN_DIR_EXTENDED=0


if [[ "$ZSHRC_SOURCED" -eq "0" ]]; then
	#typeset -A ZSH_HIGHLIGHT_STYLES zle_highlight
	#zle_highlight=()
	ZSH_HIGHLIGHT_STYLES=(alias 'fg=51' command 'fg=51' function 'fg=51')


	alias grep >&/dev/null && \
		unalias grep && alias grep='grep --color=auto'
fi


	export GREP_COLORS='ms=01;38;5;120:mc=01;38;5;40:sl=:cx=:fn=38;5;111:ln=38;5;228:bn=38;5;179:se=01'
	eval "$(dircolors -b ~/.dircolors)"
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

	export GCC_COLORS='error=01;31:warning=01;35:'\
		'note=01;36:caret=01;32:locus=01:quote=01'
	export ZSHRC_SOURCED=1
	source ~/.zshenv
	export ZSHRC_SOURCED=2

if [[ "$ZSHRC_SOURCED" -eq 0 ]]; then
	GPG_TTY=$(tty)
	export GPG_TTY
	export LC_ALL=en_US.UTF-8
fi
