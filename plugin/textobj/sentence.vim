" ============================================================================
" File:        textobj_sentence.vim
" Description: load functions for vim-textobj_sentence plugin
" Maintainer:  Reed Esau <github.com/reedes>
" Created:     January 25, 2013
" License:     The MIT License (MIT)
" ============================================================================

scriptencoding utf-8

if exists('g:loaded_textobj_sentence') | finish | endif

if !exists('g:textobj#sentence#select')
  let g:textobj#sentence#select = 's'
endif

if !exists('g:textobj#sentence#move_p')
  let g:textobj#sentence#move_p = '('
endif

if !exists('g:textobj#sentence#move_n')
  let g:textobj#sentence#move_n = ')'
endif

if !exists('g:textobj#sentence#quotable_dl')
  let g:textobj#sentence#quotable_dl = '“'
endif
if !exists('g:textobj#sentence#quotable_dr')
  let g:textobj#sentence#quotable_dr = '”'
endif

if !exists('g:textobj#sentence#quotable_sl')
  let g:textobj#sentence#quotable_sl = '‘'
endif
if !exists('g:textobj#sentence#quotable_sr')
  let g:textobj#sentence#quotable_sr = '’'
endif

if !exists('g:textobj#sentence#abbreviations')
  let g:textobj#sentence#abbreviations = [
    \ 'Mr', 'Mr?s', 'Drs?', 'Prof', '[JS]r',
    \ 'vs', 'etc', 'no', 'esp',
    \ '[FM]t',
    \ 'Ave', 'Blvd', 'C[lt]', 'Str',]
endif

let s:quotes_std = '"'''

" body (sans term) starts with an uppercase character (excluding acronyms)
let s:re_sentence_body =
    \ '[' .
    \ s:quotes_std .
    \ g:textobj#sentence#quotable_sl .
    \ g:textobj#sentence#quotable_dl .
    \ ']?[[:upper:]]\_.{-}'

" experiment with limit of 10 on lookback
" TODO query the largest of the abbreviations
let s:re_abbrev_neg_lookback =
    \ len(g:textobj#sentence#abbreviations) > 0
    \ ? '(' .
    \   join(g:textobj#sentence#abbreviations, '|') .
    \   ')@10<!'
    \ : ''

" matching against end of sentence, '!', '?', and non-abbrev '.'
let s:re_term =
    \ '([!?]|(' .
    \ s:re_abbrev_neg_lookback .
    \ '\.))+[' .
    \ s:quotes_std .
    \ g:textobj#sentence#quotable_sr .
    \ g:textobj#sentence#quotable_dr .
    \ ']?'

" sentence can also end when followed by at least two line feeds
let s:re_sentence_term = '(' . s:re_term . '|\ze(\n\n|\_s*%$))'

" Avoid matching where more of the sentence can be found on preceding line(s)
let s:re_negative_lookback = '([“[:alnum:]](["–—,;:-]|\_s)*)@<!'

let g:textobj#sentence#re_i =
      \ '\v' .
      \ s:re_negative_lookback .
      \ s:re_sentence_body .
      \ s:re_sentence_term

" include all whitespace to end of line
" TODO do we need $
let g:textobj#sentence#re_a =
      \ g:textobj#sentence#re_i .
      \ '($|\s*)'

call textobj#user#plugin('sentence', {
\      'select': {
\         'select-a': 'a' . g:textobj#sentence#select,
\         'select-i': 'i' . g:textobj#sentence#select,
\         '*select-a-function*': 'textobj#sentence#select_a',
\         '*select-i-function*': 'textobj#sentence#select_i',
\      },
\      'move': {
\         'pattern': g:textobj#sentence#re_i,
\         'move-p': g:textobj#sentence#move_p,
\         'move-n': g:textobj#sentence#move_n,
\         'move-P': 'g' . g:textobj#sentence#move_p,
\         'move-N': 'g' . g:textobj#sentence#move_n,
\      },
\})

let g:loaded_textobj_sentence = 1
