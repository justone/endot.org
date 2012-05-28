---
layout: post
title: "Easy development with git_backup"
date: 2012-05-27 14:48
comments: true
categories: 
- Code
- Programming
---

I've been using [git_backup](/2009/09/27/git_backup-pl-a-simple-script-to-backup-with-git/) to back up the websites I run for quite a while now.  It works well and I only need to scan the daily cron emails to see if the backup went well or if there were any odd files changed the day before.

One thing that I didn't expect when I started using it was how it would enable developing those websites in a sandbox without any danger of affecting the production instances.

## Local development

Back when my blog was powered by [Wordpress](http://wordpress.org/), I would do most of my major modifications on a copy of my blog that ran on my local desktop.

### Setup

First, to provide the LAMP stack, I downloaded [MAMP](http://www.mamp.info/en/index.html).

Then, I cloned my blog from my backup server and modified the code to point at a local database.

``` plain
$ git clone nate@mybackupserver.com:endot.org.git
Cloning into 'endot.org'...
remote: Counting objects: 2661, done.
remote: Compressing objects: 100% (1321/1321), done.
remote: Total 2661 (delta 1157), reused 2538 (delta 1098)
Receiving objects: 100% (2661/2661), 3.82 MiB | 342 KiB/s, done.
Resolving deltas: 100% (1157/1157), done.
$ cd endot.org && vi html/wp-config.php  # edit to point at local database
$ git ci -am 'modifying to point at local database'
```

And finally, I imported the live database data:

``` plain
$ for dbfile in db/*; do echo "processing $dbfile"; mysql --defaults-file=.my.cnf endot_dev < $dbfile; done
```

At this point, I was free to try out new plugins or do any wide-reaching change without worrying that I might break something permanently.  Then, when I was confident about the change I wanted, I would change the live site.

### Synchronizing

When I wanted to update my local working copy, all I needed to run was a few git commands:

``` plain
$ git reset --hard HEAD
$ git clean -fd
$ git pull --rebase
```

The first clears out any changes I had made.  The second removed any untracked files (new plugins, etc.).  And the third grabbed upstream changes while preserving my commit that changed the config to point at my local database.

Then, I re-imported the live database data.

Once this was done, I had an up-to-date copy of my blog to play around with.

## Server-side development

For one of the [Drupal](http://drupal.org/) installations I ran, I used a scripted version of the above technique to keep a development copy up to date on the server.  This allowed the site's admins to have the same safety net while trying out new things that I had locally, but without having to set up a local database and web server.

Here is the cron script:

``` sh
#!/bin/sh

cd /var/www/dev.domain.com

echo -e "\nCleaning up extra files."
echo "=================================================================================="
chmod u+w html/sites/default/
git reset --hard HEAD
git clean -df

echo -e "\nSynchronizing with live site backup."
echo "=================================================================================="
git pull --rebase

echo -e "\nLoading database."
echo "=================================================================================="
for dbfile in db/*; do echo "processing $dbfile"; mysql --defaults-file=/root/.my.cnf site_dev < $dbfile; done

echo -e "\nDone."
```

The only odd line is the `chmod`.  That was necessary because Drupal itself made that directory unwritable and that prevented the `git pull` command from working.

Cron ran this script at 1am every night, so each morning the development site would be an up-to-date copy of the previous day's content and code.  This was frequent enough for the site's owner and when he wanted it reset in the middle of the day I would just manually run the script.

Enjoy.
