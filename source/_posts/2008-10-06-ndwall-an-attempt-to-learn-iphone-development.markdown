---
author: nate
date: '2008-10-06 22:46:57'
layout: post
slug: ndwall-an-attempt-to-learn-iphone-development
status: publish
title: 'NDWall: an attempt to learn iPhone development'
wordpress_id: '57'
categories:
- Programming
tags:
- iphone
- ndwall
- objectivec
---

The best way to learn a new programming language/environment is to make something practical with it.

To that end, <a href="http://blog.unleashed.org/">Dave</a> and I started a little side project called (at this point) NDWall.  It's an implementation of a "wall" where new messages can be posted and the 10 most recent can be viewed.  The <a href="https://svn.goodcleansoftware.org/gcs/ndwall/trunk/web/0.1/api.php">server-side api</a> is very simple.  Just two methods (GET and POST) on the api resource.  The data transport is JSON, the lingua franca of web APIs.

We're each making our own version of the client, written in Objective-C using the <a href="http://developer.apple.com/iphone/">iPhone SDK</a>.  To help light the fire, the first version of the client must be written by midnight on Saturday, October 18th.  The first version must do just two things:
<ul>
	<li>Allow posting a new message to the server.</li>
	<li>Download and display the last 10 messages from the server.</li>
</ul>
We started doing this about a month ago, but kept pushing the deadline off as it approached, so this time, we agreed that whoever didn't deliver this time would have to put $20 into a jar*.

I think it's working.  This past Saturday, there was much documentation reading and code typing and instant message sending going on.  Tonight, I got my client to pull the data down for the first time.

This is fun.

* jar money purpose not determined at this time.