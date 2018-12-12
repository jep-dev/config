" be iMproved, required
set nocompatible
" required
filetype off
" shorten load message
set shm=a
set showcmd
set undofile udir=$HOME/share/vimundo ul=1000 ur=10000
set rtp+=~/.vim/bundle/Vundle.vim

let onNewRead='au BufNewFile,BufRead'
let onNewReadEnter=onNewRead . ',BufEnter'

" Location of configuration scripts by category
" Participates in file discovery for relative paths
rviminfo! ~/.vim/plugin/rcfiles/
" Functions, mainly for bindings
runtime! functions.vim
" Plugin and native value settings
runtime! params.vim
" Keyboard bindings
runtime! bindings.vim
" Testing symlink
runtime! linked.vim
set list lcs=tab:░\ "
set backspace=indent,eol,start

set encoding=utf8
set ttym=xterm2 mouse=a

set t_Co=256

set nu ru cuc cul sbr=`-
set cole=2 cocu=vin
set cot=menu cot-=preview
set ph=20
set diffopt=filler

set nofixendofline

call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
" Plugin 'terryma/vim-multiple-cursors'


Plugin 'tmux-plugins/vim-tmux'
Plugin 'bling/vim-bufferline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'

"let g:airline#extensions#tmuxline#enabled=0
let g:tmuxline_theme = {
    \   'a'    : [  28, 231 ],
    \   'b'    : [  65, 231 ],
    \   'c'    : [ 102, 231 ],
    \   'x'    : [ 139, 232 ],
    \   'y'    : [ 176, 232 ],
    \   'z'    : [ 213, 232 ],
    \   'win'  : [ 103, 236 ],
    \   'cwin' : [ 236, 103 ],
    \   'bg'   : [ 244, 236 ],
    \ }
Plugin 'jonathanfilip/vim-lucius'

" Plugin 'luochen1990/rainbow'
" let g:rainbow_active = 1

Plugin 'shawncplus/phpcomplete.vim'

Plugin 'beyondmarc/opengl.vim'
Plugin 'vim-scripts/gtk-vim-syntax'
Plugin 'tikhomirov/vim-glsl'
Plugin 'kana/vim-operator-user'
Plugin 'rhysd/vim-clang-format'
Plugin 'Rip-Rip/clang_complete'
"Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'bfrg/vim-cpp-modern'

syntax enable
syn sync fromstart

au CursorMovedI * if pumvisible() == 0|pclose|endif
au InsertLeave * if pumvisible() == 0|pclose|endif

" Resume; restore cursor position and center on screen
au BufReadPost * if line("'\"") > 1
			\ && line("'\"") <= line("$")
			\ | exe "normal! g'\"ztzz"
" | exe 'normal! zz' | endif

exec onNewRead . ' {.,}tmux*.conf set filetype=tmux | compiler tmux'
exec onNewRead . ' *.txt,*.warprc set filetype=txt'
exec onNewRead . ' *.vim,*.vimrc set filetype=vim'


exec onNewRead . ' *.cpp,*.tpp,*.hpp set'
			\ . ' filetype=cpp omnifunc=omni#cpp#complete#Main'
			\ . ' completefunc=ClangComplete'
exec onNewRead . ' *.mk,Makefile set filetype=make'
au BufAdd,BufNew,BufCreate,BufEnter,BufRead *.tpp set filetype=cpp
au BufAdd,BufNew,BufCreate,BufEnter,BufRead *.glsl set ft=glsl

" required
call vundle#end()
filetype plugin indent on

function! BufferCount()
	return len(getbufinfo({'buflisted':1}))
endfunction

function! CloseOrQuit()
	try
		if BufferCount() > 1
			silent bdelete
		else
			silent quit
		endif
	catch
		echo "Could not close or quit."

	endtry
endfunction

" command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
" 		\ | wincmd p | diffthis
" nmap <Leader>d :DiffOrig<CR>


" Themes, colors, icons

set ls=0
set stal=1

" Decorations
" Plugin 'airblade/vim-gitgutter'

" Whitespace visualization

Plugin 'Yggdroot/indentLine'
Plugin 'ntpeters/vim-better-whitespace'
" Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'jeetsukumaran/vim-indentwise'

Plugin 'DoxygenToolkit.vim'
Plugin 'CompleteHelper'
colorscheme lucius
LuciusBlack

" RO plugins
" Plugin 'jez/vim-superman'
" Language support
" Plugin 'bash-support.vim'

exec onNewRead . ' * :set tw=100 cc=+1'
" tm/ttm control serial keypress reaction time (interruption vs. latency)
"   - Escape timeout is for a special case of this more general tradeoff

"  set tm=500 ttm=5 cc=+1 noet nosi noai noci nocin nopi sts=0 sw=4 ts=4
set tm=500 ttm=5 cc=+1 noet noai si noci nocin nopi sts=0 sw=4 ts=4
