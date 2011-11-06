---
author: nate
date: '2010-03-14 13:18:09'
layout: post
slug: my-mini-thumper-is-online
status: publish
title: My mini thumper is online!
wordpress_id: '146'
categories:
- Computers
- Home
---

After basically copying <a href="http://serialized.net/2009/02/the-littlest-thumper-opensolaris-nas-on-an-msi-wind-pc/">my friend's exact specifications</a>, I now have a little server at home with 1.5T of mirrored disk space.  By and large it was a straightforward process, with the following interesting tidbits.

Most of the assembly went smoothly.  You do have to pull the motherboard out to get the CF drive into its slot.  In order to maneuver it out, you have to unclip the SATA cables and unscrew the VGA connector.

<a href="http://endot.org/wp-content/uploads/2010/03/case.jpg"><img class="alignnone size-medium wp-image-147" title="case" src="http://endot.org/wp-content/uploads/2010/03/case-300x225.jpg" alt="case" width="300" height="225" /></a>

You can see the SATA cables snaking up the left and top and the VGA connector is in the lower right (blue).  The CF slot is just left of center at the bottom of the picture.  Here's a picture with the drive and RAM installed.

<a href="http://endot.org/wp-content/uploads/2010/03/case2.jpg"><img class="alignnone size-medium wp-image-148" title="case2" src="http://endot.org/wp-content/uploads/2010/03/case2-300x225.jpg" alt="case2" width="300" height="225" /></a>

The other issue I ran into was related to the optical drive bay.  My first drive slid in and mounted fine in the HD bay, but I was stuck without brackets to properly secure the second drive in the 5.25 inch bay.  I could have just put it in and held it with one screw, but after figuring that this is my backup server, I opted to head to Best Buy to pick up the brackets.

When I got there, I was informed that they don't carry them any more and that I would have to pay a visit to Fry's.  Well, I hate going to Fry's more than most bad things in life, so I called it a day and decided to figure it out later.  Then, earlier this week, Sara and I were walking by a little local computer shop named <a href="http://www.techquest.net/">*techquest</a>.  The proprietor was able to dig up a pair of brackets, so I bought them from him.

Yesterday, I finished assembling the hardware and then spent a while trying to figure out how to get it to boot OpenSolaris from the USB drive I had created.

The first problem was that I couldn't get into the Wind BIOS.  I could see it flash something on the screen after POST beeping, but it was cleared far too fast for me to get any information.  After rebooting a few times and only getting a few words, I turned my iPhone video camera on it and was able to finally read the information with a well timed pause.

The rest of my issues revolved around the unique arrangement of boot options in the BIOS and having to remove the stupid U3 stuff from the Cruzer so that it behaved like a simple USB disk, but soon enough I was installing OpenSolaris.

The little box now sits in my entertainment center, ready for me to start transferring data to it.