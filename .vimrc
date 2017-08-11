set nocompatible   " be iMproved, required
filetype off       " required
set shm=a          " shorten load message
set showcmd
set undofile udir=$HOME/share/vimundo ul=1000 ur=10000
set rtp+=~/.vim/bundle/Vundle.vim
let &t_ti.="\e[52\e[4 q"
let &t_te.="\e[0 q"

set list lcs=tab:╍╌

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
	\'lpurple': 139, 'purple': 247, 'dpurple': 53,
	\'white': 231, 'black': 16, 'lgray': 15, 'gray': 253,
	\'notice_min': 151, 'notice': 220, 'notice_max': 229
\}

let term_map=[
	\['*', {
		\   'term=': {
			\'NONE': [
				\'DiffAdd', 'DiffChange', 'DiffDelete', 'DiffText'
			\]
		\}, 'ctermfg=': {
			\   palette['lblue']: [
				\'DiffChange',
				\'Statement', 'Operator', 'Conditional', 'Repeat',
				\'CaseIn', 'SngleCase'
			\], palette['notice']: [
				\'String', 'SString', 'DString',
				\'Number', 'Constant', 'Float', 'Character'
			\], palette['notice_max']: [
				\'Identifier', 'Type',
				\'LineNr',
				\'TabLine', 'TabLineSel', 'TabLineFill'
			\], palette['green']: ['Modifier', 'Label', 'UserLabel'],
			\   palette['lgreen']: [
				\'DiffAdd',
				\'Typedef', 'Structure', 'StorageClass', 'Variable'
			\], palette['lred']: [
				\'DiffDelete', 'PmenuSel',
				\'Todo', 'macro', 'directive', 'PreProc', 'PreCondit'
			\], palette['lgray']: ['Special'],
			\   palette['gray']: ['Comment'],
			\   palette['notice_min']: ['Normal', 'Pmenu', 'MatchParen'],
			\palette['black']: []
		\}, 'cterm=': {
			\   'NONE': [
				\'DiffAdd', 'DiffChange', 'DiffDelete', 'DiffText',
				\'TabLine', 'TabLineFill',
				\'CursorLineNr', 'LineNr', 'SignColumn',
				\'PmenuSel',
				\'GitGutterAdd', 'GitGutterDelete', 'GitGutterChangeDelete',
				\'GitGutterAddDefault', 'GitGutterChangeDefault',
				\'GitGutterDeleteDefault', 'GitGutterChangeDeleteDefault'
			\],
			\   'NONE,italic': [],
			\   'NONE,bold,italic': ['Todo'],
			\   'NONE,bold': [
				\'GitGutterAdd', 'GitGutterChange', 'GitGutterDelete'
			\], 'NONE,reverse': [
				\'TabLineSel',
				\'MatchParen',
				\'CursorLineNr',
				\'Visual'
			\]
		\}, 'ctermbg=': {
			\   palette['white']: [
				\'GitGutterAdd', 'GitGutterDelete', 'GitGutterChangeDelete',
				\'GitGutterAddDefault', 'GitGutterChangeDefault',
				\'GitGutterDeleteDefault', 'GitGutterChangeDeleteDefault'
			\], palette['black']: [
				\'DiffAdd', 'DiffChange', 'DiffDelete', 'DiffText',
				\'GitGutterAdd', 'GitGutterChange', 'GitGutterDelete',
				\'LineNr', 'CursorLineNr', 'TabLineSel',
				\'Visual', 'TabLine',
				\'MatchParen',
				\'PMenu', 'PmenuSel', 'PmenuSbar', 'SignColumn'
			\],
			\   'NONE': ['Todo', 'Comment']
		\}, 'guifg=': {
			\'White': [
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
				\'cTodo',
				\'cCppBracket', 'cCustomAngleBracketContent',
				\'cCppBlock'
			\], palette['white']: [
				\'cAnsiFunction', 'cCppParen',
				\'cCustomParen', 'cCustomFunc'
			\]
		\},
		\'cterm=': {
			\'NONE,bold,italic': ['cTodo']
		\},
		\'ctermbg=': {
			\'NONE': ['cTodo']
		\}
	\}], ['Makefile,Makefile.*,*.mk', {
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

Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'

" Use Clang Complete with Python3.x (fork of Rip-Rip/clang_complete)
" Check your version of Vim to see if Python3 or Python2 is enabled
" Myint is two years behind on commits but Rip-Rip breaks others
" May be fixed with NeoVim, testing soon

Plugin 'kana/vim-operator-user'
Plugin 'rhysd/vim-clang-format'
let g:clang_format#style_options = {
	\"AllowShortIfStatementsOnASingleLine": 'true',
	\"AllowShortLoopsOnASingleLine": 'true',
	\"AllowShortBlocksOnASingleLine": 'true',
	\"AllowShortCaseLabelsOnASingleLine": 'true',
	\"ColumnLimit": 78, "ContinuationIndentWidth": 8,
	\"AlignAfterOpenBracket": "DontAlign",
	\"IndentWidth": 4, "TabWidth": 4, "UseTab": "Always"
\}

Plugin 'myint/clang_complete'
let g:clang_auto_select=1
let g:clang_complete_auto=0
let g:clang_complete_hl_errors=1
let g:clang_close_preview=1
let g:clang_c_options='-std=gnu11'
let g:clang_cpp_options='-std=c++11 -stdlib=libc++'
let g:clang_sort_algo='alpha'
let g:clang_snippets_engine='clang_complete'
let g:clang_conceal_snippets=0
let g:clang_use_library=1
let g:clang_library_path="/home/john/Downloads/llvm/lib/"
let g:clang_user_options='|| exit 0'

Plugin 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight=1
let g:cpp_experimental_template_highlight=1

let mapleader=","
inoremap <Tab> <c-x><c-u>
inoremap <S-Tab> <Tab>

noremap! <n> <NOP>
noremap! <m> <NOP>
inoremap \> <C-v>>
inoremap \< <C-v><

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
nmap <Leader>d :DiffOrig<CR>

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
nnoremap <Leader>j <C-W>j     " Focus below
nnoremap <Leader>J :sp<CR>    " Add and focus below
nnoremap <Leader>k <C-W>k     " Focus above
nnoremap <Leader>l <C-W>l     " Focus right
nnoremap <Leader>L :vsp<CR>   " Add and focus right
nnoremap <Leader>h <C-W>h     " Focus left
nnoremap <Leader>s :sp<Space> " Add below with arguments
nnoremap <Leader>v :vsp<Space> " Add right with arguments

" Themes, colors, icons

Plugin 'ryanoasis/vim-devicons'
set ls=0
set stal=2

" Decorations
Plugin 'airblade/vim-gitgutter'
" Whitespace visualization

" TODO restore whitespace highlighting
Plugin 'Yggdroot/indentLine'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'nathanaelkane/vim-indent-guides'

hi IndentGuidesOdd ctermfg=245 cterm=bold
hi IndentGuidesEven ctermfg=250 cterm=bold
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=1
let g:vim_indent_cont=0

Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'DoxygenToolkit.vim'
let g:DoxygenToolkit_interCommentBlock=""
let g:DoxygenToolkit_compactOneLineDoc="yes"
let g:DoxygenToolkit_compactDoc="yes"
Plugin 'CompleteHelper'

" RO plugins
Plugin 'jez/vim-superman'

" Language support
" Plugin 'bash-support.vim'

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
map <C-v> <C-V>                        " Unicode entry (c-V is xclip paste)

exec buf_nre . ' * :set tw=78 cc=+1'
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


set tw=78 cc=+1 noet nosi noai noci nocin nopi sts=0 sw=4 ts=4
hi CursorColumn ctermbg=232 cterm=none,bold
hi CursorLine cterm=none,bold ctermbg=232
hi ColorColumn cterm=underline ctermbg=none
