---
author: nate
date: '2010-03-14 13:19:59'
layout: post
slug: mounting-usb-ext3-partitions-on-opensolaris
status: publish
title: Mounting USB ext3 partitions on OpenSolaris
wordpress_id: '137'
categories:
- Computers
- Home
---

<strong>[Update]</strong> It looks like this only really applies to USB flash drives.  When I mounted my actual backup drive, it showed up in prtpart.  This post was written using the root drive on my old backup server, which is a SanDisk Cruzer flash drive.

<hr/>

Now that I finally got <a href="/2010/03/14/my-mini-thumper-is-online/">my mini thumper up and online</a>, it's time pull everything from my previous  backup drive.  The problem is that it's a USB drive with an ext3 partition on it.  I did a little googling and found several references to using the belenix FSWpart and FSWfsmisc packages, with <a href="http://blogs.sun.com/pradhap/entry/mount_ntfs_ext2_ext3_in">this one</a> being the most helpful.

My only problem was that when I ran prtpart, it only showed disk information for my non-USB drives.  I could see that the drive was recognized by looking in syslog:

[sourcecode gutter="false"]root@silo:~# cat /var/adm/messages
Mar 14 12:03:36 silo usba: [ID 349649 kern.info]        SanDisk U3 Cruzer Micro 0774920CB281D664
Mar 14 12:03:36 silo genunix: [ID 936769 kern.info] scsa2usb0 is /pci@0,0/pci1462,7418@1d,3/storage@1
...
[/sourcecode]

So, I dug around a bit, trying to look for various names in /dev/rdsk that were in the above output when I stumbled across the fact that everything in /dev/rdsk is a symlink.  So I did a quick grep:

[sourcecode gutter="false"]
root@silo:~# ls -al /dev/rdsk/ | grep /pci@0,0/pci1462,7418@1d,3/storage@1
lrwxrwxrwx   1 root root  64 2010-03-14 12:03 c11t0d0p0 -&gt; ../../devices/pci@0,0/pci1462,7418@1d,3/storage@1/disk@0,0:q,raw
lrwxrwxrwx   1 root root  64 2010-03-14 12:03 c11t0d0p1 -&gt; ../../devices/pci@0,0/pci1462,7418@1d,3/storage@1/disk@0,0:r,raw
....
[/sourcecode]

Aha! Now I know what the device name is, so I can use prtpart to figure out what to mount:

[sourcecode gutter="false"]root@silo:~# prtpart /dev/rdsk/c11t0d0p0 -ldevs
Fdisk information for device /dev/rdsk/c11t0d0p0

** NOTE **
/dev/dsk/c11t0d0p0      - Physical device referring to entire physical disk
/dev/dsk/c11t0d0p1 - p4 - Physical devices referring to the 4 primary partitions
/dev/dsk/c11t0d0p5 ...  - Virtual devices referring to logical partitions

Virtual device names can be used to access EXT2 and NTFS on logical partitions

/dev/dsk/c11t0d0p1      Linux native
[/sourcecode]

And mount it:

[sourcecode gutter="false"]root@silo:~# mkdir /mnt/linux
root@silo:~# mount -F ext2fs /dev/dsk/c11t0d0p1 /mnt/linux
root@silo:~# ls /mnt/linux/
bin  dev  etc  home  initrd  lib  lost+found  media  mnt  proc  root  sbin  sys  tmp  usr  var  www
[/sourcecode] 