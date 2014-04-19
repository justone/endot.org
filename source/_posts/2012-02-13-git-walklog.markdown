---
layout: post
title: "git-walklog"
date: 2012-02-13 12:22
comments: true
categories: 
- Code
- git
---

Most of the time, when looking at history in a git repository, I am most interested in changes at a higher level than an individual commit.  From time to time, however, I really want to look at each commit on its own.  So, I created [git-walklog](https://github.com/justone/dotfiles-personal/blob/personal/bin/git-walklog).  For each commit in the range specified, it:

1. Shows the standard log format: author, date, and commit message.  Then it waits for input.
2. Hitting enter then runs `git difftool` on just that commit, showing you any differences in your configured difftool [^1].

If you want to skip a commit, all you need to do is type 'n' or 'no'.

I usually use `git log` with different options till I get it to just show the entries I'm interested in and then replace `log` with `walklog` to cruise through the commits.

## Examples ##

To see the last three commits:

``` plain
git walklog -3 --reverse
```

To see the changes for a particular branch:

``` plain
git walklog master..branch --reverse
```

To see what came in the last git pull:

``` plain
git walklog master@{1}.. --reverse
```

I usually put `--reverse` in there, because I want to see the commits in the same order as they were created.

Enjoy.

[^1]: You do have a difftool configured, don't you?  Run `git config --global diff.tool vimdiff` and then use `git difftool` instead of `git diff` and all your diffs will show up in vimdiff.  Works for other diffing tools too, look for "Valid merge tools" in [man difftool](http://schacon.github.com/git/git-difftool.html).
