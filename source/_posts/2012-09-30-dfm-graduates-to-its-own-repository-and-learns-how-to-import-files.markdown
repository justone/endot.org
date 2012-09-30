---
layout: post
title: "dfm graduates to its own repository and learns how to import files"
date: 2012-09-30 14:43
comments: true
categories: 
- dfm
- Code
---

I recently split dfm out into its own [git repository](https://github.com/justone/dfm).  This should make it easier to add new features and grow the test suite without cluttering up the original [dotfiles repository](https://github.com/justone/dotfiles).  I'll sync dfm over at regular intervals, so anyone who wants to keep up to date by merging with master will be ok.

I also just finished up a major new feature: dfm can now import files.  So instead of:

```sh
$ cp .vimrc .dotfiles
$ dfm install
$ dfm add .vimrc
$ dfm ci -m 'adding .vimrc'
```

There is an `import` subcommand that accomplishes all of this:

```sh
$ dfm import .vimrc
INFO: Importing .vimrc from /home/user into /home/user/.dotfiles
INFO:   Symlinking .vimrc (.dotfiles/.vimrc).
INFO: Committing with message 'importing .vimrc'
[personal 8dbf30d] importing .vimrc
 1 file changed, 46 insertions(+)
 create mode 100644 .vimrc
```

There are a smattering of other new features as well, like having dfm execute a script or fixup permissions on install.  These are listed in the [changelog for v0.6](https://github.com/justone/dfm/blob/master/CHANGELOG.md#v06-2012-09-30) and documented in the [wiki](https://github.com/justone/dotfiles/wiki/Full-Documentation).

To update to the latest, just run these commands:

``` plain
$ dfm remote add upstream git://github.com/justone/dotfiles.git
$ dfm pull upstream master
```

Or, grab dfm from [its repository](https://raw.github.com/justone/dfm/master/dfm).

Enjoy.
