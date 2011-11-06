---
author: nate
date: '2008-04-21 19:43:28'
layout: post
slug: nothing-is-safe-from-the-almighty-domain-specific-language
status: publish
title: Nothing is safe from the almighty Domain Specific Language
wordpress_id: '37'
categories:
- Programming
---

What <a href="http://rubyonrails.com/">Ruby on Rails</a> is to web programming,

and <a href="http://www.capify.org/">Capistrano</a> is to deployment,

now <a href="http://gadgets.inventivelabs.com.au/castanaut">Castanaut</a> is to screencasts:
[ruby]#!/usr/bin/env castanaut

plugin &quot;safari&quot;
plugin &quot;mousepose&quot;
plugin &quot;ishowu&quot;

launch &quot;Mousepose&quot;

launch &quot;Safari&quot;, at(20, 40, 1024, 768)
url &quot;http://gadgets.inventivelabs.com.au&quot;

ishowu_set_region at(4, 24, 1056, 800)
ishowu_start_recording

while_saying &quot;
  Tabulate is a bookmarklet developed by Inventive Labs.
  You use it to open links on a web page.
  It's meant for iPhones, but we'll demonstrate it in Safari 3.
&quot; do
  move to(240, 72)
  tripleclick
  type &quot;http://gadgets.inventivelabs.com.au/tabulate&quot;
  hit Enter
  pause 2
end[/ruby]
So cool.