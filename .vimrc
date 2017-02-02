set nocompatible              " be iMproved, required
filetype off                  " required
set shortmess=a				  " shorten load message
set number

set undofile
set undodir=$HOME/share/vimundo
set undolevels=1000
set undoreload=10000

let color_palette=[
		\225, 216, 186, 185, 247, 15, 203, 217,
		\155, 139, 208, 81, 6, 214, 106, 14
	\]
let general_color_set=[
		\[['Number', 'Comment'], 0], [['String'], 1], [['Macro'], 15]
	\]
let vim_color_set=[
		\[['HiNmbr', 'HiAttrib', 'Option', 'Comment', 'LineComment'], 0],
		\[['Bracket'], 2], [['Map', 'Command'], 3],
		\[['Oper', 'ParenSep', 'Notation', 'Continue'], 4]
	\]
let make_color_set=[
			\[['Comment'], 0],
			\[['NextLine', 'CmdNextLine', 'Include', 'Target', 'Define'], 14],
			\[['Commands'], 13]
		\]
let sh_color_set=[
		\[['Comment'], 0], [['Statement'], 1],
		\[['Repeat', 'CaseIn', 'SnglCase', 'Conditional',
			\'Range', 'Operator'], 8],
		\[['Variable'], 11],
		\[['Quote', 'CommandSub', 'Set', 'CmdSubRegion', 'SetList'], 15]
	\]
let cpp_color_set=[
		\[['Included'], 2], [['Include', 'PreCondit', 'Define'], 3],
		\[['Constant', 'String', 'Boolean', 'Float', 'Character', 'Number',
			\'Bracket', 'CustomAngleBracketStart', 'CustomAngleBracketEnd',
			\'Block', 'Paren'], 5],
		\[['Special'], 6],
		\[['Type', 'STLexception', 'STLfunctional', 'STLtype',
			\'STLconstant', 'STLnamespace', 'STLios'], 7],
		\[['StorageClass', 'Modifier', 'Repeat', 'Statement',
			\'Label', 'UserLabel', 'Conditional', 'CustomTemplate', 'Structure'], 8],
		\[['PreProc', 'CustomAngleBracketStart'], 9],
		\[['Operator'], 10],
		\[['CustomClass', 'Comment'], 11],
		\[['CustomTemplateClass'], 12], [['Function', 'CustomFunc'], 13]
	\]


set cc=80
set ruler
highlight ColorColumn ctermbg=240 "130

set t_Co=256
highlight Visual term=reverse cterm=reverse guibg=Black ctermbg=Black
highlight Nontext ctermbg=none
highlight Normal ctermfg=186 ctermbg=none
highlight Pmenu ctermfg=231 ctermbg=16

highlight confComment ctermfg=225 "146
highlight Special ctermfg=203

set cursorline
set ttymouse=xterm2
highlight CursorLine cterm=none
highlight LineNr ctermfg=208
highlight CursorLineNr ctermfg=214

highlight confString ctermfg=106
highlight markdownCodeDelimiter ctermfg=159

set noet ci pi sts=0 sw=4 ts=4
set backspace=indent,eol,start
set cinoptions=l1
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin 'ervandew/supertab'
let g:SuperTabClosePreviewOnPopupClose=1
" let g:SuperTabDefaultCompleteType='context'
let g:SuperTabDefaultCompleteType='<c-x><c-u><c-p><c-n>'
" let g:SuperTabDefaultCompleteType='<c-p><c-x><c-n>'

Plugin 'myint/clang_complete'
"Plugin 'Rip-Rip/clang_complete'
let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_complete_hl_errors=1
let g:clang_close_preview=1
let g:clang_c_options='-std=gnu11'
let g:clang_cpp_options='-std=c++11 -stdlib=libc++'
let g:clang_snippets=1
let g:clang_snippets_engine='clang_complete'
let g:clang_conceal_snippets=0
let g:clang_use_library=1
let g:clang_library_path="/home/john/Downloads/llvm/lib/"
let g:clang_sort_algo='alpha'
let g:clang_user_options=' -I/home/john/workspace/boost/boost ||exit 0'

Plugin 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight=1
let g:cpp_experimental_template_highlight=1


" :inoremap <tab> <c-x><c-u>
:inoremap <c-@> <c-x><c-u>
:inoremap <NUL> <c-x><c-u>
:inoremap <Tab> <c-x><c-u>
:inoremap <S-Tab> <Tab>
:set dictionary="/usr/dict/words"

noremap! <F3> <Esc>

noremap! <n> <NOP>
noremap! <m> <NOP>
:inoremap <\<> <NOP>

set conceallevel=2
set concealcursor=vin
set completeopt=menu,longest
" set completeopt=menuone,menu
set completeopt-=preview
set pumheight=20

" set foldmethod=indent
" noremap! <T-c> <Esc>:wq
inoremap <F2> <c-o>:

syntax on
set mouse=a
set showcmd
" # set number

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
			\| exe "normal! g'\"4kzt4j" | endif
" au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

let buf_nre='au BufNewFile,BufRead,BufEnter'

exec buf_nre . ' *.txt set filetype=txt'

exec buf_nre . ' *.cpp,*.tpp,*.hpp set'
			\ . ' filetype=cpp omnifunc=omni#cpp#complete#Main'
			\ . ' completefunc=ClangComplete'
" exec buf_nre . ' *.cpp,*.tpp,*.hpp set'
			" \ . ' filetype=cpp omnifunc=ClangComplete'
			" \ . ' completefunc=ClangComplete'
exec buf_nre . ' *.mk,Makefile set filetype=make'

call vundle#end()            " required
filetype plugin indent on    " required

" syntax highlighter active at cursor (hi/transient/low)
map <F10> :echo "hi<"
			\ . synIDattr(synID(line("."),col("."),1),"name") . "> trans<"
			\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
			\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
			\ . ">"<CR>

vmap <C-c> :w! ~/.vimbuffer<CR>
nmap <C-c> :.w! ~/.vimbuffer<CR>
map <C-p> :r ~/.vimbuffer<CR>

command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis
nnoremap <C-W> :DiffOrig<CR>

" Switch between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set encoding=utf8
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ryanoasis/vim-devicons'
Plugin 'jez/vim-superman'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'ntpeters/vim-better-whitespace'

set guifont=FuraMono-Medium\ Powerline\ 10
let g:airline_powerline_fonts=1
" let g:airline_theme='hybridline'
" let g:airline_theme='behelit'
" let g:airline_theme='base16color'
let g:airline_theme='base16_eighties'
set laststatus=2

for co in general_color_set
	for pre in ['', 'vim']
		for var in co[0]
			execute 'hi ' . pre . var . ' ctermfg=' . color_palette[co[1]]
		endfor
	endfor
endfor
for co in make_color_set
	for var in co[0]
		execute 'hi make' . var . ' ctermfg=' . color_palette[co[1]]
	endfor
endfor
for co in sh_color_set
	for var in co[0]
		execute 'hi sh' . var . ' ctermfg=' . color_palette[co[1]]
	endfor
endfor
for co in vim_color_set
	for var in co[0]
		execute 'hi vim' . var . ' ctermfg=' . color_palette[co[1]]
	endfor
endfor
for co in cpp_color_set
	for pre in ['c', 'cpp']
		for var in co[0]
			execute 'hi ' . var . ' ctermfg=' . color_palette[co[1]]
		endfor
	endfor
endfor
