" Use a file type with no associations to sandbox new ideas.

" TODO from help -> 'insert.txt':
"    inserting, inserting-ex from 'insert.txt' --
"      n/v/o modes; <N>g(Ii|Aa|Oo)
"    Idea -- using line('.'),col('.'), fill/align/etc.
"      :{range}{a=prepend,i=append}[!]        1+ lines
"    Exclusions following ftype patterns
"      let g:omni_syntax_group_exclude_<lang> = '<regex>,...'
"      So use key bindings with parameters to change visibility

set nocompatible   " be iMproved, required
filetype off       " required
set shm=a          " shorten load message
set showcmd
set undofile udir=$HOME/share/vimundo ul=1000 ur=10000
set rtp+=~/.vim/bundle/Vundle.vim


" nmap <Leader>k i<C-k><gt>1
let tab_major='ל'
let tab_minor='¨'
exec 'set list lcs=tab:' . tab_major . tab_minor
set laststatus=2

" set noet noai ci pi sts=0 sw=4 ts=4 cinoptions=b0,l0,+0,(0,(s,m1
set backspace=indent,eol,start

set encoding=utf8
set ttym=xterm2 mouse=a

set t_Co=256

set nu ru cul cuc cc=80 sbr=...
set cole=2 cocu=vin
set cot=menu cot-=preview
set ph=20

let buf_nre='au BufNewFile,BufRead,BufEnter'

let palette={
	\'lblue': 81, 'blue': 5,
		\'lteal': 14, 'teal': 6,
		\'lolive': 186, 'olive': 185,
		\'lgreen': 155, 'green': 106,
	\'lyellow': 220, 'yellow': 226,
		\'lorange': 214, 'orange': 208,
	\'lred': 216, 'red': 203,
		\'lpink': 225, 'pink': 217,
		\'lpurple': 139, 'purple': 247,
	\'white': 231, 'black': 16,
		\'lgray': 15, 'gray': 253
\}

let term_map=[
	\['*', {
		\'ctermfg=': {
			\   palette['lblue']: [
				\'Statement', 'Operator',
				\'Conditional', 'Repeat', 'CaseIn', 'SngleCase'
			\], palette['lgreen']: [
				\'String', 'SString', 'DString',
				\'Number', 'Constant', 'Float', 'Character'
			\], palette['lolive']: ['Identifier', 'Type'],
			\   palette['green']: ['Modifier', 'Label', 'UserLabel'],
			\   palette['lyellow']: [],
			\   palette['lorange']: [
				\'Typedef', 'Structure', 'StorageClass', 'Variable',
				\'CursorLineNr', 'LineNr'
			\], palette['lred']: [
				\'macro', 'directive', 'PmenuSel', 'PreProc', 'PreCondit'
			\], palette['lgray']:
					\['Comment', 'Special'],
			\   palette['white']:
					\['Normal', 'Pmenu', 'MatchParen'],
			\palette['black']: []
		\}, 'cterm=': {
			\   'NONE': [
				\'CursorColumn', 'CursorLine',
				\'CursorLineNr', 'LineNr', 'SignColumn',
				\'PmenuSel', 'MatchParen',
				\'GitGutterAdd', 'GitGutterDelete', 'GitGutterChangeDelete',
				\'GitGutterAddDefault', 'GitGutterChangeDefault',
				\'GitGutterDeleteDefault', 'GitGutterChangeDeleteDefault'
			\], 'NONE,bold': [],
			\   'NONE,reverse': [
					\'Visual', 'CursorLineNr', 'MatchParen'
				\]
		\}, 'ctermbg=': {
			\   palette['white']: [
				\'Visual', 'SignColumn',
				\'GitGutterAdd', 'GitGutterDelete', 'GitGutterChangeDelete',
				\'GitGutterAddDefault', 'GitGutterChangeDefault',
				\'GitGutterDeleteDefault', 'GitGutterChangeDeleteDefault'
			\], palette['black']: ['LineNr', 'CursorLineNr',
				\'Visual', 'MatchParen',
				\'PMenu', 'PmenuSel', 'PmenuSbar',
				\'CursorColumn', 'CursorLine'
			\]
		\}, 'guifg=': {
			\'White': [
				\'CursorColumn', 'CursorColumn',
				\'GitGutterAdd', 'GitGutterDelete', 'GitGutterChangeDelete',
				\'GitGutterAddDefault', 'GitGutterChangeDefault',
				\'GitGutterDeleteDefault', 'GitGutterChangeDeleteDefault'
			\]
		\}, 'guibg=': {
			\'Black': [
				\'LineNr',
				\'GitGutterAdd', 'GitGutterDelete', 'GitGutterChangeDelete',
				\'GitGutterAddDefault', 'GitGutterChangeDefault',
				\'GitGutterDeleteDefault', 'GitGutterChangeDeleteDefault'
			\]
		\}
	\}], ['*.cpp,*.hpp,*.tpp', {
		\'ctermfg=': {
			\   palette['lteal']: [
				\'cType', 'cppSTLios', 'cppSTLnamespace', 'cppSTLtype',
				\'cppSTLexception', 'cppSTLfunctional', 'cppSTLtype'
			\], palette['lorange']: ['cCustomClass'],
			\   palette['lred']: [
				\'cCppBracket', 'cCustomAngleBracketContent',
				\'cCppBlock'
			\], palette['white']: [
				\'cAnsiFunction', 'cCppParen',
				\'cCustomParen', 'cCustomFunc'
			\]
		\}
	\}], ['Makefile,*.mk', {
		\'ctermfg=': {
			\palette['lteal']:
				\['Target', 'SpecTarget', 'Override', 'Special'],
			\palette['teal']: ['Commands', 'Command'],
			\palette['lgreen']: ['SString', 'DString']
		\}
	\}], ['*.sh*,*.zsh*', {
		\'ctermfg=': {
			\palette['lgreen']:
				\['Quote', 'Set', 'SetList', 'CmdSubRegion']
		\}
	\}], ['*.vim*', {
		\'ctermfg=': {
			\palette['lorange']: ['VimVar'],
			\palette['white']: []
		\}, 'guifg=': {
			\'White': [
				\'VimEcho', 'VimEchoHL', 'VimNormCmds', 'StatusLine',
				\'StatusLineNC', 'Title', 'Question',
				\'ModeMsg', 'MoreMsg', 'Text', 'NonText'
			\]
		\}
	\}]
\]
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'myint/clang_complete' " Rip-Rip/clang_complete python2.x -> python3.x
let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_complete_hl_errors=1
let g:clang_close_preview=1
let g:clang_c_options='-std=gnu11'
let g:clang_cpp_options='-std=c++11 -stdlib=libc++'
let g:clang_sort_algo='alpha'
let g:clang_snippets_engine='clang_complete'
let g:clang_conceal_snippets=0
let g:clang_use_library=1
let g:clang_library_path="/home/john/Downloads/llvm/lib/"

Plugin 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight=1
let g:cpp_experimental_template_highlight=1

let mapleader=","
:inoremap <Tab> <c-x><c-u>
:inoremap <S-Tab> <Tab>
" :set dictionary="/usr/dict/words"

noremap! <F3> <Esc> " Alternate escape; TODO better map

noremap! <n> <NOP>
noremap! <m> <NOP>
imap \> <C-v>>
imap \< <C-v><
noremap! <M-'> <NOP>
noremap! <M-"> <NOP>

inoremap <F2> <c-o>:

syntax on
syn sync fromstart

au CursorMovedI * if pumvisible() == 0|pclose|endif
au InsertLeave * if pumvisible() == 0|pclose|endif

" Resume editing at last position, with last 4 lines in view
au BufReadPost * if line("'\"") > 1
			\ && line("'\"") <= line("$")
			\ | exe "normal! g'\"4kzt4j" | endif

exec buf_nre . ' *.txt,*.warprc set filetype=txt'
exec buf_nre . ' *.vim,*.vimrc set filetype=vim'

exec buf_nre . ' *.cpp,*.tpp,*.hpp set'
			\ . ' filetype=cpp omnifunc=omni#cpp#complete#Main'
			\ . ' completefunc=ClangComplete'
exec buf_nre . ' *.mk,Makefile set filetype=make'

call vundle#end()            " required
filetype plugin indent on    " required

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

command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		\ | wincmd p | diffthis

" nnoremap <C-w> :DiffOrig<CR>

" Splits
nnoremap <Leader>j <C-W>j     " Focus below
nnoremap <Leader>J :sp<CR>    " Add and focus below
nnoremap <Leader>k <C-W>k     " Focus above
nnoremap <Leader>l <C-W>l     " Focus right
nnoremap <Leader>L :vsp<CR>   " Add and focus right
nnoremap <Leader>h <C-W>h     " Focus left
nnoremap <Leader>s :sp<Space> " Add below with arguments
noremap <Leader>v :vsp<Space> " Add right with arguments

" Themes, colors, icons
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ryanoasis/vim-devicons'
let g:airline_powerline_fonts=1
let g:airline_theme='base16_eighties'

" Decorations
" Plugin 'airblade/vim-gitgutter'
" Whitespace visualization
Plugin 'Yggdroot/indentLine'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'nathanaelkane/vim-indent-guides'

hi IndentGuidesOdd ctermfg=139
hi IndentGuidesEven ctermfg=139
" let g:indentLine_char = '|'
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=1
let g:vim_indent_cont=0

Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'vim-scripts/DoxygenToolkit.vim'
let g:DoxygenToolkit_interCommentBlock=""
let g:DoxygenToolkit_compactOneLineDoc="yes"
let g:DoxygenToolkit_compactDoc="yes"
Plugin 'vim-scripts/CompleteHelper'

" RO plugins
Plugin 'jez/vim-superman'

" Language support
" Plugin 'vim-scripts/bash-support.vim'
Plugin 'suan/vim-instant-markdown.git'
let g:instant_markdown_slow=1

exec buf_nre . ' * set fo= cc=80 wrap lbr tw=0 wm=2'
" vnoremap <C-#> <Esc>`>A */<Esc>`<I/* <Esc>

exec buf_nre . ' *.cpp,*.hpp,*.tpp '
			\ . ':map <C-a> :s/^[ \t]*/&// /<CR> | '
			\ . ':map <C-z> :s/^\([ \t]*\)\/\//\1/<CR>'

map <leader><Space> :.s/$/\=repeat(' ',79-col('$'))<CR>
map <leader># :.s/$/\=repeat('#',79-col('$'))<CR>
map <C-a> :s/^[ \t]*/" &/<CR>          " Line quotes, default style is vim
map <C-z> :s/^\([ \t]*\)"[ ]*/\1/<CR>  " Line unquote, default style is vim
map <Leader>a [%V]%<C-a>               " Simple references to the C-a/C-z
map <Leader>z [%V]%<C-z>               " key bindings so they can change

" E.g. k_ftype='*.cpp', k_var='ctermfg=', k_val='255', k_tag='cBlock'
for [k_ftype, v_ftype] in term_map
	for [k_var, v_var] in items(v_ftype)
		let k_group_au=[]
		for [k_val, v_val] in items(v_var)
			for k_tag in v_val
				let k_group_au += ['hi! ' . k_tag . ' ' . k_var . k_val]
			endfor
		endfor
		exec buf_nre . ' ' . k_ftype . ' ' . join(k_group_au, ' | :')
	endfor
endfor

set noet nosi noai noci nocin nopi sts=0 sw=4 ts=4
