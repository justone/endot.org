---
layout: post
title: "Developing Clojure in Vim (2018 edition)"
date: 2018-07-14 11:46:19 -0700
comments: true
categories:
- Programming
- Clojure
- Vim
---

When I wrote about developing Clojure in Vim for the [first time][1], I was still early in my journey.  For years, I'd only been able to tinker with Clojure in my free time and I was never able to really use it for anything large.  Well, now I'm 5 or so months into using it full time and I'm really enjoying the development experience.  So I thought I'd update my previous post with what my Vim configuration looks like now.

First of all, I should point out that while I've switched over to using Neovim, all of my set up works with both it and Vim 8.x.  Neovim has some cool advantages (like [inccommand][2]), but they're orthogonal to my Clojure dev workflow.

## Plugins

Here are the plugins I use that are Clojure related:

* [vim-clojure-static][3] - This is still the way to go for base syntax highlighting and indentation.
* [vim-fireplace][4] - Still the way to go for repl integration and code reloading.
* [rainbow][5] - I previously used [rainbow_parentheses.vim][6], but found that this one is simpler and more stable.
* [vim-sexp][7] - This plugin lets me manipulate code as a tree, and it's wonderful
* [vim-sexp-mappings-for-regular-people][8] - Tim Pope's riff on the above, minus the meta key
* [cljfold][9] - I'm a compulsive code-folder, so after a few weeks I went to find a good folding plugin for Clojure and this is what I settled on.  It's old, but it still works, which is a testament to the stability of the language.

## Configuration

Most of the above plugins "just work" when you install them (hopefully via [Pathogen][10] or one of its newer workalikes). There are a few bits in my vimrc that tweak settings.

First is rainbow.  I turn with a few rotating colors, and only for Clojure files:

```
" clojure rainbow parens
let g:rainbow_active = 1
let g:rainbow_conf = {
      \  'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
      \  'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
      \  'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
      \  'separately': {
      \      '*': 0,
      \      'clojure': {},
      \  }
      \}
```

Next is cljfold.  I like to fold more than the default:

```
" configure clojure folding
let g:clojure_foldwords = "def,defn,defmacro,defmethod,defschema,defprotocol,defrecord"
```

The final tweak is to add a couple of mappings for fireplace.  The first is so that I can quickly evaluate a top level form (usually `#_(...)` when developing) without having to move my cursor.  The second is for pulling up the result of the last evaluation in a vim buffer, which is super useful for referencing and copy/paste, especially now that evaluation output is now pretty printed by default.

```
" a few extra mappings for fireplace
" evaluate top level form
au BufEnter *.clj nnoremap <buffer> cpt :Eval<CR>
" show last evaluation in temp file
au BufEnter *.clj nnoremap <buffer> cpl :Last<CR>
```

## Development workflow

These plugins have enabled me to settle into a very productive workflow, being able to leverage the power of Clojure's dynamism while editing it all with Vim.  I'll outline the flow in a future post.

Enjoy.

[1]: /2014/02/12/setting-up-vim-for-clojure/
[2]: http://vimcasts.org/episodes/neovim-eyecandy/
[3]: https://github.com/guns/vim-clojure-static
[4]: https://github.com/tpope/vim-fireplace
[5]: https://github.com/luochen1990/rainbow
[6]: https://github.com/kien/rainbow_parentheses.vim
[7]: https://github.com/guns/vim-sexp
[8]: https://github.com/tpope/vim-sexp-mappings-for-regular-people
[9]: https://github.com/gberenfield/cljfold.vim
[10]: https://github.com/tpope/vim-pathogen
