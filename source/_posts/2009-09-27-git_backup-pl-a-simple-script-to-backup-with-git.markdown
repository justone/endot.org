---
author: nate
date: '2009-09-27 14:24:58'
layout: post
slug: git_backup-pl-a-simple-script-to-backup-with-git
status: publish
title: git_backup.pl - a simple script to backup with git
wordpress_id: '110'
categories:
- Code
- Programming
---

For a while now, I've been backing up the few WordPress blogs that I run for various people with a very simple script that followed this algorithm:
<ol>
	<li>Copy files to a temporary directory.</li>
	<li>Dump the MySQL data into a file in that directory.</li>
	<li>Tarball it up.</li>
	<li>Scp that file to another server that I run.</li>
</ol>
At the time, I did this because it was the simplest thing that could possibly work.  It didn't depend on any external facility other than mysqldump, tar, and scp.

Well, running that script on a nightly cron filled up my disk allocation on that remote server a couple times, so I got clever with the backup organization so I could quickly remove old backups while keeping sparser (monthly) backups for longer.  This only helped a little, because I was still nervous about deleting backups because I didn't know what they contained.

I also have been using <a href="http://git-scm.com/">git</a> more and more recently and I liked the idea of version control that can go in any direction.  So, in the spare bits of time I've had in the past few weeks, I wrote git_backup.pl.  It takes a git repository and does the following:
<ul>
	<li>git add &lt;any new or modified files&gt;</li>
	<li>git rm &lt;any deleted files&gt;</li>
	<li>git commit</li>
	<li>git push backup</li>
</ul>
Now, when the backup is run, only the small changes are sent to the remote server and I can look at the differences by examining the git log.

There are options for dumping database tables, changing the commit message and the remote that gets the push.  Running "git_backup.pl --man" will show all the options.

The source is (of course) in a git repo: http://git.endot.org/git_backup.git

The tree and history can be browsed at <a href="http://git.endot.org/">http://git.endot.org/</a>.