---
layout: post
title: "git-annex tips"
date: 2014-01-01 13:14
comments: true
categories: 
- Computers
- git-annex
---

Last time I [posted about git-annex](/2013/01/04/managing-backups-with-git-annex/), I introduced it and described the basics of my set up.  Over the past year, I've added quite a bit of data to my main git-annex.  It manages just over 100G of data for me across 9 repositories.  Here's a few bits of information that may be useful to others considering git-annex (or who are already knee deep in).

## Archive, not backup

The [website for git-annex](http://git-annex.branchable.com/not/) explicitly states that it is not a backup system.  An alternate description, that's more appropriate, is that it's part of an archival system.  An archival system is somewhat concerned with backups of data, but it also deals with cataloging and retrieval.

I imagine that it's a library system (books, not code) with the ability to do instantaneous inter-library loans.  I have one repository (by the name of 'silo') that contains copies of all my data.  I then have linked repositories on each computer that I use regularly that have little or no data in them, just git-annex style symlinks.  If I find that I need something from the main repository on one of those computers, I can query where that file is with `git annex whereis`:

``` sh
$ git annex whereis media/pictures/2002-02-08-olympics.tgz
whereis media/pictures/2002-02-08-olympics.tgz (4 copies) 
        8314baa2-4193-8d77-bb7f-489bd73e7db4 -- calvin_dr
        8b22886e-14f2-98f0-31ec-6770b0a08f22 -- silo
        f8ec3d60-47bf-a392-4739-b39dd609d554 -- hobbes_dr
ok
```

(I actually have three full copies of my data, in the *_dr repositories, but that's a story for another day.  Suffice it to say that calvin_dr and hobbes_dr are two identical external drives.)

I can retrieve the contents with `git annex get`.  git-annex is smart enough to know that the silo remote is over a network connection and the 'calvin_dr' is local, so it copies the data from there:

``` sh
$ git annex get  media/pictures/2002-02-08-olympics.tgz
get media/pictures/2002-02-08-olympics.tgz (from calvin_dr...) 
SHA256E-s48439263--67c0de0e883c5d5d62a615bb97dce624370127e5873ae22770b200889367ae1c.tgz
    48439263 100%   25.10MB/s    0:00:01 (xfer#1, to-check=0/1)

sent 48445343 bytes  received 42 bytes  19378154.00 bytes/sec
total size is 48439263  speedup is 1.00
ok
(Recording state in git...)
```

Then, running `git annex whereis` shows the file contents are local as well:

``` sh
$ git annex whereis media/pictures/2002-02-08-olympics.tgz
whereis media/pictures/2002-02-08-olympics.tgz (5 copies) 
    8314baa2-4193-8d77-bb7f-489bd73e7db4 -- calvin_dr
    8b22886e-14f2-98f0-31ec-6770b0a08f22 -- silo
    f8ec3d60-47bf-a392-4739-b39dd609d554 -- hobbes_dr
    ae7e4cde-0023-1f1f-b1e2-7efd2954ec01 -- here (home_laptop)
ok
```

And I can view the contents of the file like normal:

``` sh
$ tar -tzf media/pictures/2002-02-08-olympics.tgz | head
2002-02-08-olympics/
2002-02-08-olympics/p2030001.jpg
2002-02-08-olympics/p2030002.jpg
...
```

Then, when I'm done, I can just `git annex drop` the file to remove the local copy of the data.  git-annex, in good form, checks to make sure that there's another copy before deleting it.

``` sh
$ git annex drop media/pictures/2002-02-08-olympics.tgz
drop media/pictures/2002-02-08-olympics.tgz ok
(Recording state in git...)
```

All along the way, git-annex is tracking which repositories have each file, making it easy to find what I want.  This sort of quick access and query-ability means that I know where my data is and I can access it when I need it.

## Transporting large files

My work laptop used to be my only laptop, and so it had a number of my personal files, mostly pictures.  I've transfered most of those off of that system, but every once in a while, I come across some personal data that I need to transfer to my home repository.

I usually add it to the local git-annex repository on my work laptop and then use `git annex move` to move it to my home server.  However, if it's a significant amount of data and I don't feel like waiting for the long transfer over my slow DSL line, I can copy the data to my external drive at work and then copy it off when I get home.  Doing this manually can get tedious if there are more than a few files, but git-annex makes it a cinch.  First, I can query what files are not on my home server and then copy those to the calvin_dr drive.

``` sh
work-laptop$ git annex add huge-file1.tgz huge-file2.tgz huge-file3.tgz
work-laptop$ git annex sync
work-laptop$ git annex copy --not --in silo --to calvin_dr
```

Then, when I get home, I attach the drive to my personal laptop and run `git annex copy` to copy the files to the server:

``` sh
personal-laptop$ git annex copy --to silo --not --in silo
```

## Detecting duplicates

Many of my backups are the "snapshot" style, where I rsync'd a tree of files to another drive or server in an attempt to make sure that data was safe.  The net effect of this strategy is that I have several mostly-identical backups of the same data.  So, when I find a new copy of data that I've previously added to my git-annex system, I don't know if I can safely delete it just based on the top level directory name.

For example, if I discover a tree of pictures that are organized by date and event:

``` sh
$ find pictures -type d
pictures
pictures/2002-02-08-olympics
pictures/2002-04-20-tahoe
pictures/2004-11-18-la-zoo
```

And, checking in my git-annex repo, I can see that there are three files that correspond to those directories:

``` sh
$ find backup/pictures -type l
backup/pictures/2002-02-08-olympics.tgz
backup/pictures/2002-04-20-tahoe.tgz
backup/pictures/2004-11-18-la-zoo.tgz
```

I can probably remove the found files, but I might have modified the pictures in this set and I'd like to know before I toss them.  After running into this scenario a few times, I wrote a little utility called [archdiff](https://github.com/justone/archdiff) that I can use to get an overview of the differences between two archives (or directories).  It's just a fancy wrapper around `diff -r --brief` that automatically handles unpacking any archives found.  For example:

``` sh
$ archdiff 2002-04-20-tahoe/ ~/backup/pictures/2002-04-20-tahoe.tgz
$ 
```

Since there was no output, the directory has the same contents as the archive and can be safely deleted.  Here's another example:

``` sh
$ archdiff 2002-02-08-olympics/ ~/backup/pictures/2002-02-08-olympics.tgz 
Files 2002-02-08-olympics/p2030001.jpg and 2002-02-08-olympics.tgz-_RhD/2002-02-08-olympics/p2030001.jpg differ
$ 
```

One of the files in this directory has modifications, so I can now take the time to look at the two files and see if I want to keep it or not.

Archdiff behaves like a good UNIX program and its exit code reflects whether or not differences were found, so it's possible to script the checking of multiple directories.  Here's an example script that would check the above three directories:

``` sh
#!/bin/bash

cd ~/backup/pictures

for dir in ~/pictures/*; do
    basedir=$(basename $dir)
    echo "checking $dir"

    # retrieve the file from another git-annex repo
    git annex get $basedir.tgz

    if archdiff $dir $basedir.tgz; then
        echo "$dir is the same, removing"
        rm -rf $dir

        # drop the git-annex managed file, we no longer need it
        git annex drop $basedir.tgz
    fi
done
```

Once this is done, the only directories left will be those with differences and the tarball will still be present in the git-annex repository for investigation.  I end up writing little scripts like this as I go through old backups to help me process large amounts of data quickly.

## All done

That's it for now.  If you have any questions about this or git-annex in general, tweet at me [@ndj](https://twitter.com/ndj).

Enjoy.
