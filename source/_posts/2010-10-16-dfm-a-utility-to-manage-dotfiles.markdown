---
author: nate
date: '2010-10-16 20:50:34'
layout: post
slug: dfm-a-utility-to-manage-dotfiles
status: publish
title: dfm - a utility to manage dotfiles
wordpress_id: '202'
categories:
- Code
- Computers
- Programming
- dfm
---

I have quite a few dotfiles.  I have so many that keeping them in sync is impossible with conventional methods.  So, I turned to my old friend: version control.  For a while, I kept them in subversion at work.  This worked well as that was where I spent most of my time.  Recently, however, I've wanted those same dotfiles to be available at home and other non-work areas.  So, I investigated moving them over to a git repository.  Not only is git easier to set one up, but keeping multiple long running branches doesn't make you want to shoot something.

So, I investigated how other people are doing the same thing.  There are no shortage of <a href="http://www.google.com/search?q=site:github.com%20dotfiles">dotfiles repos on github</a>, so I checked out a dozen or so.  I also found <a href="http://swik.net/dotfiles+git">this area on swik</a> that linked to several pertinent blog posts about this very topic.

I decided to go with the symlink strategy to avoid the "git clean" bug [^1], but most of the dotfiles repositories used either a makefile, a shell script or a rakefile to do the actual symlinking.  I wanted to make something more flexible, and that didn't require me to use degenerate languages (make or shell) or something that wasn't installed by default (ruby).  Since perl is baked into most distributions, it seemed a good fit.

The end result of this effort is <strong><a href="http://github.com/justone/dotfiles/blob/master/bin/dfm">dfm</a></strong>, the dotfiles manager.  This script handles the basic 'install' case while adding a few more features (like skipping files and recursing into subdirectories).  It also has subcommands that make it easy to fetch updates and merge/install them.  And finally, it has a passthrough that allows you to run any git command on the local repo without having to cd into it.

I've been using this system full time for about the last two months and it's really been handy.  I have two branches.  One is a personal branch that I use on all of my non-work systems and a work branch that is based on the personal branch with the added utilities and configuration for work.  This means I can share my <a href="http://github.com/justone/dotfiles/tree/personal">personal dotfiles</a> and still keep work stuff private.

In all of this, I also wanted to make something that was generally useful, so that other people could get up and running quickly with something similar.  To this end, I've kept my <a href="http://github.com/justone/dotfiles">master</a> branch distilled down to the bare minimum to get up and running with dfm.  Using dfm is just a matter of forking my repo and adding what you use.  I also put a bunch of information about dfm and my dotfiles repository on the <a href="http://github.com/justone/dotfiles/wiki">associated wiki</a> on github.

I have quite a few ideas on where to go with this from here, but the basic functionality is there so I wanted to officially release it into the wild.  Let me know if you find it useful or have something to contribute.

Have fun.

[^1]: If you run "git clean", it will keep going up the directory tree until it finds a git repo.  If your home directory itself is the working copy, and you accidentally run "git clean", it will nuke anything that isn't tracked.  Putting the dotfiles working copy in a subdirectory and symlinking avoids this.
