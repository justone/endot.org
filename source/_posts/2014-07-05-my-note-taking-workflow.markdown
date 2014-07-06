---
layout: post
title: "My note-taking workflow"
date: 2014-07-05 19:56:13 -0700
comments: true
categories: 
- Computers
- Notes
---

A few people have asked about my note-taking workflow and it's been quite useful to me, so I thought I would describe what works for me.

I've tried several of the popular note-taking tools out there and found them overbearing or over-engineered.  I just wanted something simple, without lock-in or a crazy data format.

So my notes are just a tree of files.  Yup, just directories and files.  It isn't novel or revolutionary.  It doesn't involve a fancy application or Web 2.0 software.  It also works surprisingly well.

## Formatting

I'd taken notes in plain-text files for a while, but what really made my notes more useful was that I switched to [Markdown](http://daringfireball.net/projects/markdown/) a few years ago. Markdown is one of the best text formatting languages out there[^1], and many sites use it as their markup language.

So, any time I take notes, I write in Markdown.  It took a little while to get used to the syntax, but thankfully the basics are straightforward and sensible.  It also looks great without any processing.  I can share it with others without reformatting.  Or, if I need a fancier presentation, I can use [pandoc](http://johnmacfarlane.net/pandoc/) to transform it into almost any other format imaginable.

## Tooling

There are a plethora[^2] of tools that understand a tree of files.  I can use find, ack, vim, and any other command line tools to manage my personal knowledge base.  Not only does this make my notes more accessible, but it also means that I develop greater competency in the tools I also use for everyday development.

I originally used [Notational Velocity](http://notational.net/) (and then [nvALT](http://brettterpstra.com/projects/nvalt/)) for note taking.  I really liked the quick searchability that it provides.  After a [buddy](http://serialized.net/) suggested that Vim would be able to do the same, I switched over immediately.  For filename searching, I use [ctrlp.vim](https://github.com/kien/ctrlp.vim) ([custom config](https://github.com/justone/dotfiles-personal/blob/personal/.vimrc#L108-L127)) and for content searching I use [ack.vim](https://github.com/mileszs/ack.vim).

As far as rendering to other formats, I use the most excellent pandoc.  In my [vimrc](https://github.com/justone/dotfiles-personal/blob/personal/.vimrc), I have mapping for converting the current file to html with pandoc:

```
nmap <leader>vv :!pandoc -t html -T 'Pandoc Generated - "%"' --smart --standalone --self-contained --data-dir %:p:h -c ~/.dotfiles/css/pandoc.css "%" \|bcat<cr><cr>
```

It generates a self-contained html page (with images embedded as data urls) and then opens the output in a web browser (thanks to this [bcat](https://github.com/justone/dotfiles-personal/blob/personal/bin/bcat) script).

## Sync

Universal access is incredibly important for note taking. Without it, your distilled knowledge is locked inside your computer.

To make my notes available wherever I go, I keep them in Dropbox[^3]. DropBox does a decent job of synchronizing, but it's best feature is its integration into so many iOS apps. Almost every app that supports remote file access integrates with Dropbox.

I'd love to use [BitTorrent Sync](http://www.bittorrent.com/sync), but its developer API was only recently released and it's going to take time for apps to support it.

## Mobile Application

For mobile access I used to use [Notesy](http://notesy-app.com/).  I appreciated its simple interface and quick rendering preview.  It recently gained a few keyboard helpers for frequently used markdown characters.

However, once [Editorial](http://omz-software.com/editorial/) was released as a universal application, I switched over immediately.  Not only is it's main editing interface more pleasant to use, with better helpers and inline markdown rendering previews, it also sports the ability to add snippets via abbreviations and a phenomenally powerful workflow system that can orchestrate inter-app automation.

## Use cases

There are many use cases where my system is useful.  Here are a few.

### Notes instead of bookmarks

I used to save bookmarks on [Delicous](https://delicious.com/justice) as I found interesting URLs online.  I found out, however, that over time I never went back and looked at those bookmarks because they weren't coherently organized.  There's something about tags that just doesn't help when it comes to searching for information.

Now, instead of saving bookmarks, I create notes based on particular topics and add links I find to those files.  The fact that it's a regular text file means that I can not only use Markdown sections to organize links into headings, but I can also include sample code blocks or images from the local directory.

### Talk notes

By virtue of the fact that I take notes in Markdown and my blog is Markdown, when I take [notes on talks](/2014/01/31/introducing-talk-notes/), it's extremely easy to publish them.  I just copy them over and add the right Octopress YAML header.

### Conference notes

When I'm at a conference, I can choose to take notes on my phone or my laptop depending on the type of content.  One time I was taking notes on my laptop during a late-in-the-day session and noticed that my battery was getting low.  I didn't need to have the laptop out for any other reason, so I closed it up, opened my phone, and continued taking notes where I'd left off.

### Sermon notes

I keep notes every Sunday and keep those notes in a sub-folder. It's easy to keep types of notes separate by just using regular folders. 

### Blog post editing

This one is a little meta, for sure.  I've edited this blog post over the course of a few weeks, sometimes on a computer and sometimes on either my iPad or iPhone. I keep a clone of this blog's source in Dropbox as well, so I can do most of my editing wherever I happen to be. After that, a few quick commands over ssh and this post will be live.

## Conclusion

That pretty much covers my note-taking system. If you'd like to adopt a similar system, let me know how it goes and any cool tools that you discover.

Enjoy.

[^1]: I tried [RST](http://docutils.sourceforge.net/rst.html) too, but I found it to be too prickly for my note taking needs.  However, it's awesome for software documentation.
[^2]: [What is a plethora?](https://www.youtube.com/watch?v=-mTUmczVdik)
[^3]: Oh oh, guess I do use a Web 2.0 tool.
