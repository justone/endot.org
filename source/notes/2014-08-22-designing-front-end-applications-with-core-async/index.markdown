---
layout: page
title: "Talk Notes: Designing Front End Applications with core.async"
date: 2014-08-22 11:00
comments: true
sharing: true
footer: true
tags:
- notes
---

# Summary

    Title: Designing Front End Applications with core.async
    Conference: Online Webinar
    Speaker: David Nolen
    Date: 2014-08-22

<http://go.cognitect.com/core_async_webinar_recording>

# Notes

Frontend usually means Javascript.  But the code can get ugly pretty fast.

JS' solutions to async:

* Callbacks
* Promises

ClojureScript was created 3 years ago to introduce Clojure concepts to the frontend.  Iterop was a priority.

Google Clojure compiler is the way to deliver the final product

* Minification
* Dead code elimination
* Standard library

## core.async

A little over a year old.

Based on CSP, which is superior to callbacks as it handles both:

* One-off tasks (handled fine with callbacks)
* Streams/queues ( not handled)

go blocks give illusion of blocking in single threaded context, eliminates callback hell

### Concepts:

* Channels - a conduit between different processes, a pipe
* Buffers - intermediate storage for channels, configurable
* Transducers - (new!) efficient way to control how values enter and exit the channel
* Go blocks - async blocks of execution, illusion of blocking operations in single threaded

### Core operations

* Putting into a channel
* Taking values from a channel
* Selecting over multiple channels

10 short examples of core.async (<https://github.com/cognitect/async-webinar>)

### Example 1

code in `src/webinar/core.cljs`

Background:

* line 14 is good example of interop
* events->chan - read out dom events from the browser
* mouse-loc->vec - extract a vector from a mouse event
* show! - convenience for putting info into the dom

Examples

* ex1 - one click
* ex2 - two click
* ex3 - two channels
* ex4
    * What happens when a channel is blocked
    * put blocks until there's a taker
* ex5
    * fixing the above with two go blocks
    * semantics: go blocks are async processes
* ex6
    * first transducer mapping the mouse event into a vector
    * local event loop
    * alts! selects over channels, mouse move and the clicks channel, reads from first available
* ex7
    * same as previous, but more transducers
        * composed together the transformation with a filter
* ex8
    * example of using loop to store a local state
* ex9
    * code that you might see in a real UI
    * listen to both buttons while keeping track of which animal is shown
* ex10
    * async/merge - takes more than one channel and merges them

## Other resources

* Rich Hickey's original announcement - <http://clojure.com/blog/2013/06/28/clojure-core-async-channels.html>
* Tim Baldrige Clojure/conj talk - <https://www.youtube.com/watch?v=enwIIGzhahw>
* Facebook's React
    * Om, Reagent, Quiescent, Reacl

## Q&A

### How do you take the small pieces and compose them together to a big application?

* Think about your events at a high level - What are the abstract events that my application is about?
* Shared language between components, delivered via channels

### What are the args the (chan) function?

* Integer (for buffer size) or buffer
* Transducer collection

With the transducers, this is probably where core.async makes the most sense in the UI

### Are there any libraries for large components?

* with React, there are many components

### Are chan's suitable for two way binding?

* Flux is for free in CLJS
* Transducers are the stream processing

### Use node to render template server side?

Embedded fast java runtime in Java 8 Nashorn?

### Can you monitor channel buffers?

No, you can't.  They're purposely opaque.  You'll end up with concurrency bugs.

### Channel comprehensions?

Multiple transformations in a channel or one per transformation.

You can send channels over channels. Look at Golang for inspiration.

## Closing comments

This is the start of a series of more talks, about Transit and other things.
