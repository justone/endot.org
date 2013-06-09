---
layout: post
title: "A script to ease SCP use"
date: 2013-06-08 21:44
comments: true
categories: 
- Programming
- remotecopy
---

Since I work on remote systems all the time, I use SCP repeatedly to transfer files around.  One of the more cumbersome tasks is specifying the remote file or directory location.

So I wrote a helper script to make it easier.  It's called [scptarget](https://github.com/justone/dotfiles/blob/personal/bin/scptarget), and it generates targets for SCP, either the source or the destination.

For instance, if I want to copy a file down from a remote server, I run scptarget like this and copy the output:

``` sh
$ scptarget file.pl
endot.org:/home/nate/file.pl
```

Then it's easy to paste it into my SCP command on my local system:

``` sh
$ scp endot.org:/home/nate/file.pl .
...
```

I usually use [remotecopy](/2011/12/04/remotecopy-copy-from-remote-terminals-into-your-local-clipboard/) (specifically `remotecopy -c`) to copy it so that I don't even have to touch my mouse.

## Examples

Here are a few example uses.

First, without any arguments, it targets the current working directory.  This is useful when I want to upload something from my local system to where I'm remotely editing files.

``` sh
$ scptarget
endot.org:/home/nate
```

Specifying a file targets the file directly.

``` sh
$ scptarget path/to/file.pl
endot.org:/home/nate/path/to/file.pl
```

Absolute paths are handled correctly:

``` sh
$ scptarget /usr/local/bin/file
endot.org:/usr/local/bin/file
```

## Vim SCP targets

[Vim](http://www.vim.org/) supports editing files over SCP, so passing `-v` in generates a target that it can use:

``` sh
$ scptarget -v path/to/file.pl
scp://endot.org//home/nate/file.pl
```

And to edit, just pass that in to Vim:

``` sh
$ vim scp://endot.org//home/nate/file.pl
```

## IP based targets

Sometimes I need the target to use the IP of the server instead of its hostname.  This usually happens with development VMs (a la Vagrant), which are only addressable via IP.  Passing `-i` to scptarget causes it behave this way.  Under the hood, it uses [getip](https://github.com/justone/dotfiles/blob/personal/bin/getip), which is a script I wrote that prints out the first IP of the current host.  If there is no non-private IP, then it will return the first private IP.  (I am fully aware that there may be better ways of doing the above.  Let me know if you have a better script.)

``` sh
$ scptarget path/to/file.pl
64.13.192.60:/home/nate/path/to/file.pl
```

That's it.  I find it incredibly useful and I hope you do too.

Enjoy.
