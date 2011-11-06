---
author: nate
date: '2009-08-28 18:23:03'
layout: post
slug: fixing-r-apps-tendency-to-forget-history
status: publish
title: Fixing R.app's tendency to forget history
wordpress_id: '104'
categories:
- Programming
---

Being the data and visualization nerd that I am, I've been delving into <a href="http://www.r-project.org/">R</a> on occasion.  For this purpose, I am using R.app on my Mac.  To start it up for a certain working directory (to keep different projects separate), I run "open -a R &lt;working dir&gt;".  This worked great until I noticed that my history wasn't getting saved to the .Rhistory file in each directory.  When I use the command line R executable it does, but not in the R.app GUI.

So, it took me a little while to figure out that it's a bug in the R.app code and you have to use a workaround.  Open R.app's preferences and set the "R history file" key to something other than ".Rhistory":

<img class="alignnone size-full wp-image-105" title="rhistory" src="http://endot.org/wp-content/uploads/2009/08/rhistory.png" alt="rhistory" width="519" height="143" />

Now, after a restart, the .nateRhistory file in the working directory is properly updated.