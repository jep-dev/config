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

set list lcs=tab:▒\ "
set backspace=indent,eol,start

set encoding=utf8
set ttym=xterm2 mouse=a

set t_Co=256

set nu ru cuc cul sbr=‾\_
set cole=2 cocu=vin
set cot=menu cot-=preview
set ph=20
set diffopt=filler



call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin 'scrooloose/nerdtree'
" Plugin 'terryma/vim-multiple-cursors'


Plugin 'jonathanfilip/vim-lucius'
" runtime ~/.vim/bundle/vim-lucius/colors/lucius.vim
" source $VIMRUNTIME'/bundle/vim-lucius/colors/lucius.vim'

" Plugin 'luochen1990/rainbow'
" let g:rainbow_active = 1

Plugin 'shawncplus/phpcomplete.vim'

Plugin 'beyondmarc/opengl.vim'
Plugin 'vim-scripts/gtk-vim-syntax'
Plugin 'kana/vim-operator-user'
Plugin 'rhysd/vim-clang-format'
Plugin 'Rip-Rip/clang_complete'
Plugin 'octol/vim-cpp-enhanced-highlight'

syntax enable
syn sync fromstart

au CursorMovedI * if pumvisible() == 0|pclose|endif
au InsertLeave * if pumvisible() == 0|pclose|endif

" Resume; restore cursor position and center on screen
au BufReadPost * if line("'\"") > 1
			\ && line("'\"") <= line("$")
			\ | exe "normal! g'\"ztzz"
" | exe 'normal! zz' | endif

exec onNewRead . ' *.txt,*.warprc set filetype=txt'
exec onNewRead . ' *.vim,*.vimrc set filetype=vim'


exec onNewRead . ' *.cpp,*.tpp,*.hpp set'
			\ . ' filetype=cpp omnifunc=omni#cpp#complete#Main'
			\ . ' completefunc=ClangComplete'
exec onNewRead . ' *.mk,Makefile set filetype=make'

" required
call vundle#end()
filetype plugin indent on

colorscheme lucius
LuciusBlack


" command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
" 		\ | wincmd p | diffthis
" nmap <Leader>d :DiffOrig<CR>


" Themes, colors, icons

set ls=0
set stal=1

" Decorations
" Plugin 'airblade/vim-gitgutter'

" Whitespace visualization

hi IndentGuidesOdd ctermfg=51 ctermbg=155 cterm=bold
hi IndentGuidesEven ctermfg=51 ctermbg=155 cterm=bold
Plugin 'Yggdroot/indentLine'
hi IndentGuidesOdd ctermfg=51 ctermbg=155 cterm=bold
hi IndentGuidesEven ctermfg=51 ctermbg=155 cterm=bold
Plugin 'ntpeters/vim-better-whitespace'
" Plugin 'nathanaelkane/vim-indent-guides'

" Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'DoxygenToolkit.vim'
let g:DoxygenToolkit_interCommentBlock=""
let g:DoxygenToolkit_compactOneLineDoc="yes"
let g:DoxygenToolkit_compactDoc="yes"
Plugin 'CompleteHelper'

" RO plugins
" Plugin 'jez/vim-superman'
" Language support
" Plugin 'bash-support.vim'

exec onNewRead . ' * :set tw=78 cc=+1'

set tw=78 cc=+1 noet nosi noai noci nocin nopi sts=0 sw=4 ts=4
