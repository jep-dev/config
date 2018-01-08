
let mapleader=","

exe 'set t_kB=' . nr2char(27) . '[Z'

nmap <Tab> >>
nmap <S-Tab> <<
imap <Tab> <c-x><c-u>

noremap <Leader><h> :s/^[\t]\(.*\)$/\1/
" noremap <Leader><l> :s/^\(.*\)$/\t\1/

map <leader><Space> :.s/$/\=repeat(' ',79-col('$'))
noremap <C-l> <\t>

map <F10> :call Syn_at()<CR>

noremap! <n> <NOP>
noremap! <m> <NOP>

map <F10> :call Syn_at()<CR>

noremap U <C-R>
vmap <C-c> :w! ~/.vimbuffer<CR>
nmap <C-c> :.w! ~/.vimbuffer<CR>
map <C-p> :r ~/.vimbuffer<CR>

" Open new file
map <C-n> :tabe<CR>
map <Leader>n :badd<CR>
" Open new tab
map <C-o> :tabe<space>
map <Leader>o :badd<space>
" Left tab
nmap <Leader>. :tabn<CR>
nmap <Leader>\> :bn<CR>
" Right tab
nmap <Leader>, :tabp<CR>
nmap <Leader>\< :bp<CR>

" Open tab tree
" map <Leader>d :NERDTree<CR>

" Splits
" Focus below (alt.)
nnoremap <Leader>A <C-W>j
" Focus below
nnoremap <Leader>j <C-W>j
" Add and focus below
nnoremap <Leader>J :sp<CR>
" Alternative horizontal split
nnoremap _ :sp<CR>
" Focus above
nnoremap <Leader>k <C-W>k
" Focus right
nnoremap <Leader>l <C-W>l
" Add and focus right
nnoremap <Leader>L :vsp<CR>
" Alternate vertical split
nnoremap \| :vsp<CR>
" Focus left
nnoremap <Leader>h <C-W>h
" Add below with arguments
nnoremap <Leader>s :sp<Space>

" Binding to C-a/e overrides Home/End!
" nmap <Home> 0w
" nmap <C-a> 0w
" imap <C-a> <Esc>I
" nmap <C-e> $
" imap <C-e> <Esc>A
" Add right with arguments
nnoremap <Leader>v :vsp<Space>


map <leader><Space> :.s/$/\=repeat(' ',79-col('$'))<CR>
map <leader># :.s/$/\=repeat('#',79-col('$'))<CR>
	\ asdf
" Line unquote, default style is vim
" map <C-z> :s/^\([ \t]*\)"[ ]*/\1/<CR>
" key bindings so they can change
" map <Leader>z [%V]%<C-z>
" Unicode entry (c-V is xclip paste)
map <C-v> <C-V>
