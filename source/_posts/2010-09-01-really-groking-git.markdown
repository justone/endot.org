---
author: nate
date: '2010-09-01 00:04:15'
layout: post
slug: really-groking-git
status: publish
title: Really Groking Git
wordpress_id: '174'
categories:
- Computers
- Programming
---

I've been using git for a while now, and I'm just getting to the point where I can think in it.

It's the same as learning a new spoken language.  I took three years of Spanish in high school, so I knew most of the rules and could translate back and forth to English, but I never really learned to think in Spanish (as opposed to thinking in English and then quickly translating).  And, until you start thinking in Spanish, you are not on the path to full fluency and you'll be constantly hampered whenever you try to talk with a native speaker.

I came to git from the world of subversion (a world that I'm quickly wishing I could fully leave).  So my first forays into git-dom were guided by the <a href="http://git-scm.com/course/svn.html">SVN Crash Course</a>.  This allowed me to get access to git repositories quickly, but it kept me thinking in subversion.  I wanted to use git more idiomatically.  So I read and I read, I cloned and fetched and pushed and merged and after a while, I began to feel like I was really understanding git.

Last week, when I was chatting with a couple of my programmer geek friends about git and version control, I got to thinking about what has helped me the most in my learning experience.  Here's what I came up with.

<strong>Really understand how git stores its data.</strong>

Git stores it's data as a directed acyclic graph, which is just about as simple as you can get.  Commits point to their parent commit, which in turn point to their parent, and so on.  A new node is created for every commit and a merge just points at all of its parents.  Combine this knowledge with the fact that branches are just named pointers to nodes in this graph and you start to have more confidence when it comes time to change things around.

<strong>Learn the "get out of jail" command: git reset --hard</strong>

That's all you need to undo almost anything you might have done.  This command takes the current branch and points it at the commit you referenced.

For instance, if you want to revert a branch back to where it was at the last fetch:

```
$ git reset --hard origin/branchname
```

Or, if you decide that the last three commits should be forgotten:

```
$ git reset --hard HEAD~3
```

Or, if you don't like the result of that interactive rebase:

```
$ git branch before
$ git rebase -i HEAD~3
# decide the rebase was bad
git reset --hard before # all better
```

<strong>Don't be afraid to experiment.</strong>

One of the best things about a distributed version control system is that you are free to mess around with your repository all you want and no one will know about it.  Go ahead.  Rebase your commits to be cleaner, rearrange branches to make them easier to work with, or rewrite every commit because you forgot to set your email address.  It doesn't matter at all until you share those changes with other people.

Also, almost nothing in git will delete data.  In truth, it's rather hard to permanently remove a commit.  Because of this, even if something happens that you don't like, you can use 'git reset' to make it all go away.  For instance, if you have a repository with a dozen commits and you want to change the committer email, when the commits are rewritten, the old commits are still there in the database, waiting to be resurrected if you change your mind.

<strong>Read <a href="http://progit.org/book/">Pro Git</a>.</strong>

This book was instrumental in helping me move from beginner to intermediate.  I recommend reading it cover to cover, even if you don't ever plan on writing a hook or running 'git filter-branch'.  Just seeing how it all fits together helps inform day to day decisions when using git.

That's it for now.  Have fun.