" Vim syntax file
" Language: c++
" Maintainer: John Petersen
" Latest Revision: 08 Feb 2017

" if exists("b:current_syntax")
" 	finish
" endif

syn match directive '^#.*$'
hi directive term=inverse cterm=inverse
