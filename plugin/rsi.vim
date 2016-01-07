" rsi.vim - Readline style insertion
" Maintainer:   Tim Pope
" Version:      1.0
" GetLatestVimScripts: 4359 1 :AutoInstall: rsi.vim

if exists("g:loaded_rsi") || v:version < 700 || &cp
  finish
endif
let g:loaded_rsi = 1

set ttimeout
if &ttimeoutlen == -1
  set ttimeoutlen=50
endif

let g:keep_undo_sequence = v:version > 704 || v:version == 704 && has("patch849") ? 1 : 0

inoremap <expr> <C-A> empty(g:keep_undo_sequence)
\ ? "\<Lt>C-O>^"
\ : col('.') >= match(getline('.'), '\S') + 1
\   ? repeat('<C-G>U<Left>', col('.') - match(getline('.'), '\S') - 1)
\   : repeat('<C-G>U<Right>', match(getline('.'), '\S') - col('.') + 1)
inoremap   <C-X><C-A> <C-A>
cnoremap        <C-A> <Home>
cnoremap   <C-X><C-A> <C-A>

inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))
\ ? "0\<Lt>C-D>\<Lt>Esc>kJs"
\ : g:keep_undo_sequence
\   ? "\<Lt>C-G>U\<Lt>Left>"
\   : "\<Lt>Left>"
cnoremap        <C-B> <Left>

inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"

inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()
\ ? "\<Lt>C-E>"
\ : empty(g:keep_undo_sequence)
\   ? "\<Lt>End>"
\   : repeat('<C-G>U<Right>', strlen(getline('.')) - col('.') + 1)

inoremap <expr> <C-F> col('.')>strlen(getline('.'))
\ ? "\<Lt>C-F>"
\ : g:keep_undo_sequence
\   ? "\<Lt>C-G>U\<Lt>Right>"
\   : "\<Lt>Right>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

if empty(mapcheck('<C-G>', 'c'))
  cmap <script> <C-G> <C-C>
endif

noremap! <expr> <SID>transposition getcmdpos()>strlen(getcmdline())?"\<Left>":getcmdpos()>1?'':"\<Right>"
noremap! <expr> <SID>transpose "\<BS>\<Right>".matchstr(getcmdline()[0 : getcmdpos()-2], '.$')
cmap   <script> <C-T> <SID>transposition<SID>transpose

if exists('g:rsi_no_meta')
  finish
endif

if &encoding ==# 'latin1' && has('gui_running') && !empty(findfile('plugin/sensible.vim', escape(&rtp, ' ')))
  set encoding=utf-8
endif

noremap!        <M-b> <S-Left>
noremap!        <M-d> <C-O>dw
cnoremap        <M-d> <S-Right><C-W>
noremap!        <M-BS> <C-W>
noremap!        <M-f> <S-Right>
noremap!        <M-n> <Down>
noremap!        <M-p> <Up>

if !has("gui_running")
  silent! exe "set <S-Left>=\<Esc>b"
  silent! exe "set <S-Right>=\<Esc>f"
  silent! exe "set <F31>=\<Esc>d"
  silent! exe "set <F32>=\<Esc>n"
  silent! exe "set <F33>=\<Esc>p"
  silent! exe "set <F34>=\<Esc>\<C-?>"
  silent! exe "set <F35>=\<Esc>\<C-H>"
  map! <F31> <M-d>
  map! <F32> <M-n>
  map! <F33> <M-p>
  map! <F34> <M-BS>
  map! <F35> <M-BS>
  map <F31> <M-d>
  map <F32> <M-n>
  map <F33> <M-p>
  map <F34> <M-BS>
  map <F35> <M-BS>
endif

" vim:set et sw=2:
