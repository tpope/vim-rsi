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

inoremap        <C-A> <C-O>^
inoremap   <C-X><C-A> <C-A>
cnoremap        <C-A> <Home>
cnoremap   <C-X><C-A> <C-A>

inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
cnoremap        <C-B> <Left>

inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"

inoremap <expr> <C-E> col('.')>strlen(getline('.'))?"\<Lt>C-E>":"\<Lt>End>"

inoremap <expr> <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
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

function! RsiCliLeft()
  let line = getcmdline()
  let pos = getcmdpos()

  let next = 1
  let nextnext = 1
  let i = 2
  while nextnext < pos
    let next = nextnext
    let nextnext = match(line, '\<\S\|\>\S\|\s\zs\S\|^\|$', 0, i) + 1
    let i += 1
  endwhile

  return repeat("\<Left>", pos - next)
endfunction

function! RsiCliRight()
  let line = getcmdline()
  let pos = getcmdpos()

  let next = 1
  let i = 2
  while next <= pos && next > 0
    let next = match(line, '\<\S\|\>\S\|\s\zs\S\|^\|$', 0, i) + 1
    let i += 1
  endwhile

  return repeat("\<Right>", next - pos)
endfunction


inoremap        <M-b> <C-O>b
cnoremap <expr> <M-b> RsiCliLeft()
nnoremap        <M-b> b
noremap!        <M-d> <C-O>dw
cnoremap        <M-d> <S-Right><C-W>
noremap!        <M-BS> <C-W>
inoremap        <M-f> <C-O>w
cnoremap <expr> <M-f> RsiCliRight()
nnoremap        <M-f> w
noremap!        <M-n> <Down>
noremap!        <M-p> <Up>

if !has("gui_running")
  silent! exe "set <F31>=\<Esc>d"
  silent! exe "set <F32>=\<Esc>n"
  silent! exe "set <F33>=\<Esc>p"
  silent! exe "set <F34>=\<Esc>\<C-?>"
  silent! exe "set <F35>=\<Esc>\<C-H>"
  silent! exe "set <F36>=\<Esc>b"
  silent! exe "set <F37>=\<Esc>f"
  map! <F31> <M-d>
  map! <F32> <M-n>
  map! <F33> <M-p>
  map! <F34> <M-BS>
  map! <F35> <M-BS>
  imap <F36> <M-b>
  cnoremap <expr> <F36> RsiCliLeft()
  imap <F37> <M-f>
  cnoremap <expr> <F37> RsiCliRight()
  map <F31> <M-d>
  map <F32> <M-n>
  map <F33> <M-p>
  map <F34> <M-BS>
  map <F35> <M-BS>
  map <F36> <M-b>
  map <F37> <M-f>
endif

" vim:set et sw=2:
