# vim-textobj-sentence

> Improving on Vim's native sentence motion command

Detecting sentences can be tricky, esp. when the words and punctuation of
a sentence are interspersed with abbreviations, “quotations,”
(parentheses), [brackets], hard line breaks and the \_\_markup\_\_ from
\*\*lightweight\*\* markup languages.

While Vim’s native sentence text object is quite capable, its reach is
limited. As well its behavior remains hard-coded and static. Thus arises
the need for a specialized text object offered by this plugin.

Features of this plugin:

* Sophisticated sentence text object, supporting selection, motion, etc.
* Implemented with regular expressions via the amazing [vim-textobj-user][vt] plugin
* Supports sentences containing common abbreviations (configurable)
* Support for sentences containing typographical characters, incl. quotes, em dash, etc.
* Support for lightweight markup languages (markdown, e.g.)
* Buffer scoped configuration

## Requirements

May require a recent version of Vim.

## Installation

Install using Pathogen, Vundle, Neobundle, or your favorite Vim package
manager.

This plugin has an important dependency that you will need to install:

* [kana/vim-textobject-user][vt] - a Vim plugin to create your own text objects without pain

[vt]: https://github.com/kana/vim-textobj-user

## Configuration

Because prose benefits more than code from a sentence text object, the
behavior of this plugin can be configured per file type. For example, to
enable sentence  in `markdown` and `textile` files, place in your
`.vimrc`:

```vim
" standard vim command to enable loading the plugin files
" (and their indent support) for specific file types.
" It may already be in your .vimrc!
filetype plugin indent on

augroup textobj_sentence
  autocmd!
  autocmd FileType markdown call textobj#sentence#init()
  autocmd FileType textile call textobj#sentence#init()
augroup END
```

### Decimal numbers and abbreviations

Though the period `.` glyph/character will terminate a sentence, it
use doesn't always indicate so. The same glyph is used in
abbreviations like ‘M.D.’ for Medical Doctor, for example.

But those abbreviations should be compensated for when detecting the
boundaries of a sentence. The following should be considered one text
object, rather than four:

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

Note that you can override the above defaults in your `.vimrc`, but be
sure to include the declaration before your call to `textobj#sentence#init()`.

### Motion commands

Motion commands on text objects are a powerful feature of Vim.

This plugin overrides Vim’s own commands for sentence selection:

* `as` - select ‘around’ sentence with trailing whitespace
* `is` - select ‘inside’ sentence without trailing whitespace

* `)` - move to start of next sentence
* `(` - move to start of previous sentence

This plugin adds:

* `g)` - move to end of next sentence
* `g(` - move to end of previous sentence

You can manipulate text just as with Vim’s original `as` and `is`
commands, such as `cis` for change, `vas` for visual selection, `das` for
deletion, `yas` for yanking to clipboard, etc..

If you prefer to retain the native commands, you can assign other
key mappings via your `.vimrc`:

  ```vim
  let g:textobj#sentence#select = 's'
  let g:textobj#sentence#move_p = '('
  let g:textobj#sentence#move_n = ')'
  ```

## See also

If you find this plugin useful, you might want to check out these others by
[@reedes][re]:

* [vim-colors-pencil][cp] - color scheme for Vim inspired by IA Writer
* [vim-lexical][lx] - building on Vim’s spell-check and thesaurus/dictionary completion
* [vim-litecorrect][lc] - lightweight auto-correction for Vim
* [vim-pencil][pn] - rethinking Vim as a tool for writers
* [vim-quotable][qu] - extends Vim to support typographic (‘curly’) quotes
* [vim-thematic][th] - modify Vim’s appearance to suit your task and environment
* [vim-wheel][wh] - screen-anchored cursor movement for Vim
* [vim-wordy][wo] - uncovering usage problems in writing

[cp]: http://github.com/reedes/vim-colors-pencil
[lc]: http://github.com/reedes/vim-litecorrect
[lx]: http://github.com/reedes/vim-lexical
[pn]: http://github.com/reedes/vim-pencil
[qu]: http://github.com/reedes/vim-quotable
[re]: http://github.com/reedes
[th]: http://github.com/reedes/vim-thematic
[wh]: http://github.com/reedes/vim-wheel
[wo]: http://github.com/reedes/vim-wordy

## Future development

If you’ve spotted a problem or have an idea on improving this plugin,
please post it to the github project issue page.

<!-- vim: set tw=74 :-->
