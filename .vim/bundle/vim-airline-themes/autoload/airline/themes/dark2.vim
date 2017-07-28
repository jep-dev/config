scriptencoding utf-8
let g:airline#themes#dark#palette = {}

let s:fg_unmod=10
let s:fg_mod=11
let s:fg_paste=14

let s:bg_norm=17
let s:bg_ins=22
let s:bg_repl=28
let s:bg_vis=53
let s:bg_ia=239

let s:fg_b=15
let s:bg_b=16

let s:N1   = [ '#00005f' , '#dfff00' , 15 , s:bg_norm ]
let s:N2   = [ '#ffffff' , '#444444' , s:fg_b , s:bg_norm ]
let s:N3   = [ '#9cffd3' , '#202020' , s:fg_unmod , 16 ]
let g:airline#themes#dark#palette.normal =
	\airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#dark#palette.normal_modified =
	\{'airline_c': [ '#ffffff' , '#5f005f' , s:fg_mod , '' , '' ]}

" 15/53, 123/16; modified 82/''
let s:I1 = [ '#00005f' , '#00dfff' , 15 , s:bg_ins ]
let s:I2 = [ '#ffffff' , '#005fff' , s:fg_b , s:bg_ins ]
let s:I3 = [ '#ffffff' , '#000080' , s:fg_unmod , 16 ]
let g:airline#themes#dark#palette.insert =
	\airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#dark#palette.insert_modified =
	\{'airline_c': [ '#ffffff' , '#5f005f' , s:fg_mod , 16 , '' ]}
let g:airline#themes#dark#palette.insert_paste =
	\{'airline_a': [ s:I1[0] , '#d78700' , s:I1[2] , s:fg_paste , '' ]}

let g:airline#themes#dark#palette.replace =
	\copy(g:airline#themes#dark#palette.insert)
let g:airline#themes#dark#palette.replace.airline_a =
	\[ s:I2[0] , '#af0000' , s:I2[2] , s:bg_repl , '' ]
let g:airline#themes#dark#palette.replace_modified =
	\g:airline#themes#dark#palette.insert_modified

let s:V1 = [ '#000000' , '#ffaf00' ,  15 , s:bg_vis ]
let s:V2 = [ '#000000' , '#ff5f00' ,  s:fg_b , s:bg_vis ]
let s:V3 = [ '#ffffff' , '#5f0000' , s:fg_unmod , 16 ]
let g:airline#themes#dark#palette.visual =
	\airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#darkpalette.visual_modified =
	\g:airline#themes#dark#palette.insert_modified

let s:IA1 = [ '#4e4e4e' , '#1c1c1c' , 15 , s:bg_ia ]
let s:IA2 = [ '#4e4e4e' , '#262626' , s:fg_b , s:bg_ia ]
let s:IA3 = [ '#4e4e4e' , '#303030' , s:fg_ia , 16 , '' ]
let g:airline#themes#dark#palette.inactive =
	\airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
let g:airline#themes#dark#palette.inactive_modified =
	\g:airline#themes#dark#palette.insert_modified

let g:airline#themes#dark#palette.accents =
	\{'red': [ '#ff0000' , '' , 196 , '' ]}

if get(g:, 'loaded_ctrlp', 0)
	let g:airline#themes#dark#palette.ctrlp =
		\airline#extensions#ctrlp#generate_color_map(
			\ [ '#d7d7ff' , '#5f00af' , 189 ,  55 , ''     ],
			\ [ '#ffffff' , '#875fd7' , 231 ,  98 , ''     ],
			\ [ '#5f00af' , '#ffffff' ,  55 , 231 , 'bold' ]
		\}
endif

