---
author: nate
date: '2011-05-20 11:14:02'
layout: post
slug: quite-possibly-the-most-useful-vim-shortcut-i-have
status: publish
title: Quite possibly the most useful vim shortcut I have
wordpress_id: '249'
categories:
- Misc
---

I use these every single day:

[sourcecode gutter="false" language="plain"]noremap &lt;leader&gt;ew :e &lt;C-R&gt;=expand(&quot;%:p:h&quot;) . &quot;/&quot; &lt;CR&gt;
noremap &lt;leader&gt;es :sp &lt;C-R&gt;=expand(&quot;%:p:h&quot;) . &quot;/&quot; &lt;CR&gt;
noremap &lt;leader&gt;ev :vsp &lt;C-R&gt;=expand(&quot;%:p:h&quot;) . &quot;/&quot; &lt;CR&gt;
noremap &lt;leader&gt;et :tabe &lt;C-R&gt;=expand(&quot;%:p:h&quot;) . &quot;/&quot; &lt;CR&gt;[/sourcecode]

These make it much easier to open files next to the file in the current buffer.  For instance, if I run the command "vi /etc/puppet/manifests/modules/foo/bar.pp" and I need to edit a file in the same directory as bar.pp, I just type <strong>,ew</strong> and at the bottom of my vim window this appears:

[sourcecode gutter="false" language="plain"]:e /etc/puppet/manifests/modules/foo/[/sourcecode]

With the cursor at the end, waiting for me to type the filename or just hit enter so I can use NERDTree to select a file visually.  The other mappings open splits or tabs, allowing me to easily select where new file shows up.

This morning, I discovered an interesting side effect to this command.  I ran "vi http://mbostock.github.com/d3/ex/unemployment.json" to see what the json data for <a href="http://mbostock.github.com/d3/ex/choropleth.html">this cloropleth</a> was.  Then, to see what the us-counties.json file had in it, I just hit <strong>,ew</strong> and the following showed up at the bottom of my vim window:

[sourcecode gutter="false" language="plain"]:e http://mbostock.github.com/d3/ex/[/sourcecode]

Awesome.

One more thing.  These mappings are directly from <a href="http://vimcasts.org/episodes/the-edit-command/">this vimcasts episode</a>.  If you haven't watched all the vimcasts episodes, then you're missing out on some great content.