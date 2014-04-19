---
layout: post
title: "Remotecopy, two years later"
date: 2013-06-09 14:36
comments: true
categories: 
- remotecopy
---

It's been over two years since I wrote remotecopy and I still use it every day.

The most recently added feature is the `-c` option, which will remove the trailing newline from the copied data if it only contains one line.  I found myself writing little scripts that would only output one line with the intent of using that output to build a command line on a different system, and the extra newline at the end often messed up the new command.  The `-c` solves this problem.

For instance, I have [git-url](https://github.com/justone/dotfiles-personal/blob/personal/bin/git-url), which outputs the origin url of the current git repository.  This makes it easy to clone the repo on a new system (`rc` is my alias for `remotecopy -c`):

``` sh
firsthost:gitrepo$ git url | rc
Input secret:
rc-alaelifj3lij2ijli3ajfwl3iajselfiae
```

Now the clone url is in my clipboard, so I just type `git clone ` and then paste to clone on a different system:

``` sh
secondhost:~$ git clone git@github.com:justone/gitrepo.git
Cloning into 'gitrepo'...
...
```

## No tmux pbcopy problems

Most OSX tmux users are familiar with the issues with pbcopy and [the](http://superuser.com/questions/231130/unable-to-use-pbcopy-while-in-tmux-session) [current](http://apple.stackexchange.com/questions/41412/using-tmux-and-pbpaste-pbcopy-and-launchctl) [workarounds](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard).

Since remotecopy works by accessing the server over a tcp socket, it's immune to these problems.  I just use remotecopy on my local system as if I were on a remote system.

## LA Perl Mongers

At the latest LA Perl Mongers meeting, the talks were lightning in nature, so I threw together a presentation about remotecopy.  The interesting source bits are up [on github](https://github.com/justone/remotecopy_present), including a [pdf copy of the slides](https://github.com/justone/remotecopy_present/blob/master/remotecopy.pdf?raw=true).

For the presentation, I used the excellent [js-sequence-diagrams](http://bramp.github.io/js-sequence-diagrams/) to make this diagram, that hopefully helps show the data flow in a remotecopy interaction.

![git annex map](/uploads/2013/06/remotecopy.svg)

Enjoy.
