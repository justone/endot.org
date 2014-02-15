---
layout: page
title: "Talk Notes: Clojure core.async"
date: 2014-02-14 17:03
comments: true
sharing: true
footer: true
tags:
- notes
---

# Summary

    Title: Clojure core.async
    Conference: Strange Loop 2013
    Speaker: Rich Hickey
    Date: 2013-11-22

<http://www.infoq.com/presentations/clojure-core-async>

# Notes

Motivations and some API didsussion.

Problems to solve:

* Function chains make poor machines
* Real world concurrency is exposed with callbacks

"Good programs should be made of processes and queues."  Data is passed through
a system from one end to another, so conveyance must be a first class
construct.

Native Java queues are meh, require threads to block.  Threads are heavyweight, not a good way to scale.

Since Clojure also compiles to Javascript, and JS doesn't have threads (and therefore no queues), threads are out.

Current mindshare is events/callbacks.  Fragments the logic, difficult to reason about.  Does not map to the way we reasoned about the problem, but is purely a construct of the implementation.

Diagram of the problem:

![](problem.png)

Shared state is the result of needing to coordinate multiple inputs and outputs.  OO doesn't help this, just wraps it in a big bubble.

C# has a way of taking linear code with async parts and keeping track of where the code is while relinquishing the running thread.  Then, when the result is ready, the thread is re-assigned and processing continues.  This allows the code to look linear while in fact being async and nice to the machines resources.

Problem is that it's just sugar, can't model enduring connections.

## Queues!

* Decouple producers/consumers - no direct reference between the two
* First-class - a language construct, addressable
* Enduring - outlasts any reader or writer
* Monitorable
* Can have multiple readers and writers

Communicating Sequential Processes - CSP (an alternative to actors)

Channels as a first class concept, blocking by default, but can be buffered.  Can be passed around as regular objects.  Can be used for coordination.  Also in Go!  Ability to multiplex between multiple channels for read and/or write.

Challenge is to work both in Clojure and Clojurescript, support both threaded and non-threaded


## core.async

Library to support CSP in Clojure, supporting both threaded and non-threaded

Create thread:

    (thread body....)

Create IOC 'thread' that does pretty much exactly what C# was doing: store the state somewhere, relinquish the thread (parking) and restart when calls return

    (go body....)

Channels are like queues, default to blocking, multi writer and reader.

Single bang for parking, double bang for blocking thread.  Can be intermixed in JVM, but only single bang is available in JS (because no threads).

Same semantics for putting to a buffered channel as in Go:

* Unbuffered channel blocks on both ends, can be used for rendezvous
* Fixed buffered channel will accept read/write if data is there or space is there, block otherwise

Adds two other types: sliding-buffer (which just slides down the existing data if full) and dropping-buffer (which throws away the new value if full)

Never allows unbounded buffers

## Choice

Waiting on multiple operations, could be a channel take or put, only one op will complete.

'alt!' is like 'select' in Go.

Timeouts are just channels, also like Go.

Differs from Go in that operations are expressions instead of statements, 'alts!' is a function, not a language statement, and 'alt' supports priority.

put! and take! can be used to turn regular call backs into entry points into the async system

## Browser

Turn the output from callbacks into data and back into channels, so that no logic is present.

## End result

![](result.png)

## Comparison

![](compare.png)

* "Place state" - squirreled away so that multiple handlers can come back to the state and pick up where they or others left off.
* "Flow state" - you hand data into a channel and read it out somewhere else, data driven

Showed a Clojure port of <http://talks.golang.org/2012/concurrency.slide#50>

## Conclusion

* Separation of concerns
* Coherent, linear logic
* Recursion replacing mutation
* Coordination, backpressure (which would be difficult with callbacks)
* Dynamic configuration and reconfiguration depending on needs
* Efficiency - scale further

Links:

* Code: <https://github.com/clojure/core.async>
* Docs: <http://clojure.github.io/core.async/>
* Blog post: <http://clojure.com/blog/2013/06/28/clojure-core-async-channels.html>
