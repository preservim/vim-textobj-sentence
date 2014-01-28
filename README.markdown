# vim-textobj-sentence

> Improving on Vim's native sentence motion command

Detecting sentences can be tricky, esp. when the words and punctuation of
the sentence are interspersed with abbreviations, “quotations,”
(parentheses), [brackets], hard line breaks and the markup from
lightweight markup languages.

While Vim’s native sentence motion command is quite capable, its reach is
limited and its behavior hard-coded. Thus arises the need for
a specialized text object as you will find in this plugin.

Features of this plugin:

* Sophisticated sentence text object, supporting selection, motion, etc.
* Implemented with regular expressions
* Avoids false sentence termination where common abbreviations are present
* Support for “typographical quotes”
* (SOON) Support for lightweight markup languages (markdown, e.g.)
* Buffer scoped configuration

## Requirements

May require a recent version of Vim.

## Installation

Install using Pathogen, Vundle, Neobundle, or your favorite Vim package
manager.

This plugin has an important (and useful) dependency that you will need to
install.

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

Not all period `.` characters will terminate a sentence. This plugin detects 
decimal numbers and common abbreviations. By default, the following 
abbreviations are recognized:

```
let g:textobj#sentence#abbreviations = [
  \ 'Mr', 'Mr?s', 'Drs?', '[JS]r',
  \ 'Ph', 'Univ', 'Prof',
  \ 'A', 'B', 'C', 'D', 'M',
  \ '[Vv]s', '[Ee]tc', 'no', 'esp',
  \ '[FM]t', '[Aa]pt',
  \ '[Aa]ve?', '[Bb]lvd', '[Cc][lt]', '[Ll][an]', '[Rr]d', '[Ss]tr?',
  \ ]
```

For example, the following sentence will be recognized as a single text
object.

```
The lair of Dr. Evil, M.D., can be found at 100 Main St. in Ft. Collins.
```

Note that you can override or add to the above defaults in your `.vimrc`.

### Motion commands

Motion commands are a powerful feature of Vim.

This plugin overrides the following motions commands:

* `)` - move to start of next sentence
* `(` - move to start of previous sentence

It adds:

* `g)` - move to end of next sentence
* `g(` - move to end of previous sentence

You can combine the overridden `s` command with `c` for change, `v` for
visual selection, `d` for deletion, `y` for yanking to clipboard, etc..
For example:

* `vis` - select ‘inside’ sentence at current cursor position
* `vas` - select ‘around’ sentence at current cursor position, with trailing whitespace

If you prefer to retain the native Vim command characters, assign other
characters via your `.vimrc`:

  ```vim
  let g:textobj#sentence#select = 's'
  let g:textobj#sentence#move_p = '('
  let g:textobj#sentence#move_n = ')'
  ```

## See also

Many more abbreviations are available that you can add:

* Perl’s [Lingua::EN::Sentence][ab]
* Oxford English Dictionary’s [Abbreviations][oe]

[ab]: http://cpansearch.perl.org/src/SHLOMOY/Lingua-EN-Sentence-0.25/lib/Lingua/EN/Sentence.pm
[oe]: http://public.oed.com/how-to-use-the-oed/abbreviations/

If you find this plugin useful, you may want to check out these others by
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

## To be implemented soon

* Bracket support
* Parentheses support
* Lightweight markup language support

## Future development

If you’ve spotted a problem or have an idea on improving this plugin,
please post it to the github project issue page.

<!-- vim: set tw=74 :-->
