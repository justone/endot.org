---
layout: post
title: "My tmux configuration, refined"
date: 2014-03-20 07:37:19
comments: true
categories: 
- Programming
- tmux
---

When I wrote about tmux for the [first time](/2011/12/06/my-tmux-configuration/), I was just getting into the idea of nesting sessions.  I ran a local tmux session that wrapped remote tmux sessions for more than a year before I switched it up again.

I added another level.

## Background

I originally started nesting tmux sessions so that I wouldn't have to use tabs in Terminal to keep track of different remote tmux sessions.  This allowed me to connect to my work machine from home and get my entire working session instantly.  While that worked well, I began to see a few issues with that approach:

1. At work, I ran my top level tmux session on my work laptop.  The downside of this is that I had to leave my laptop open and running all the time to be able to access it remotely.  This also necessitated some tricky SSH tunnels that I wasn't entirely comfortable leaving open.
2. The top level tmux session at home was on my home server, and so it was convenient to connect to from work, but if I connected to that session from my top level work session, the key bindings would end up conflicting.

## Solution

I solved the first issue by running my top level work session on a server at work.  This allowed me to close my laptop when I wasn't in the office and it afforded me a location to run things that weren't specific to a particular system but that I didn't want to live and die with my laptop.

I solved the second issue by adding a new level of tmux.  I called this new level `uber` and assigned it the prefix `C-q` to differentiate it from the other levels[^1],

With that in place, I would start the uber session on my laptop and then connect to both my home and work mid-level sessions, and via those, the leaf tmux sessions.  Then, I could choose what level I wanted to operate on just by changing the prefix that I used.

## Multiple sockets

Another thing that I wanted to do from time to time was run two independent tmux sessions on my local laptop.  I could have used the built-in multi-session support in tmux, but I also wanted the ability to nest sessions locally, and tmux doesn't support that natively.  In looking for a solution, I stumbled on the idea of running each level on it's own server socket.  By adding that, I can now run all three on the same system and running two independent tmux sessions is as easy as running two different levels in separate windows.  Plus, I can still use the native multi-session support within each level.

## Sharing sessions

The most recent modification I made was to add easy support for sharing a tmux session between two Terminal windows.  This allows me to treat my local Terminal windows as viewports into my tmux session tree, attaching where ever I need without necessarily detaching another Terminal window.

To enable this, I added an optional command line flag to the session start scripts that makes tmux start a new view of the session instead of detaching other clients.  I also enabled '[aggressive-resize](https://github.com/justone/dotfiles-personal/blob/personal/.tmux.shared#L17)' so that the size of the tmux sessions aren't limited to the smallest Terminal window unless more than one are looking at the exact same tmux window.

## How it all looks

![tmux sessions](/uploads/2014/03/tmux_sessions.png)

It can look a little overwhelming, but in reality it's quite simple to use.  Most of my time is spent in the leaf node sessions, and that interaction is basically vanilla tmux.

## Installing this for yourself

### Configuration

The configuration for my set up is available in my dotfiles repository on Github:

1. [.tmux.shared](https://github.com/justone/dotfiles-personal/blob/personal/.tmux.shared) - contains shared configuration and bindings that are common to all levels
2. [.tmux.uber](https://github.com/justone/dotfiles-personal/blob/personal/.tmux.uber) - configuration unique to the top-level session
4. [.tmux.master](https://github.com/justone/dotfiles-personal/blob/personal/.tmux.master) - configuration unique to mid-level tmux sessions
3. [.tmux.conf](https://github.com/justone/dotfiles-personal/blob/personal/.tmux.conf) - configuration unique to the lowest-level (leaf) sessions

### Wrapper scripts

The heart of the wrapper scripts is [tmux-sess](https://github.com/justone/dotfiles-personal/blob/personal/bin/tmux-sess).  It holds all the logic for setting the socket and sharing sessions.

The rest of the scripts are thin wrappers around tmux-sess.  For instance, here is [tmux-uber](https://github.com/justone/dotfiles-personal/blob/personal/bin/tmux-uber):

``` sh
#!/bin/sh

tmux-sess -s uber -f ~/.tmux.uber $*
```

The other level scripts are [tmux-home](https://github.com/justone/dotfiles-personal/blob/personal/bin/tmux-home) for the mid-level session and [tmux-main](https://github.com/justone/dotfiles-personal/blob/personal/bin/tmux-main) for the lowest-level.

## Wrapping up

I hope that this information is helpful.  If you have any questions, please ask me [on twitter](https://twitter.com/ndj).

Enjoy.

[^1]: I also quickly decided that this uber level didn't need to have its own status line. That would be crazy.
