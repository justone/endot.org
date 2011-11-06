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

``` ruby
#!/usr/bin/env castanaut

plugin "safari"
plugin "mousepose"
plugin "ishowu"

launch "Mousepose"

launch "Safari", at(20, 40, 1024, 768)
url "http://gadgets.inventivelabs.com.au"

ishowu_set_region at(4, 24, 1056, 800)
ishowu_start_recording

while_saying "
  Tabulate is a bookmarklet developed by Inventive Labs.
  You use it to open links on a web page.
  It's meant for iPhones, but we'll demonstrate it in Safari 3.
" do
  move to(240, 72)
  tripleclick
  type "http://gadgets.inventivelabs.com.au/tabulate"
  hit Enter
  pause 2
end
```

So cool.
