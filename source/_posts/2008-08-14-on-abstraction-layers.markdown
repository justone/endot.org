---
author: nate
date: '2008-08-14 13:31:25'
layout: post
slug: on-abstraction-layers
status: publish
title: On Abstraction Layers
wordpress_id: '52'
categories:
- Programming
---

One of the things that's been on my mind recently has been optimizing my work life so that I can either spend less time doing the same stuff or accomplish more in the same amount of time.

In the back of my head has always been <a href="http://www.joelonsoftware.com/articles/fog0000000043.html">Joel's test</a>, and in my feed reader the other day, I found a similar list; the humorously titled "<a href="http://www.postal-code.com/binarycode/2008/07/28/youre-doing-it-wrong-if/">Your Doing it Wrong if...</a>"  I had to laugh hard at the fourth entry on that list, as I have written my own database abstraction layer (hereafter DAL).  I have all sorts of excuses for why it was written at the time, but I must say that after using it for almost three years, I think that using another (preferably open source) layer is the best idea.  I've come to realize (and have read in several places) that you shouldn't write something that is not your core business.  If you're selling stuffed bunnies online, don't write your own shopping cart.  Buy one or use something like <a href="http://www.zencart.com/">ZenCart</a> or <a href="http://www.magentocommerce.com/">Magento</a>.  Of course, if your business is the shopping cart (like, oh, Amazon), then go right ahead.

Anyway, I was talking about DALs with a friend today, and he mentioned <a href="http://jeremy.zawodny.com/blog/archives/002194.html">this blog post</a>, which speaks out against these layers.  The post rails against them as a method of keeping software database independent.  I agree with him that that is not a good reason by itself to use a DAL, but it got me to thinking about why I use one.

My answer to that question comes from <a href="http://www.amazon.com/exec/obidos/ASIN/0735619670">Mr. Code Complete</a> himself, <a href="http://www.stevemcconnell.com/">Steve McConnel</a>.  He's quoted on a <a href="http://www.codinghorror.com/blog/archives/000051.html">Coding Horror</a> post as saying:
<blockquote>Nobody is really smart enough to program computers. Fully understanding an average program requires an almost limitless capacity to absorb details and an equal capacity to comprehend them all at the same time. The way you focus your intelligence is more important than how much intelligence you have.

At the 1972 Turing Award lecture, Edsger Dijkstra delivered a paper titled “The Humble Programmer.” He argued that most of programming is an attempt to compensate for the strictly limited size of our skulls. The people who are best at programming are the people who realize how small their brains are. They are humble. The people who are the worst at programming are the people who refuse to accept the fact that their brains aren’t equal to the task. Their egos keep them from being great programmers. The more you learn to compensate for your small brain, the better a programmer you’ll be. The more humble you are, the faster you’ll improve.

The purpose of many good programming practices is to reduce the load on your gray cells. You might think that the high road would be to develop better mental abilities so you wouldn't need these programming crutches. You might think that a programmer who uses mental crutches is taking the low road. Empirically, however, it's been shown that humble programmers who compensate for their fallibilities write code that's easier for themselves and others to understand and that has fewer errors. The real low road is the road of errors and delayed schedules.</blockquote>
The best reason to use a DAL (or any abstraction, for that matter) is outlined above: to encapsulate a set of functionality (data persistence) and then remove it from the front of the programmers mind.  This frees the mind to concentrate on higher level concerns like (hopefully) the core business logic.  Of course, DALs tend to grow and morph until they become bloated and try to accomplish less important tasks (like database independence), but the real benefit of using them is to write less code and when you write less code, you will naturally create fewer bugs.  I don't want to avoid SQL because I hate it or can't use it, but rather because it is unnecessary to always have it in the front of my mind.

Of course, using or not using DALs should never be a hard and fast rule.  If your application only persists to one table (or a few), or has very tight memory requirements, or uses gypsy midgets, feel free to skip a DAL.

And, as always, these are <a href="http://www.codinghorror.com/blog/archives/001124.html">strong opinions, weakly held</a>.

Good luck.