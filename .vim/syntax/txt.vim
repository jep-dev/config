" Vim syntax file
" Language: Text
" Maintainer: John Petersen
" Latest Revision: 28 Jan 2017

if exists("b:current_syntax")
	finish
endif

syn match singleQuote '\'[^\']*\''
hi singleQuote ctermfg=216

syn match hashComment '#.*'
hi def link hashComment Comment
hi hashComment ctermfg=225
