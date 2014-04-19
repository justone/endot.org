---
layout: post
title: "Extending svn, &agrave; la git"
date: 2012-08-30 12:29
comments: true
categories: 
- Code
- dotfiles
---

[Subversion](http://subversion.apache.org/) is a useful tool.  It does most of what I need it to do, but sometimes there are missing features.  Sometimes, it's something that git does natively.  Other times, it's a repeated command sequence.  It's easy to write small scripts to do these new things, but they never feel like they fit in with the rest of the commands.

I've always been fond of the way that git can be extended by simply creating a script with the right name; `git-foo [args]` becomes `git foo [args]`.  I wanted that same level of extensibility with subversion, so I decided to write a little wrapper called `svn`.  It's in my PATH ahead of /usr/bin, and it detects if the subcommand given exists as `svn-$subcommand` in my path somewhere.  If that's found, it is executed.  Otherwise the real svn binary is executed.

I originally wrote `svn` in perl, but the other day a [friend of mine](https://github.com/mrwacky42) [^1] rewrote it with shell, cutting it by more than half and making it easier to understand.  Here it is:

```
#!/usr/bin/env bash

## If there is a svn-${COMMAND}, try that.
## Otherwise, assume it is a svn builtin and use the real svn.

COMMAND=$1
shift

SUB_COMMAND=$(type -path svn-${COMMAND})
if [ -n "$SUB_COMMAND" -a -x "$SUB_COMMAND" -a "${COMMAND}" != "upgrade" ]; then
    exec $SUB_COMMAND "$@"
else
    command -p svn $COMMAND "$@"
fi
```

Once I had the wrapper, I started creating little extensions to subversion.  Here are the ones I've created.

## [svn url](https://github.com/justone/dotfiles-personal/blob/personal/bin/svn-url)

This prints out the URL of the current checkout.

I frequently need to have the same checkout on multiple machines.  So, grabbing the URL quickly is essential.  All this script does is get the the URL out of the `svn status` line, but it makes the following possible:

```
$ svn url | remotecopy
```

Which means no mouse is needed.

## [svn vd](https://github.com/justone/dotfiles-personal/blob/personal/bin/svn-vd)

This shows the uncommitted differences with [vimdiff](http://vimdoc.sourceforge.net/htmldoc/diff.html).

Since subversion doesn't have native support for using external diff tools, this script uses [vimdiff.pl](https://github.com/justone/dotfiles-personal/blob/personal/bin/vimdiff.pl) to add that in.

I used to have my subversion configuration set so that vimdiff was always used, but decided to add this script so that I could choose at the prompt which one I wanted (`svn di` for native, `svn vd` for vimdiff).

## [svn clean](https://github.com/justone/dotfiles-personal/blob/personal/bin/svn-clean)

This is the analog to [git-clean](http://www.kernel.org/pub/software/scm/git/docs/git-clean.html).  It removes any untracked or ignored files.

This is indispensible for projects that generate a lot of build artifacts or times when there are several untracked items to delete.  Running it without additional options will show what files would be removed, and adding the `-f` flag will do the deleting.

## [svn fm](https://github.com/justone/dotfiles-personal/blob/personal/bin/svn-fm) (fm = 'fix merge')

This makes it easy to fix merge conflicts by loading up the right files in vimdiff.

When a conflict exists during a merge, subversion dumps several files in the local directory to help you figure out how the conflict occurred.

```
nate@laptop:~/test1
$ svn st
 M      .
?       file.merge-left.r23262
?       file.merge-right.r23265
?       file.working
C       file
```

I can never remember which file is which, so running `svn fm conflictedfile` runs vimdiff like this:

{% img /uploads/2012/08/svn_fm_vimdiff.png 'svn fm conflictedfile' %}

On the left is the file before the merge and on the right is the new file being merged.  The middle has the merged file with conflict markers.

If all the conflicts are resolved, the conflict is marked as resolved.

## All done

That's it for now.  Enjoy.

**Update 2012-09-17:** Updated wording about `svn clean` behavior.  Default changed from deleting to showing what would be deleted and the option `-n` changed to `-f`.

[^1]: The above links to his github, but I like the picture on his [homepage](http://mrwacky.com/) better.
