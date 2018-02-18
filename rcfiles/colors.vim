
" hi IndentGuidesOdd ctermfg=147
" hi IndentGuidesEven ctermfg=179

" hi IndentGuidesOdd ctermfg=51 ctermbg=155 cterm=bold
" hi IndentGuidesEven ctermfg=51 ctermbg=155 cterm=bold

exec onNewRead '*.tpp set filetype=cpp'

hi NonText      ctermbg=None
hi Normal       ctermbg=None
hi Comment      ctermfg=195 " 117
hi Structure    ctermfg=167 "51 77 210
hi Type         ctermfg=119 "180 141
hi Statement    ctermfg=51
hi Identifier   ctermfg=167 "216 149 222
hi Constant     ctermfg=107 cterm=italic
hi Special      ctermfg=155 cterm=italic

hi TabLine ctermbg=none ctermfg=231
hi TabLineFill ctermbg=none ctermfg=231

hi CursorColumn     ctermbg=232
hi CursorLine       ctermbg=232 cterm=bold
hi CursorLineNr     ctermbg=232 ctermfg=75   cterm=bold,reverse
hi LineNr           ctermfg=75  ctermbg=232  cterm=bold
hi VimComment       ctermfg=155 ctermbg=none
hi VimLineComment   ctermfg=155 ctermbg=none
