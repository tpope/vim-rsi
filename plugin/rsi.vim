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

inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"

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

noremap!        <M-b> <S-Left>
noremap!        <M-d> <C-O>dw
cnoremap        <M-d> <S-Right><C-W>
noremap!        <M-BS> <C-W>
noremap!        <M-f> <S-Right>
noremap!        <M-n> <Down>
noremap!        <M-p> <Up>

if !has("gui_running")
  augroup map_esc_key
    autocmd!
    autocmd BufEnter *
          \  inoremap <buffer><nowait> <Esc> <Esc>
          \| cnoremap <buffer><nowait> <Esc> <C-c>
  augroup END

  augroup map_meta_chords
    autocmd!
    autocmd InsertEnter *
          \  let s:saveupdatetime = &updatetime
          \| set updatetime=0
    autocmd CursorHoldI *
          \  let &updatetime = s:saveupdatetime
          \| inoremap <Esc>b <S-Left>
          \| inoremap <Esc>d <C-O>dw
          \| inoremap <Esc><BS> <C-W>
          \| inoremap <Esc>f <S-Right>
          \| inoremap <Esc>n <Down>
          \| inoremap <Esc>p <Up>
    autocmd InsertLeave *
          \ let &updatetime = s:saveupdatetime
          \| silent! iunmap <Esc>b
          \| silent! iunmap <Esc>d
          \| silent! iunmap <Esc><BS>
          \| silent! iunmap <Esc>f
          \| silent! iunmap <Esc>n
          \| silent! iunmap <Esc>p
  augroup END

  cnoremap <Esc>b <S-Left>
  cnoremap <Esc>d <S-Right><C-W>
  cnoremap <Esc><BS> <C-W>
  cnoremap <Esc>f <S-Right>
  cnoremap <Esc>n <Down>
  cnoremap <Esc>p <Up>
endif

" vim:set et sw=2:
