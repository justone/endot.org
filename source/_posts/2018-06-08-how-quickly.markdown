---
layout: post
title: "How quickly can you replicate your development environment?"
date: 2018-06-08 09:31:03 -0700
comments: true
categories:
- Programming
---

Right now, if you needed to recreate your development environment from scratch,
how long would it take?

Would it involve:

* running some shell commands to create or download necessary data?
* creating a custom config file from scratch?
* installing a number of required utilities?
* starting up required database/web/cache services?
* provisioning anything in "the cloud"?
* doing anything that is not written down outside your head?

It should be as few commands as possible, documented in a place that anyone on
your team can see them.

Why is this so important?  Well, having the distance between zero and dev be as
short as possible really helps with your agility.

When you need to try out something that's too radical for a simple branch (or
are just in the middle of something else), you can create a new environment for
it.

When a new developer is hired onto your team, you can create a new environment
for them without sitting next to them for a week.

When your laptop inevitably takes the day off two days before your deadline,
you can create a new environment on the loaner you got from IT and pick up
right where you left off.

Note that I didn't say that your development environment has to be simple.  It
can have dozens of interlocking components that run inside of a handful of VMs,
with loads of coupling and cruft.  I also didn't say that recreating your
development environment has to be quick.  Simplicity and speed are good in
their own right, but the most important is the ability to create a new
environment in a straightforward manner.

It's also worth noting that you don't need to take off a week to polish your
tooling.  Even if you do just one thing to improve the process each week or
month, the effect will snowball and over time you will be closer to using
multiple environments as a tool for faster development.

So, what can you do today to improve your agility?
