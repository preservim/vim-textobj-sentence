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
* Implemented with regular expressions via the amazing vim-textobj-user plugin
* Avoids the premature end-of-sentence where common abbreviations are present
* Support for “typographical quotes”
* Support for lightweight markup languages (markdown, e.g.)
* Buffer scoped configuration

## Requirements

May require a recent version of Vim.

## Installation

Install using Pathogen, Vundle, Neobundle, or your favorite Vim package
manager.

This plugin has an important dependency that you will need to install:

* [kana/vim-textobject-user](https://github.com/kana/vim-textobj-user) - a Vim plugin to create your own text objects without pain

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

Though the period `.` glyph will terminate a sentence, it doesn’t
terminate all sentences. For example, the same glyph is used in
abbreviations like “M.D.” for Medical Doctor.

But those abbreviations should be allowed for when detecting the
boundaries of a sentence. The following should be considered a single text
object, rather than six:

```
The lair of Dr. Evil, M.D., can be found at 100 Evil St. in Ft.
Lauderdale.
```

This plugin detects decimal numbers and common abbreviations. By default,
the following abbreviations will be recognized:

```
let g:textobj#sentence#abbreviations = [
  \ 'Mr', 'Mr?s', 'Drs?', '[JS]r',
  \ 'Ph', 'Univ', 'Prof',
  \ '[A-Z]',
  \ '[Vv]s', '[Ee]tc', 'no', 'esp',
  \ '[FM]t', '[Aa]pt',
  \ '[Aa]ve?', '[Bb]lvd', '[Cc][lt]', '[Ll][an]', '[Rr]d', '[Ss]tr?',
  \ ]
```

Note that you can override the above defaults in your `.vimrc`, but be
sure to include the declaration before you call `textobj#sentence#init()`.

### Motion commands

Motion commands are a powerful feature of Vim.

This plugin overrides Vim’s own commands for sentence selection:

* `as` - select ‘around’ sentence with trailing whitespace
* `is` - select ‘inside’ sentence without trailing whitespace

* `)` - move to start of next sentence
* `(` - move to start of previous sentence

This plugin adds:

* `g)` - move to end of next sentence
* `g(` - move to end of previous sentence

You can manipulation text just as with Vim’s original `as` and `is`
commands, such as `cis` for change, `vas` for visual selection, `das` for
deletion, `yas` for yanking to clipboard, etc..

If you prefer to retain the native commands, you can assign other
characters via your `.vimrc`:

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
* [vim-wordy][wo] - uncovering usage problems in writing

[cp]: http://github.com/reedes/vim-colors-pencil
[lc]: http://github.com/reedes/vim-litecorrect
[lx]: http://github.com/reedes/vim-lexical
[pn]: http://github.com/reedes/vim-pencil
[qu]: http://github.com/reedes/vim-quotable
[re]: http://github.com/reedes
[th]: http://github.com/reedes/vim-thematic
[wo]: http://github.com/reedes/vim-wordy

## Future development

If you’ve spotted a problem or have an idea on improving this plugin,
please post it to the github project issue page.

<!-- vim: set tw=74 :-->
