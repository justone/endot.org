---
author: nate
date: '2011-05-18 20:49:02'
layout: post
slug: git-submodules-vs-subtrees-for-vim-plugins
status: publish
title: Git submodules vs. subtrees for vim plugins
wordpress_id: '234'
categories:
- Code
- Computers
- dfm
---

After a few months of <a href="/2010/10/16/dfm-a-utility-to-manage-dotfiles/">managing my dotfiles with git</a>, I felt the need to organize my vim plugins a little better.  I chose to use <a href="https://github.com/tpope/vim-pathogen">pathogen</a> (created by <a href="http://tpo.pe/">Tim Pope</a>), which allows me to keep each plugin in its own subdirectory.  It fits well with using git to manage dotfiles because git has two ways of tracking content from other repositories.  The first is submodules, which keep a remote URL and commit SHA1 so that the other content can be pulled in after cloning.  The second is subtrees, which merges the history of the outside repository directly into a subdirectory.  Here's a quick list of the pros and cons of each strategy:

<strong>Submodules</strong>

Pros:
<ul>
	<li>Each plugin is self contained and segregated from the rest of your files.</li>
	<li>It's easy to see what files came from other sources.</li>
</ul>
Cons:
<ul>
	<li>Making tweaks to plugins is difficult; requires managing a fork of the upstream repo.</li>
	<li>Submodules are difficult to update.</li>
	<li>Initial clone takes longer as each submodule needs to be initialized and fetched.</li>
</ul>
<strong>Subtrees</strong>

Pros:
<ul>
	<li>Only one command to get all your files.</li>
	<li>Making tweaks to plugins is easy, just modify and commit.</li>
	<li>Initial clone is faster.</li>
</ul>
Cons:
<ul>
	<li>It's more difficult to extract changes and submit them back upstream.</li>
	<li>Plugin files are in your repository too, potentially confusing your history</li>
	<li>Difficult to determine exactly where other content came from</li>
</ul>
After trying both out on a branch in my repository, I settled on using subtrees.  Using them <a href="http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html">can be daunting</a>, but there's a fantastic wrapper called <a href="https://github.com/apenwarr/git-subtree/">git-subtree</a> that greatly simplifies the whole process.

For instance, to add <a href="https://github.com/tpope/vim-fugitive">vim-fugitive</a> (another by Mr. Pope), all I ran was this command:

```
git subtree add --prefix .vim/bundle/vim-fugitive https://github.com/tpope/vim-fugitive.git master --squash
```

This results in a single commit that contains the squashed history of the vim-fugitive plugin and a merge commit which merges that squashed commit into my repository.  Here's what that looks like on github: <a href="https://github.com/justone/dotfiles/commit/ad19e0209a4a262153f0590b8707eac74e809649">ad19e02</a>.

After that merge, the vim-fugitive files are now part of my repository.  No extra steps are necessary to get those files after an initial clone.

While I was writing this, I noticed that there have been a few more commits on the main fugitive repo, so I ran the following command to merge in those changes:

```
git subtree pull --prefix .vim/bundle/vim-fugitive https://github.com/tpope/vim-fugitive.git master --squash
```

It all works quite well.  As of this post I have eleven plugins managed with subtrees and it only takes a couple seconds to clone my entire repo onto a new machine or VM.
