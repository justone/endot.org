---
author: nate
date: '2011-10-05 14:26:42'
layout: post
slug: dfm-updates-uninstall-and-updatemergeandinstall
status: publish
title: 'dfm updates: uninstall and updatemergeandinstall'
wordpress_id: '298'
categories:
- Code
- dfm
---

In my <a href="/2011/09/23/dfm-presentation-at-la-pm/">dfm talk a couple weeks ago</a>, I listed out some <a href="http://speakerdeck.com/u/ndj/p/using-dfm?slide=35">low hanging fruit</a>; just a few things that I thought would be easy to add to the system.  Well, this past weekend, I went to the jQuery conference in Boston.  It was a great conference in its own right, and I hope to post on it this week, but for now I want to talk about the improvements I made to <a href="/projects/dfm/">dfm</a> while on the plane.

<strong>dfm uninstall</strong>

The first thing I tackled was the ability to remove dotfiles if they weren't needed anymore.  Sometimes, you need to log into a shared account (such as root) and you'd like to use your settings, but not leave them behind for the next person.  Now, 'dfm uninstall' does just that.

<strong>dfm updatemergeandinstall</strong>

Up until now, fetching your latest dotfiles changes required two steps: 'dfm updates' and 'dfm mergeandinstall'.  Well, now there's updatemergeandinstall that does both.  It takes the same flags as either updates or mergeandinstall and works just like it sounds.  Oh, and for the perennially lazy (i.e., me), it has a shortcut named 'umi'.

<strong>The Rest</strong>

The test suite covers all the new commands and I added more coverage for the lightly tested mergeandinstall code.  'dfm install' now cleans up dangling symlinks, for those times when a file is no longer needed.  And, finally, I refactored the code somewhat to make it easier to work on and to reduce duplication.

To update to the latest, just run these commands:

``` plain
$ dfm remote add upstream git://github.com/justone/dotfiles.git
$ dfm pull upstream master
```

Enjoy.
