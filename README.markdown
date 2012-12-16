# rsi.vim

You know Readline key bindings?  Of course you do, they're in your shell, your
REPL, and perhaps even the GUI for your OS.  They're similar to Emacs
key bindings (C-a for home), but with several concessions for UNIX (C-w for
delete word).

With rsi.vim, I've taken that same concession philosophy and extended it to
Vim. Get the most useful of the ubiquitous key bindings without blindly
overriding built-in Vim functionality.

## Features

* Readline mappings are provided in insert mode and command line mode.  Normal
  mode is deliberately omitted.
* Important Vim key bindings (like insert mode's C-n and C-p completion) are
  not overridden.
* Meta key bindings are provided in a way that works in the terminal without
  the perils of remapping escape.
* C-d, C-e, and C-f are mapped such that they perform the Readline behavior in
  the middle of the line and the Vim behavior at the end.  (Think about it.)

## Installation

If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/tpope/vim-rsi.git

Once help tags have been generated, you can view the manual with
`:help rsi`.

## Contributing

See the contribution guidelines for
[pathogen.vim](https://github.com/tpope/vim-pathogen#readme).

## Self-Promotion

Like rsi.vim? Follow the repository on
[GitHub](https://github.com/tpope/vim-rsi) and vote for it on
[vim.org](http://www.vim.org/scripts/script.php?script_id=4359).  And if
you're feeling especially charitable, follow [tpope](http://tpo.pe/) on
[Twitter](http://twitter.com/tpope) and
[GitHub](https://github.com/tpope).

## License

Copyright © Tim Pope.  Distributed under the same terms as Vim itself.
See `:help license`.
