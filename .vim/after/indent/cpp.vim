" 4:20 June 4: setlocal cinoptions=0s,b0,l0,(0,W4,(s,+-10s,0#,#0

" lM; bN; LO; :P; -> align with case labels; align break, other label, labeled statements

" gM; hN -> align scope declarations to flush + M; scoped statements

" +N -> align continuations (on overflow) to flush + N
" cM; CN, N!=0 -> align comment line to flush + M; suggest unless capitalized
" (M; uN -> align in P parens to flush+shiftwidth*P+M; in P+1 parens to ...+N
" wM; WN -> align to M from parens and not first nonwhite; align to N from outer block
"



setlocal noai
setlocal indentexpr=
"setlocal ci cin
"setlocal cinkeys=0{,0},0),:,!^F,o,O,e
setlocal noci nocin cino=l0,Ls,b0,:0,0s,(0,ws,Ws,(s,+0,0#,#0,g0,i0

setlocal noet noci nocin si pi sts=0 sw=4 ts=4
