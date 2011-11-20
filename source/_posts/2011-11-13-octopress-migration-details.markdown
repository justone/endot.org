---
layout: post
title: "Octopress migration details"
date: 2011-11-13 20:16
status: publish
comments: true
categories: 
---

As is customary for those who've converted from WordPress to Octopress, here's a quick post about my experience converting this blog.

Getting the blog up and running was a cinch, especially with a [good example](https://github.com/jbarratt/serialized.net-octopress) to examine when I had questions.

## Converting old entries

To convert my WordPress entries, I turned to [exitwp](https://github.com/thomasf/exitwp).  It worked pretty well, but I ran into two issues.

The first was that the YAML blob at the top of the converted posts wasn't formatted correctly.

``` yaml
---
author: nate
date: '2011-10-29 18:53:01'
layout: post
slug: git-submodules-vs-subtrees-for-vim-plugins-part-2
status: publish
title: Git submodules vs. subtrees for vim plugins, part 2
wordpress_id: '328'
? ''
: - Misc
---

```

I solved this by switching to [chitsaou's fork](https://github.com/chitsaou/exitwp).

The second problem was that html2text, which exitwp uses to do the actual conversion, was hard wrapping lines at 78 characters.  I fiddled with it for quite a while, hacking the backend code for html2text, but then I remembered that markdown parsers pass HTML straight through (and that I don't care if old entries are regular HTML).  So I just modified the exitwp script to gut the html2fmt method:

``` diff
$ git di
diff --git a/exitwp.py b/exitwp.py
index ae58d24..d21a8df 100755
--- a/exitwp.py
+++ b/exitwp.py
@@ -37,12 +37,7 @@ item_field_filter = config['item_field_filter']
 date_fmt=config['date_format']
 
 def html2fmt(html, target_format):
-    html = html.replace("\n\n", '<br>')
-    if target_format=='html':
-        return html
-    else:
-        # This is like very stupid but I was having troubles with unicode encodings and process.POpen
-        return html2text(html, '')
+    return html
 
 def parse_wp_xml(file):
     ns = {
```

## Old source highlighting plugin

I had used [SyntaxHighlighter Evolved](http://wordpress.org/extend/plugins/syntaxhighlighter/) in WordPress to handle my syntax highlighting needs, so I needed to convert those to Octopress' triple backtick format.

For this, I turned to some perl one liners:

```
perl -MHTML::Entities -p0777i -e 's/(\[sourcecode[^]]*\])(.*)(\[\/(sourcecode)\])/$1.decode_entities($2).$3/mse' *.markdown
perl -p -i -e 's/\[sourcecode.*language="([^"] )"[^]]*\]/``` \1\n/' *.markdown
perl -p -i -e 's/\[sourcecode[^]]*\]/```\n/' *.markdown
perl -p -i -e 's/\[\/sourcecode\]/\n```/' *.markdown
```

That first one uses a little trick to slurp in entire files (seen [here](http://www.debian-administration.org/articles/298)) and decode HTML entities.

## Finishing touches

And, finally, many urls on my site included the hostname, making the Octopress preview less useful.  One more perl one liner:

```
perl -p -i -e 's{http://endot.org/}{/}g' *.markdown
```

## Final verdict

Octopress is awesome.

Enjoy.
