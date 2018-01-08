" Highlighting for libraries with simple naming conventions
syn match sdlPrefix 'SDL_[A-Za-z0-9]*'
hi def link sdlPrefix PreProc

hi cppSTLtype       ctermfg=219
hi cppStructure     ctermfg=144 "138
hi cCustomParen     ctermfg=231
hi cParen           ctermfg=231

" Start region found on SO, end is incorrect
" syn region Angles start='\v%(<operator\_s*)@<!%(
" 	\%(\_i|template\_s*)
" 	\@<=\<[<=]@!|\<@<!\<[[:space:]<=]@!)'
" 	\ end='>'
" hi Angles ctermfg=39


let cairo_deprecated_errors = 1
let gdkpixbuf_deprecated_errors = 1
let glib_deprecated_errors = 1
let gtk3_deprecated_errors = 1


runtime! syntax/cairo.vim
runtime! syntax/gdkpixbuf.vim
runtime! syntax/glib.vim
runtime! syntax/gtk3.vim
runtime! syntax/gtkglext.vim

"runtime! syntax/atk.vim
"runtime! syntax/atspi.vim
"runtime! syntax/clutter.vim
"runtime! syntax/colord.vim
"runtime! syntax/dbusglib.vim
"runtime! syntax/evince.vim
"runtime! syntax/fftw3.vim
"runtime! syntax/gimp.vim
"runtime! syntax/gnomedesktop.vim
"runtime! syntax/gobjectintrospection.vim
"runtime! syntax/gstreamer.vim
"runtime! syntax/gtk2.vim
"runtime! syntax/gtksourceview.vim
"runtime! syntax/gudev.vim
"runtime! syntax/gusb.vim
"runtime! syntax/jsonglib.vim
"runtime! syntax/libgsf.vim
"runtime! syntax/libnotify.vim
"runtime! syntax/librsvg.vim
"runtime! syntax/libsoup.vim
"runtime! syntax/libunique.vim
"runtime! syntax/libwnck.vim
"runtime! syntax/pango.vim
"runtime! syntax/poppler.vim
"runtime! syntax/vte.vim
"runtime! syntax/xlib.vim

if exists("b:current_syntax")
	finish
endif

" vim: set ft=vim :
