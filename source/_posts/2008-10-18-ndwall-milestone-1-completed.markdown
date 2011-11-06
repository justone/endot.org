---
author: nate
date: '2008-10-18 15:53:15'
layout: post
slug: ndwall-milestone-1-completed
status: publish
title: 'NDWall Milestone 1: completed'
wordpress_id: '59'
categories:
- Programming
tags:
- iphone
- ndwall
- objectivec
---

Just after 1:30PM today, I finished up my implementation of the first milestone of the <a href="http://endot.org/2008/10/06/ndwall-an-attempt-to-learn-iphone-development/">NDWall project</a>.  The best part was trying to figure out to construct the request to post new messages.  Here are a few screen shots of the app:

<a href="http://www.flickr.com/photos/19501186@N00/2952978866/"><img src="http://farm4.static.flickr.com/3072/2952978866_115888f6bf_t.jpg" border="0" alt="start" /></a><a href="http://www.flickr.com/photos/19501186@N00/2952128067/"><img src="http://farm4.static.flickr.com/3194/2952128067_ab6469c501_t.jpg" border="0" alt="entering message" /></a><a href="http://www.flickr.com/photos/19501186@N00/2952978970/"><img src="http://farm4.static.flickr.com/3210/2952978970_c776d0b16c_t.jpg" border="0" alt="message posted" /></a>

It really doesn't do much other than the two required features.  I haven't profiled it to make sure there are no memory leaks, but I'll do that soon.  The manual memory management of the iPhone is definitely odd for someone like me who's done mostly garbage collected languages in his career.

To learn what I had to for this phase, I relied heavily on reading the sample applications from Apple and through several of the detailed guides that come with the SDK.  The Objective C primer was invaluable, as was the documentation on NSMutableURLRequest.  The documentation browser and search functionality in XCode is pretty good.

Anyway, I feel like I've learned a lot in the past few weeks, and I already have several ideas for milestone 2.  I'll post again when we start that phase.