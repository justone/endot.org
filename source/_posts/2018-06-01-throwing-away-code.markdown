---
layout: post
title: "Throwing away code"
date: 2018-06-01 20:25:31 +0000
comments: true
categories:
- Programming
---

As developers, we often say when building something new that we ["plan on throwing one away"](http://wiki.c2.com/?PlanToThrowOneAway).

Over time, my experience has been that this applies far more to subsystems than
it does to entire systems.  There are many reasons why this is true.

The first is the iceberg effect.  This happens when you build the first version
and make the double mistake of making the UI too pretty AND showing it to
someone above middle management.  They instantly conclude that it is done and
refuse to let you throw it away, forcing you to replace lower level components
one by one until the system is maintainable.

The second reason is that we as developers too often think we can build general
software before it is needed.  This usually surfaces as plugin systems with
a single plugin or overly complex configuration for a seemingly trivial task.
Inevitably, the first time any of these implementations hits the reality of
a second use case, everything falls apart and the whole thing is rewritten.
There is usually an adjustment for the third use case, but it's rarely
something that forces a full rewrite.  It's the second one that really causes
trouble.

The third reason is the familiarity divide between the original creators[^1] and
basically anyone else who joins the project.  This latter group have to learn
some portion of the system to accomplish any task, and no matter how well
designed or documented the it is, there is little hope that they'll be able to
understand it correctly the first time.  So they will inevitably have to
rewrite large portions of their new code as they learn and re-learn the system[^2].
This usually goes down over time, but it can spike again when a new subsystem
is explored.

The fourth reason is that most useful software is used by some group of people,
and because people (and their groups) change, what they need from their
software changes too.  This causes large portions to be excised, reformed, or
even worked around so that those people will continue to use (and, more
importantly, pay for) the software.

All of this together makes me think of the word "legacy".  From some of the
meetings I've been in, it's one of the worst words you can use to describe any
piece of software, and is usually used to mark something that couldn't possibly
still be useful merely because of its age.

I think that instead it should be used as a badge of honor.  It should be
applied to all the code that wasn't thrown away because it was a prototype or
too general or too uneducated or no longer useful.  It **survived** long enough
to still provide value today.

So therefore:

1. Don't be afraid to throw code away.  It's part of the circle of life for code and it happens ALL THE TIME.
2. Be proud that you made something useful, if even it's only for a while.

<hr/>

[^1]: I almost said original **designers** here, and then remembered that a system of any age rarely continues to have one design(er), but is usually a conglomerate of smaller designs.  Kinda like Voltron.

[^2]: This is one reason why having a good code review culture is vital for assimilating adding new members to your team.  So much design discussion comes out via code reviews, that I feel like there should be a stenographer sometimes.

