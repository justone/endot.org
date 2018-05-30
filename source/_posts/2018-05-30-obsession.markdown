---
layout: post
title: "Obsessing over multiple projects"
date: 2018-05-30 15:27:22 +0000
comments: true
categories:
- Programming
- Vim
---

In my new job, I've switched each project being a unique combination of git repositories[^1] to all projects being in just a few repositories.

For instance, my primary codebase consists of two repositories, one for the frontend and one for the backend.  As time progresses, I work on multiple (mostly) independent projects in each repo, each one on its own branch.  Each project requires a different constellation of files, sometimes organized in radically different ways in my Vim tabs.

So, to cope with this, I obsess about it.

I've long had Tim Pope's awesome [Obsession](https://github.com/tpope/vim-obsession) plugin installed, but had only rarely used it.  Now, each time I start a new project, I begin with a fresh Vim (well, Neovim) instance and start loading up the files I need, organizing them as I see fit with splits and tabs.  I often get to the point where I'm humming along after loading 5 to 15 files.  At this point, I run `:Obsess Session-something.vim`, where the 'something' is a memorable tag for what I'm working on.  That saves (and continues to save) my session so that I can `:qa` at any point in time and my set up can be easily restored with a `vim -S Session-something.vim`.

What this allows me to do is switch between projects in an instant.  If I have one branch that is close to being merged, I can let the PR simmer while I load up the session from another branch and keep on working.  Also, when it comes time to commit, I like to quite out and start a brand new Vim session, so that I can use [Fugitive](https://github.com/tpope/vim-fugitive) to browse, stage, and write my commit.

One side effect of this workflow is that I end up with several `Session-*.vim` files in the root of my repository.  So then, how do I pick which one to load up without scanning and copy/pasting?  I turn to one of my other favorites, [fzf](https://github.com/junegunn/fzf):

```
vi -S `find . -name 'Session*' | xargs ls -t | fzf`
```

This presents a list of sessions, in reverse chronological order.  I can just hit enter for the most recent one, or navigate and filter to the one I want, which is usually not far away.

I continue to iterate on how to best manage my work environment, and I have a few ideas on how to improve it (e.g. worktrees), but for now, this is quite usable.

[^1]: More on this in another post.
