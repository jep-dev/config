
set makeprg=make\ -j
map <F5> :make<CR>

"Yggdroot/indentLine
hi IndentGuidesOdd ctermfg=51 ctermbg=155 cterm=bold
hi IndentGuidesEven ctermfg=51 ctermbg=155 cterm=bold
hi IndentGuidesOdd ctermfg=51 ctermbg=155 cterm=bold
hi IndentGuidesEven ctermfg=51 ctermbg=155 cterm=bold

"vim-airline/vim-airline-themes
let g:airline#extensions#tabline#formatter='unique_tail_improved'
let g:airline_theme='badcat'

"let g:airline#extensions#tmuxline#enabled=0
"let g:tmuxline_theme = {
"    \   'a'    : [  28, 231 ],
"    \   'b'    : [  65, 231 ],
"    \   'c'    : [ 102, 231 ],
"    \   'x'    : [ 139, 232 ],
"    \   'y'    : [ 176, 232 ],
"    \   'z'    : [ 213, 232 ],
"    \   'win'  : [ 103, 236 ],
"    \   'cwin' : [ 236, 103 ],
"    \   'bg'   : [ 244, 236 ],
"    \ }

"DoxygenToolkit.vim
"let g:DoxygenToolkit_interCommentBlock=""
"let g:DoxygenToolkit_compactOneLineDoc="yes"
"let g:DoxygenToolkit_compactDoc="yes"

"Rip-Rip/clang_complete
let g:clang_format#style_options = {
	\'AllowShortIfStatementsOnASingleLine': 'true',
	\'AllowShortLoopsOnASingleLine': 'true',
	\'AllowShortBlocksOnASingleLine': 'true',
	\'AllowShortCaseLabelsOnASingleLine': 'true',
	\'ColumnLimit': 78, 'ContinuationIndentWidth': 8,
	\'AlignAfterOpenBracket': 'DontAlign',
	\'IndentWidth': 4, 'TabWidth': 4, 'UseTab': 'Always'
\}

"nathanaelkane/vim-indent-guides
"let g:indent_guides_auto_colors=0
"let g:indent_guides_enable_on_vim_startup=1
let g:vim_indent_cont=0
let g:clang_format#command = "clang-format"
let g:clang_auto_select=1
let g:clang_complete_auto=0
let g:clang_complete_hl_errors=1
let g:clang_close_preview=1
let g:clang_c_options='-std=gnu11'
let g:clang_cpp_options='-std=c++14 -stdlib=libc++'
let g:clang_sort_algo='alpha'
let g:clang_snippets_engine='clang_complete'
let g:clang_snippets=0
let g:clang_conceal_snippets=0
let g:clang_complete_macros=1
let g:clang_use_library=1
let g:clang_library_path='/usr/lib/x86_64-linux-gnu/libclang-6.0.so'
let g:clang_user_options='|| exit 0'

let g:cpp_class_scope_highlight=1
let g:cpp_concepts_highlight=1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_template_highlight = 1

set completeopt=menu,longest
