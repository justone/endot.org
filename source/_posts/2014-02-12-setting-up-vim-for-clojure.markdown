---
layout: post
title: "Setting up Vim for Clojure"
date: 2014-02-12 20:19:15
comments: true
categories: 
- Programming
- Clojure
- Vim
---

I've been experimenting with [Clojure][1] lately.  A few of my coworkers had begun the discovery process as well, so I suggested that we have a weekly show-and-tell, because a little accountability and audience can turn wishes into action.

Naturally, I looked around for plug-ins that would be of use in my [editor of choice][2].  Here's what I have installed:

* [vim-clojure-static][3] - Syntax highlighting and indentation
* [vim-fireplace][4] - Slick repl integration and hot code reload
* [rainbow_parentheses.vim][5] - Pretty rainbow coloring for ease of matching parentheses
* [vim-sexp][6] - A whole host of ways to edit S-expressions, some of which I'm sure I'll understand more as I get further in
* [vim-sexp-mappings-for-regular-people][7] - Tim Pope's riff on the above, minus the meta key

These are all straightforward to install, as long as you already have a [Pathogen][8] or [Vundle][9] setup going.  If you don't, you really should, because nobody likes a messy Vim install.

All of these plug-ins automatically work when a Clojure file is opened, with the exception of rainbow parentheses.  To enable those, a little [.vimrc config][10] is necessary:

```
au BufEnter *.clj RainbowParenthesesActivate
au Syntax clojure RainbowParenthesesLoadRound
au Syntax clojure RainbowParenthesesLoadSquare
au Syntax clojure RainbowParenthesesLoadBraces
```

Now, once that's all set up, it's time to show a little bit of what this setup can do.  I have a little clojure test app over [here on github][11].  After cloning it (and assuming you've already installed [leiningen][12]):

1. Open up [dev.clj][13] and follow the instructions to set up the application in a running repl.
2. Then open [testclj/core.clj][14] and make any modification, such as changing "Hello" to "Hi".
3. Then after a quick `cpr` to reload the namespace in the repl, you can reload your web browser to see the updated code.

This setup makes for a quick dev/test cycle, which is quite useful for experimentation.  Of course, there are many more features of each of the above plugins.  I've barely scratched the surface and I'm already very impressed.

Enjoy.

[1]: http://clojure.org/
[2]: http://www.vim.org/
[3]: https://github.com/guns/vim-clojure-static
[4]: https://github.com/tpope/vim-fireplace
[5]: https://github.com/kien/rainbow_parentheses.vim
[6]: https://github.com/guns/vim-sexp
[7]: https://github.com/tpope/vim-sexp-mappings-for-regular-people
[8]: https://github.com/tpope/vim-pathogen
[9]: https://github.com/gmarik/Vundle.vim
[10]: https://github.com/justone/dotfiles-personal/blob/personal/.vimrc#L335-L339
[11]: https://github.com/justone/testclj
[12]: http://leiningen.org/
[13]: https://github.com/justone/testclj/blob/master/dev.clj
[14]: https://github.com/justone/testclj/blob/master/src/testclj/core.clj
