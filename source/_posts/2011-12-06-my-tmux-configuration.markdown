---
layout: post
title: "My tmux configuration"
date: 2011-12-06 20:58
comments: true
categories: 
- Programming
- tmux
---

**Update:** I refined my configuration.  See it [here](/2014/03/20/my-tmux-configuration-refined/).

For the longest time, I was a [screen](http://www.gnu.org/s/screen/) user.  Then, a little while ago, I discovered [tmux](http://tmux.sourceforge.net/), the next generation terminal multiplexer.  Not only is it easier to search for on google, it has a rich and consistent configuration language.

I've figured out a rather unique tmux configuration and I wanted to share it.

# Background

Originally, I just used tmux on remote servers to control several windows.  This made it easy to create new remote windows, but I had to keep multiple Terminal tabs open, one for each remote server.  I had long wanted to be able to reconnect with my tabs, much in the same way that I could reconnect with the windows on an individual server.  I contemplated just running tmux locally on my mac, but then each new window would have required a new connection, and they wouldn't be logically grouped.

So I run tmux locally and remotely.

# Nested tmux

I manage my nested tmux sessions with three configuration files.

1. [.tmux.shared](https://github.com/justone/dotfiles-personal/blob/personal/.tmux.shared) - contains configuration and bindings that are shared between my master and remote sessions
2. [.tmux.master](https://github.com/justone/dotfiles-personal/blob/personal/.tmux.master) - contains configuration unique to my local (master) session
3. [.tmux.conf](https://github.com/justone/dotfiles-personal/blob/personal/.tmux.conf) - contains configuration unique to the remote sessions

## Shared configuration

Note: `bind -n` maps a key that works all the time, regular `bind` maps a key that has to be prefixed with the prefix key.

The shared configuration contains three basic sections:

1. [Vim-ish keybindings](https://github.com/justone/dotfiles-personal/blob/personal/.tmux.shared#L3) - I set them whenever I can get them.  (-:
2. [Misc. configuration](https://github.com/justone/dotfiles-personal/blob/personal/.tmux.shared#L16) - One screen-compatible binding and one I'll highlight later.
3. [Status bar configuration](https://github.com/justone/dotfiles-personal/blob/personal/.tmux.shared#L24) - This I mostly copied from someone else.

## Local configuration

The important setting here is updating the prefix to be `Ctrl-Alt-b`.  It took a few days to get used to hitting it, but my left ring finger now drops down to hit the alt key when I want to do local operations.

```
set-option -g prefix M-C-b
```

One convenience of using Terminal tabs is cruising between them with `Shift-Cmd-[` and `Shift-Cmd-]`.  To get a similar facility, I map `Ctrl-Alt-h` and `Ctrl-Alt-l` to previous and next:

```
# window navigation
bind-key -n M-C-h prev
bind-key -n M-C-l next
```

## Remote configuration

My remote configuration file doesn't make any modifications with regard to nesting tmux sessions.  It uses the default `Ctrl-b` prefix and is named `.tmux.conf` so that it is the default when tmux is started.

It doesn't specify next and previous window navigation like the master config because the corresponding choice for keys would be `Alt-h` and `Alt-l`, which confuses vim when I need to hit `Escape` followed by `h`, which happens rather frequently.  I fall back on the normal tmux navigation for next and previous window.

# Other nifty settings

## Resizing panes

I often split windows into multiple panes.  While tmux has some nice default layouts, it is sometimes easier to just move the divisions yourself.

Here's the configuration section for resizing from my remote configuration:

```
# keybindings to make resizing easier
bind -r C-h resize-pane -L
bind -r C-j resize-pane -D
bind -r C-k resize-pane -U
bind -r C-l resize-pane -R
```

Hitting the sequence `Ctrl-b` `Ctrl-h` will make the division between the current pane and the one below it move one line.  What makes it usable is the `-r` flag, which means I can just keep hitting `Ctrl-h` as many times as I want until the panes look right.

## Synchronizing input

Every so often, I want to send the same input to all panes in a particular window.  With this configuration, it's easy to toggle the built in synchronization:

```
# easily toggle synchronization (mnemonic: e is for echo)
bind e setw synchronize-panes on
bind E setw synchronize-panes off
```

# Conclusion

Using these settings makes it a cinch to reconnect to my entire work environment from anywhere.  I have two status bar lines at the bottom of my screen; the lower one is analogous to Terminal tabs and the upper one shows my remote windows.

Enjoy.
