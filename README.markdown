# vim-textobj-sentence

> Improving on Vim's native sentence text object and motion

Detecting sentences can be tricky, esp. when the words and punctuation of
a sentence are interspersed with abbreviations, “quotations,”
(parentheses), [brackets], the \_\_markup\_\_ from \*\*lightweight\*\*
markup languages, and hard<br>line<br>breaks.

While Vim’s native sentence text object is quite capable, its behavior
remains hard-coded and cannot be extended. Thus arises the need for
a specialized text object offered by this plugin.

Features of this plugin:

* Sophisticated sentence text object, supporting selection, motion, and jump
* Implemented with regular expressions via the [vim-textobj-user][vt] plugin
* Supports sentences containing common abbreviations (configurable)
* Support for sentences containing typographical characters, incl. quotes,
  em dash, etc.
* Support for lightweight markup languages (markdown, e.g.)
* Buffer scoped configuration

## Installation

You can install using your favorite Vim package manager. (E.g.,
[Pathogen][pathogen], [Vundle][vundle], or [Plug][plug].) If you are using
a recent version of vim or neovim, you can also use native package
support. (See [:help packages][packages].)

[pathogen]: https://github.com/tpope/vim-pathogen
[vundle]: https://github.com/VundleVim/Vundle.vim
[plug]: https://github.com/junegunn/vim-plug
[packages]: https://vimhelp.org/repeat.txt.html#packages

This plugin has an essential dependency that you will need to install:

* [kana/vim-textobj-user][vt] - a Vim plugin to create your own text
  objects without pain

[vt]: https://github.com/kana/vim-textobj-user

## Configuration

Because prose benefits more than code from a sentence text object, the
behavior of this plugin can be configured per file type. For example, to
enable sentence  in `markdown` and `textile` files, place in your
`.vimrc`:

```vim
set nocompatible            " this may already be in your .vimrc
filetype plugin indent on   " ...and this too

augroup textobj_sentence
  autocmd!
  autocmd FileType markdown call textobj#sentence#init()
  autocmd FileType textile call textobj#sentence#init()
augroup END
```

### Decimal numbers and abbreviations

Though the period `.` glyph/character will normally terminate a sentence,
it also has other uses. For example, the same glyph is used in
abbreviations like  ‘M.D.’ for Medical Doctor. These abbreviations, however,
should be tolerated when detecting the boundaries of a sentence. The
following should be considered one text object, rather than four:

```
Magnum, P.I. lives at Robin’s Nest, located at 11435 18th Ave., Oahu, HI.
```

This plugin detects decimal numbers and common abbreviations. By default,
the following abbreviations will be recognized:

```
  let g:textobj#sentence#abbreviations = [
    \ '[ABCDIMPSUabcdegimpsv]',
    \ 'l[ab]', '[eRr]d', 'Ph', '[Ccp]l', '[Lli]n', '[cn]o',
    \ '[Oe]p', '[DJMSh]r', '[MVv]s', '[CFMPScfpw]t',
    \ 'alt', '[Ee]tc', 'div', 'es[pt]', '[Ll]td', 'min',
    \ '[MD]rs', '[Aa]pt', '[Aa]ve?', '[Ss]tr?',
    \ '[Aa]ssn', '[Bb]lvd', '[Dd]ept', 'incl', 'Inst', 'Prof', 'Univ',
    \ ]
```

Note that you can override/modify the above defaults in your `.vimrc`, but
be sure to include the declaration before your call to
`textobj#sentence#init()`.

### Motion commands

Motion commands on text objects are a powerful feature of Vim.

This plugin overrides Vim’s native commands for sentence selection:

* `as` - select ‘_around_’ sentence with trailing whitespace
* `is` - select ‘_inside_’ sentence without trailing whitespace

* `(` - move to start of previous sentence
* `)` - move to start of next sentence

This plugin adds:

* `g)` - jump to end of current sentence
* `g(` - jump to end of previous sentence

You can manipulate text just as with Vim’s original `as` and `is`
commands, such as `cis` for change, `vas` for visual selection, `das` for
deletion, `yas` for yanking to clipboard, etc.. Note that count isn’t
supported at present (due to limitations of the underlying
vim-textobj-user) but repeat with `.` does work.

If you prefer to retain the native commands, you can assign other
key mappings via your `.vimrc`:

  ```vim
  let g:textobj#sentence#select = 's'
  let g:textobj#sentence#move_p = '('
  let g:textobj#sentence#move_n = ')'
  ```

## See also

If you find this plugin useful, check out these others originally by
[@reedes][re]:

* [vim-colors-pencil][cp] - color scheme for Vim inspired by IA Writer
* [vim-lexical][lx] - building on Vim’s spell-check and
  thesaurus/dictionary completion
* [vim-litecorrect][lc] - lightweight auto-correction for Vim
* [vim-pencil][pn] - rethinking Vim as a tool for writers
* [vim-textobj-quote][qu] - extends Vim to support typographic (‘curly’) quotes
* [vim-thematic][th] - modify Vim’s appearance to suit your task and environment
* [vim-wheel][wh] - screen-anchored cursor movement for Vim
* [vim-wordy][wo] - uncovering usage problems in writing
* [vim-wordchipper][wc] - power tool for shredding text in Insert mode

[re]: https://github.com/reedes
[cp]: https://github.com/preservim/vim-colors-pencil
[lx]: https://github.com/preservim/vim-lexical
[lc]: https://github.com/preservim/vim-litecorrect
[pn]: https://github.com/preservim/vim-pencil
[qu]: https://github.com/preservim/vim-textobj-quote
[th]: https://github.com/preservim/vim-thematic
[wh]: https://github.com/preservim/vim-wheel
[wo]: https://github.com/preservim/vim-wordy
[wc]: https://github.com/preservim/vim-wordchipper

## Future development

If you’ve spotted a problem or have an idea on improving this plugin,
please post it to the [GitHub project issue page][issues].

[issues]: https://github.com/preservim/vim-textobj-sentence/issues

<!-- vim: set tw=74 :-->
