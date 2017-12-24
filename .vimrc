" be iMproved, required
set nocompatible
" required
filetype off
" shorten load message
set shm=a
set showcmd
set undofile udir=$HOME/share/vimundo ul=1000 ur=10000
set rtp+=~/.vim/bundle/Vundle.vim

set list lcs=tab:▒░
set backspace=indent,eol,start

set encoding=utf8
set ttym=xterm2 mouse=a

set t_Co=256

set nu ru cuc cul sbr=‾\\_
set cole=2 cocu=vin
set cot=menu cot-=preview
set ph=20
set diffopt=filler

let buf_nre='au BufNewFile,BufRead,BufEnter'


let palette={
	\'lblue': 123, 'blue': 44, 'dblue': 17,
		\ 'lteal': 87, 'teal': 23,
	\ 'lgreen': 155, 'green': 106, 'dgreen': 22,
		\'lolive': 186, 'olive': 185,
	\'lyellow': 221, 'yellow': 226,
		\'lorange': 214, 'orange': 208,
	\'lred': 216, 'red': 203, 'dred': 52,
		\'lpink': 225, 'pink': 217,
	\'lpurple': 139, 'purple': 177, 'dpurple': 53,
	\'white': 231, 'black': 16, 'lgray': 15, 'gray': 253,
	\'notice_min': 151, 'notice': 220, 'notice_max': 229
\}


call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin 'scrooloose/nerdtree'
" Plugin 'terryma/vim-multiple-cursors'

" Use Clang Complete with Python3.x (fork of Rip-Rip/clang_complete)
" Check your version of Vim to see if Python3 or Python2 is enabled
" Myint is two years behind on commits but Rip-Rip breaks others
" May be fixed with NeoVim, testing soon

Plugin 'beyondmarc/opengl.vim'
Plugin 'vim-scripts/gtk-vim-syntax'
Plugin 'kana/vim-operator-user'
Plugin 'rhysd/vim-clang-format'
let g:clang_format#style_options = {
	\'AllowShortIfStatementsOnASingleLine': 'true',
	\'AllowShortLoopsOnASingleLine': 'true',
	\'AllowShortBlocksOnASingleLine': 'true',
	\'AllowShortCaseLabelsOnASingleLine': 'true',
	\'ColumnLimit': 78, 'ContinuationIndentWidth': 8,
	\'AlignAfterOpenBracket': 'DontAlign',
	\'IndentWidth': 4, 'TabWidth': 4, 'UseTab': 'Always'
\}
let g:clang_format#command = "clang-format-4.0"
" let g:clang_format#detect_style_file = 0


Plugin 'Rip-Rip/clang_complete'
let g:clang_auto_select=0
let g:clang_complete_auto=0
let g:clang_complete_hl_errors=1
let g:clang_close_preview=1
let g:clang_c_options='-std=gnu11'
let g:clang_cpp_options='-std=c++11 -stdlib=libc++'
let g:clang_sort_algo='alpha'
let g:clang_snippets_engine='clang_complete'
let g:clang_snippets=0
let g:clang_conceal_snippets=0
let g:clang_complete_macros=1
let g:clang_use_library=1
let g:clang_library_path="/home/john/Downloads/llvm/lib/"
let g:clang_user_options='|| exit 0'

Plugin 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight=1

let mapleader=","

map <Up> <c-y>
map <Down> <c-e>
inoremap <Tab> <c-x><c-u>

noremap <Leader><h> :s/^[\t]\(.*\)$/\1/
" noremap <Leader><l> :s/^\(.*\)$/\t\1/

map <leader><Space> :.s/$/\=repeat(' ',79-col('$'))
noremap <C-l> <\t>

map <F10> :call Syn_at()<CR>

noremap! <n> <NOP>
noremap! <m> <NOP>

syntax enable
syn sync fromstart

au CursorMovedI * if pumvisible() == 0|pclose|endif
au InsertLeave * if pumvisible() == 0|pclose|endif

" Resume; restore cursor position and center on screen
au BufReadPost * if line("'\"") > 1
			\ && line("'\"") <= line("$")
			\ | exe "normal! g'\"ztzz"
" | exe 'normal! zz' | endif

exec buf_nre . ' *.txt,*.warprc set filetype=txt'
exec buf_nre . ' *.vim,*.vimrc set filetype=vim'


exec buf_nre . ' *.cpp,*.tpp,*.hpp set'
			\ . ' filetype=cpp omnifunc=omni#cpp#complete#Main'
			\ . ' completefunc=ClangComplete'
exec buf_nre . ' *.mk,Makefile set filetype=make'

" required
call vundle#end()
filetype plugin indent on

" Active highlight (hi/transient/low) plus stack below
function! Syn_at(...)
	let stack=[]
	for id in synstack(line("."),col("."))
		let stack+=[synIDattr(id,"name")]
	endfor
	let syn_0=synID(line("."),col("."),0)
	let syn_1=synID(line("."),col("."),1)
	echo 'Hi="' . synIDattr(syn_1,"name")
				\ . '", Trans="' . synIDattr(syn_0,"name")
				\ . '", Lo="' . synIDattr(synIDtrans(syn_1),"name") . '",'
	echo '   Stack: ' . join(stack, ' > ')
endfunction
map <F10> :call Syn_at()<CR>

vmap <C-c> :w! ~/.vimbuffer<CR>
nmap <C-c> :.w! ~/.vimbuffer<CR>
map <C-p> :r ~/.vimbuffer<CR>

" command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
" 		\ | wincmd p | diffthis
" nmap <Leader>d :DiffOrig<CR>

" Open new file
map <C-n> :tabe<CR>
map <Leader>n :badd<CR>
" Open new tab
map <C-o> :tabe<space>
map <Leader>o :badd<space>
" Left tab
nmap <Leader>. :tabn<CR>
nmap <Leader>\> :bn<CR>
" Right tab
nmap <Leader>, :tabp<CR>
nmap <Leader>\< :bp<CR>

" Open tab tree
map <Leader>d :NERDTree<CR>

" Splits
" Focus below (alt.)
nnoremap <Leader>A <C-W>j
" Focus below
nnoremap <Leader>j <C-W>j
" Add and focus below
nnoremap <Leader>J :sp<CR>
" Alternative horizontal split
nnoremap _ :sp<CR>
" Focus above
nnoremap <Leader>k <C-W>k
" Focus right
nnoremap <Leader>l <C-W>l
" Add and focus right
nnoremap <Leader>L :vsp<CR>
" Alternate vertical split
nnoremap \| :vsp<CR>
" Focus left
nnoremap <Leader>h <C-W>h
" Add below with arguments
nnoremap <Leader>s :sp<Space>
" Add right with arguments
nnoremap <Leader>v :vsp<Space>

" Themes, colors, icons

" Plugin 'ryanoasis/vim-devicons'
set ls=0
set stal=2

" Decorations
" Plugin 'airblade/vim-gitgutter'
" Whitespace visualization

" TODO restore whitespace highlighting
Plugin 'Yggdroot/indentLine'
Plugin 'ntpeters/vim-better-whitespace'
" Plugin 'nathanaelkane/vim-indent-guides'

hi IndentGuidesOdd ctermfg=59 cterm=bold
hi IndentGuidesEven ctermfg=29 cterm=bold
hi IndentGuidesOdd ctermfg=147
hi IndentGuidesEven ctermfg=179
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=1
let g:vim_indent_cont=0

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

" vnoremap <C-#> <Esc>`>A */<Esc>`<I/* <Esc>

exec buf_nre . ' *.cpp,*.hpp,*.tpp '
			\ . ':map <C-a> :s/^[ \t]*/&// /<CR>|'
			\ . ':map <C-z> :s/^\([ \t]*\)\/\//\1/<CR>'

map <leader><Space> :.s/$/\=repeat(' ',79-col('$'))<CR>
map <leader># :.s/$/\=repeat('#',79-col('$'))<CR>
" Line quotes, default style is vim
map <C-a> :s/^[ \t]*/" &/<CR>
" Line unquote, default style is vim
map <C-z> :s/^\([ \t]*\)"[ ]*/\1/<CR>
" Simple references to the C-a/C-z
map <Leader>a [%V]%<C-a>
" key bindings so they can change
map <Leader>z [%V]%<C-z>
" Unicode entry (c-V is xclip paste)
map <C-v> <C-V>

exec buf_nre . ' * :set tw=78 cc=+1'
" E.g. k_ftype='*.cpp', k_var='ctermfg=', k_val='255', k_tag='cBlock'
" for [k_ftype, v_ftype] in term_map
" 	for [k_var, v_var] in items(v_ftype)
" 		let k_group_au=[]
" 		for [k_val, v_val] in items(v_var)
" 			for k_tag in v_val
" 				let k_group_au += ['hi! ' . k_tag . ' ' . k_var . k_val]
" 			endfor
" 		endfor
" 		exec buf_nre . ' ' . k_ftype . ' ' . join(k_group_au, ' | :')
" 	endfor
" endfor


set tw=78 cc=+1 noet nosi noai noci nocin nopi sts=0 sw=4 ts=4
hi ColorColumn cterm=underline ctermbg=none
hi CursorColumn ctermbg=232 cterm=none,bold
hi CursorLine cterm=none,bold ctermbg=232
hi CursorLineNr ctermfg=231 ctermbg=167
hi LineNr ctermfg=167 ctermbg=232

hi Underlined ctermfg=106
hi Ignore ctermfg=106
hi Error ctermfg=106
hi Todo ctermfg=217

hi PreProc ctermfg=110 " 213
hi Identifier ctermfg=145
" hi PreProc ctermfg=184
hi Statement ctermfg=219

hi Constant ctermfg=179
hi Special ctermfg=140
hi SpecialComment ctermfg=123
hi Comment ctermfg=105 " 229 " 189
hi Type ctermfg=66 " 149
" 167 burgs

hi Todo ctermbg=None
