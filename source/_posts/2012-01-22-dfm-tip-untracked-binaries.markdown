---
layout: post
title: "dfm tip: untracked binaries"
date: 2012-01-22 15:38
comments: true
categories: 
- dfm
---

## The problem

From time to time, I have scripts and binaries that I only really need on one system.  Since the base dotfiles repo includes a bin directory (for `dfm` itself), if I just drop files in there, git continually shows me that they are untracked.  For instance, if I have a script called `only_on_my_mac`, then running `dfm status` shows:

```
# On branch personal
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       bin/only_on_my_mac
nothing added to commit but untracked files present (use "git add" to track)
```

At the very least, this is annoying.  Here, I offer three solutions to this problem.

## Solution 1: .gitignore

The first solution is to just drop a .gitignore file in the bin directory and specify each file that needs to be ignored:

``` plain $HOME/.dotfiles/bin/.gitignore
only_on_my_mac
```

If you only have a couple scripts, this may work.  However, after the third entry, this gets rather tedious.

## Solution 2: Create an excluded directory

This solution is a slight modification of the previous one.  Instead of ignoring each individual file, create a directory for excluded scripts:

``` plain
mkdir .dotfiles/bin/excluded
```

Then, ignore all the files inside that directory (except the .gitignore file itself):

``` plain $HOME/.dotfiles/bin/excluded/.gitignore
*
!.gitignore
```

Finally, update `.bashrc.load` to add the new directory to the path:

``` plain $HOME/.dotfiles/.bashrc.load
PATH=$HOME/bin/excluded:$PATH
```

Now, any scripts that are only for one system can just be dropped into the bin/excluded directory and git/dfm won't try to track them.

## Solution 3: Use dfm recursion

This solution involves modifying the `.dfminstall` file in the base of the dotfiles repository.  Add the following line:

``` plain $HOME/.dotfiles/.dfminstall
bin recurse
```

Then, when `dfm` installs, it will symlink any scripts in the dotfiles' bin directory instead of symlinking the entire directory.

``` plain without recursion
$ ls -al bin
lrwxr-xr-x  1 jones  staff  13 Oct  4 20:20 bin -> .dotfiles/bin
```

``` plain with recursion
$ ls -al bin
drwxr-xr-x 3 vagrant vagrant 4096 2012-01-23 01:31 .
drwxr-xr-x 5 vagrant vagrant 4096 2012-01-23 01:31 ..
-rw-r--r-- 1 vagrant vagrant   12 2012-01-23 01:31 only_on_my_mac
drwxr-xr-x 2 vagrant vagrant 4096 2012-01-23 01:31 .backup
lrwxrwxrwx 1 vagrant vagrant   20 2012-01-23 01:31 dfm -> ../.dotfiles/bin/dfm
```

This solution only started working today.  There was an bug in dfm that prevented the bin directory itself from being recurse-able.  If you want to use this solution, you'll need to merge the [latest code](https://github.com/justone/dotfiles).

## Conclusion

I personally use Solution #2, mostly because I don't want to keep a list of files to ignore (translation: lazy).

I hope these solutions are helpful.  Enjoy.
