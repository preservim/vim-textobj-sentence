" ============================================================================
" File:        textobj_sentence.vim
" Description: load functions for vim-textobj_sentence plugin
" Maintainer:  Reed Esau <github.com/reedes>
" Created:     January 25, 2013
" License:     The MIT License (MIT)
" ============================================================================

if exists('g:autoloaded_textobj_sentence') && g:autoloaded_textobj_sentence
  finish
endif

function! s:select(pattern)
  call search(a:pattern, 'bc')
  let l:start = getpos('.')
  call search(a:pattern, 'ce')
  let l:end = getpos('.')
  return ['v', l:start, l:end]
endfunction

function! textobj#sentence#select_a()
  return s:select(g:textobj#sentence#re_a)
endfunction

function! textobj#sentence#select_i()
  return s:select(g:textobj#sentence#re_i)
endfunction

let g:autoloaded_textobj_sentence = 1
