
" hi IndentGuidesOdd ctermfg=147
" hi IndentGuidesEven ctermfg=179

" hi IndentGuidesOdd ctermfg=51 ctermbg=155 cterm=bold
" hi IndentGuidesEven ctermfg=51 ctermbg=155 cterm=bold

exec onNewRead '*.tpp set filetype=cpp'

hi NonText      ctermbg=None
hi Normal       ctermbg=None
hi Comment      ctermfg=195 " 117
hi Structure    ctermfg=155 " 167 51 77 210
hi Type         ctermfg=51 "180 141
hi Statement    ctermfg=220
hi Identifier   ctermfg=204 " 167 216 149 222
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

hi bufferline_selected ctermbg=75 ctermfg=232
hi bufferline_selected_inactive ctermbg=232 ctermfg=75

hi airline_a ctermbg=209 ctermfg=232
hi airline_a_to_airline_b ctermbg=232 ctermfg=215
hi airline_b ctermbg=232 ctermfg=189
hi airline_b_to_airline_c ctermfg=232 ctermfg=156
hi airline_c ctermbg=232 ctermfg=51
hi airline_c_to_airline_x ctermbg=232 ctermfg=213
hi airline_x ctermbg=232 ctermfg=51
hi airline_x_to_airline_y ctermbg=232 ctermfg=203
hi airline_y ctermbg=232 ctermfg=51
hi airline_y_to_airline_z ctermbg=232 ctermfg=203
hi airline_z ctermbg=232 ctermfg=202
hi airline_a_red ctermbg=209 ctermfg=232
hi airline_a_to_airline_b_red ctermbg=232 ctermfg=215
hi airline_b_red ctermbg=232 ctermfg=189
hi airline_b_to_airline_c_red ctermfg=232 ctermfg=156
hi airline_c_red ctermbg=232 ctermfg=123
hi airline_c_to_airline_x_red ctermbg=232 ctermfg=213
hi airline_x_red ctermbg=232 ctermfg=207
hi airline_x_to_airline_y_red ctermbg=232 ctermfg=203
hi airline_y_red ctermbg=232 ctermfg=202
hi airline_y_to_airline_z_red ctermbg=232 ctermfg=203
hi airline_z_red ctermbg=232 ctermfg=202
hi airline_a_bold ctermbg=209 ctermfg=232
hi airline_a_to_airline_b_bold ctermbg=232 ctermfg=215
hi airline_b_bold ctermbg=232 ctermfg=189
hi airline_b_to_airline_c_bold ctermfg=232 ctermfg=156
hi airline_c_bold ctermbg=232 ctermfg=123
hi airline_c_to_airline_x_bold ctermbg=232 ctermfg=213
hi airline_x_bold ctermbg=232 ctermfg=207
hi airline_x_to_airline_y_bold ctermbg=232 ctermfg=203
hi airline_y_bold ctermbg=232 ctermfg=202
hi airline_y_to_airline_z_bold ctermbg=232 ctermfg=203
hi airline_z_bold ctermbg=232 ctermfg=202
