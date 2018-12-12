let mapleader=","

exe 'set t_kB=' . nr2char(27) . '[Z'

map <Tab> >>
map <S-Tab> <<
vmap <Tab> >
vmap <S-Tab> <
imap <Tab> <c-x><c-u>

vmap * :s/\/\* *\\| *\*\///g<CR>
nmap * :s/\([ \t]*\)\(.*\)/\1\/* \2 *\//g<CR>

noremap <Leader><h> :s/^[\t]\(.*\)$/\1/
" noremap <Leader><l> :s/^\(.*\)$/\t\1/

map <leader><Space> :.s/$/\=repeat(' ',79-col('$'))
noremap <C-l> <\t>

map <F10> :call Syn_at()<CR>

noremap! <n> <Nop>
noremap! <m> <Nop>
" Mappings necessary to make 'noesckeys' work - unsuccessful
" noremap! 0A <Up>
" noremap! 0B <Down>
" noremap! 0C <Right>
" noremap! 0D <Left>

map <F10> :call Syn_at()<CR>

noremap U <C-R>
vmap <C-c> :w! ~/.vimbuffer<CR>
nmap <C-c> :.w! ~/.vimbuffer<CR>
map <C-p> :r ~/.vimbuffer<CR>

set hidden
map q :call CloseOrQuit()<CR>

" Open new file
map <C-n> :enew<CR>
" Open new buffer
map <C-o> :badd<space>
" Previous buffer
map <Leader>, :bp<CR>
" Next buffer
map <Leader>. :bn<CR>
" Remove (unmodified) buffer
map <Leader>d :bd<CR>

" Open tab tree
map <F2> :NERDTreeToggle<CR>

" Splits
" Focus below (alt.)
nnoremap <Leader>A <C-W>j
" Focus below
nnoremap <Leader>j <C-W>j

" Alternate vertical split
"nnoremap \| :vsp<CR>
" Alternative horizontal split
"nnoremap _ :sp<CR>
" Split vertically on return
nnoremap \| :vsp<Space>
" Split horizontally on return
nnoremap _ :sp<Space>
" Split left on return
"nnoremap <Leader>L :topleft vsp<Space>
" Split right on return
"nnoremap <Leader>R :botright vsp<Space>
" Add and focus below
"nnoremap <Leader>J :sp<CR>
" Add below with arguments
"nnoremap <Leader>s :sp<Space>


" Focus above
nnoremap <Leader>k <C-W>k
" Focus right
nnoremap <Leader>l <C-W>l
" Focus left
nnoremap <Leader>h <C-W>h

" Turn off normal K: man <word under cursor>
" ('word' will exclude std::, etc., even if that page exists)
" Most presses are accidental (k), and most intentional presses fail to find a page.
nmap K k
" Leave visual K on: man <selection>
" ('selection' must exactly match the page name)
" vmap K k

" nmap <Home> 0w
" nmap <C-a> 0w
" imap <C-a> <Esc>I
" nmap <C-e> $
" imap <C-e> <Esc>A

exec 'au BufNewFile,BufEnter *.php inoremap <Tab> <c-x><c-o>'

"map <leader><Space> :.s/$/\=repeat(' ',79-col('$'))<CR>
"" map <leader><Space> :.s/$/\=repeat(' ',&columns-&numberwidth-1-col('$'))<CR>
"map <leader># :.s/$/\=repeat('#',79-col('$'))<CR>
"	\ asdf
" Unicode entry (c-V is xclip paste)
map <C-v> <C-V>
