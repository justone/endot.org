---
layout: post
title: "remotecopy - copy from remote terminals into your local clipboard"
date: 2011-12-04 14:56
comments: true
categories: 
- Code
- Programming
- remotecopy
---

# Problem

I copy and paste all the time.  Most of the time, I copy short pieces of information that are too long to type (I'm lazy) but too short to setup anything more complex (wget, scp, etc.).  For a while, this was fine as most of my copy targets were either local to my system or in a terminal window on a remote server.  However, as I increased my use of splits in tmux and windows in vim, highlighting remote text with my mouse became horribly cumbersome.  I needed a way to copy remote text into my local clipboard.

# Partial solutions

Recent versions of Terminal let you select blocks of text when holding down the alt key, but when I copied and pasted, the resulting block of text had extra trailing whitespace.

Another solution I tried was [MouseTerm](https://bitheap.org/mouseterm/).  It's a SIMBL plugin that sends your mouse events straight through to the remote terminal apps.  So, I could "set mouse=a" and then select text in any vim window without overlapping other windows.  The only problem was that once the text was selected, I couldn't copy it back to my local computer.

Then, I found [remote-pbcopy](http://seancoates.com/blogs/remote-pbcopy).  It's a setup where pbcopy is running in a daemon mode on your local laptop and listening on a specific port.  That port is then forwarded to the remote machine with SSH.  Finally, a little alias facilitates piping output into that port.  The result: remote data ends up in your local clipboard.

This is exactly what I wanted.  However, I didn't like the caveat at the end: there is no security on the listening daemon.  This means that any if any malicious (or prank-minded) person can figure out what port you are using, they can smash your local copy buffer.

# Remotecopy

My solution to this problem, [remotecopy](https://github.com/justone/remotecopy), is an evolution on remote-pbcopy.  It uses a secret value, like a password, to authenticate copy requests.  To do this, it replaces the client and server with perl equivalents so that a little extra logic can be added.

Here's the sequence of events.

1. Start `remotecopyserver` on your local laptop.
2. SSH to a remote host with the following argument: `-R 12345:localhost:12345`
3. On the remote host, run `remotecopy 'test string'`
4. Hit cmd-v and enter
5. 'test string' is now in your clipboard.

Here's how it works.

When remotecopy is run, it makes a connection to localhost:12345 (and therefore the remotecopyserver, via SSH).  Then, a short handshake is done, followed by the transfer of the copy data.

Before I describe the client side of the interaction, here is how the server operates:

1. On startup, generate a secret string.  Listen for connections.
2. When a connection is made, the client will send it's secret.
3. If the secret matches the local secret, tell the client that it can send the copy data.  Read the data and push it into the local clipboard with pbcopy.
4. If the secret is invalid or missing, tell the client so and close the connection.  Push the secret string into the local clipboard with pbcopy.

It's important not to miss the last part of step 4.  This makes the secret available later.

Now, back to remotecopy.  When remotecopy runs, it doesn't know the secret from the server.  It does the following:

1. Connect to the server and send an empty secret. The server sends back a rejection.
2. Prompt the user for the secret value.  (Because the server copied it into the paste buffer, all you need to do is paste (cmd-v) and hit enter)
3. Reconnect to the server, sending the secret and then the copy data.

It's quite a long description, but the process is very quick.  If you already have the secret in your clipboard history, you can pass `-s <secret>` and remotecopy will only need to make one connection.

# Example runs

For each of these examples, after the secret is entered, the data is in the server's copy buffer.

## Copy a simple string.

``` sh
$ remotecopy foo
Input secret:
rc-b212f4522lle33a689edcca88d6845b8
```

## Copy output of another program.

``` sh
$ ls | remotecopy
Input secret:
rc-b212f4522lle33a689edcca88d6845b8
```

## Specify secret on command line

Note: no prompt is needed.

``` sh
$ ls | remotecopy -s rc-b212f4520c3e33a689edcca88d6845b8
```

# Using remotecopy with vim

Since I use vim as much as possible, remotecopy includes a [vim plugin](https://github.com/justone/remotecopy/tree/master/vim) that enables sending data from remote vim sessions.

To copy the entire file or visual selection, use `,y`.  To copy a particular buffer, use `,r`.  When the remotecopy is first attempted, there will be a prompt for the secret.  After that, the secret is cached so future copies are quick.

# Using remotecopy with dfm

If you're using [dfm](/2010/10/16/dfm-a-utility-to-manage-dotfiles/) to manage your dotfiles, just copy it into your bin directory.  Both remotecopy and remotecopyserver are self contained perl scripts that don't have external module dependencies.

You can also use git subtrees and symlink the vim plugin, like I do [here](https://github.com/justone/dotfiles/commit/a8fdd27) and [here](https://github.com/justone/dotfiles/commit/25bc70d).

# More information

Each script has full documentation.  Just run with the `--man` option to view it.

The code is available on [github](https://github.com/justone/remotecopy).

Enjoy.
