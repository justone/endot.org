---
layout: page
title: "Talk Notes: Software Architecture using ZeroMQ"
date: 2014-03-07 16:00
comments: true
sharing: true
footer: true
tags:
- notes
---

# Summary

    Title: Software Architecture using ZeroMQ
    Conference: Strange Loop 2012
    Speaker: Pieter Hintjens
    Date: 2012-09-24

<http://www.infoq.com/presentations/Architecture-Scale-ZeroMQ>

# Notes

This talk is not about the technical details of ZeroMQ.  It will be about how to get things done with ZeroMQ.

Code is crap, or will be crap soon.  Not built for 50 years of usage.

The real hard problem in our profession is simple accuracy.

The future of code is chatting.  Code talks to other code, not isolated.  Accuracy is needed.

As programmers, we need to be chatty as well.  We need to stop looking at minor features of languages and start studying people.  Brilliant genius that's isolated is useless.

Large scale social architecture means large scale software social architecture.  Physics of software is the physics of people.

Ideas are cheat, execution is the hard part.

## How to make large scale perfect software

Key elements:

* Simplicity over functionality
* Figure out the right problems to solve
* Figuring out the real problem half the work

Strategy: solve the most urgent problem, the most minimally

* Every commit should be shippable
* Design by removing problems, don't add features

Five steps:

### Learn

Learn the language before writing

Internalize it, don't just port existing problems.

### Draw

Visualize your architecture, enabling you to see it outside of your mind

### Divide

Create contracts between components to divide the work into smaller chunks

Good contracts enable individual components to evolve independently, so the system as a whole remains relevant.

### Conquer

Take little steps toward implementation.  Add little at a time while everything works.

Incremental improvements on a hello world program.

### Repeat

Keep going until you run out of money.

## Specs

Protocols are contracts.  Distributed systems live and die on protocols.

Unprotocol:

* Minutes to explain
* Hours to design
* Days to write
* Weeks to prove
* Months to mature
* Years to replace

License specs with GPLv3, remixability is freedom, freedom to survive.  AMQP is an example of a dead spec.

### Serializations

If you're willing to give up flexibility for speed then you deserve neither.

Cheap for low volume control commands: use text, like json/xml/http headers
High volume data: use hand-coded binary

0MQ framing is a lousing codec but a great separator, could put cheap and high volume data in same message.

Hand-crafting a codec will be faster than using a library, but generating a codec will be better than hand coding.

## File transfer

Perennial problem in distributed applications is file transfer.

Key socket in any 0MQ engine is router sockets.

* Solution 1: send all data after request, ends in running out of memory on one side or the other
* Solution 2: synchronize request/send, ends up being too chatty
* Solution 3: credit based flow control.  data is only sent when credit is given. pipeline the requests and when you get a new chunk of data, send another request, ends in appropriately full pipeline and simple transfer.  Works because: Request/reply is just a vulgar subclass of publish/subscribe.

Credit based flow control.  

Heartbeats are a way of asking if we still care.

* Subscriber needs to know if publisher is still alive.  Lets them know to switch to a different publisher.
* Bi-directional needs ping-pong heart beat, only respond when you have something.

## Protocol stack

Message codec (take message off the wire) and protocol engine (do something with the messages)

Now what about the engine?  State machines are a perfect domain language for protocol engines.

![](state_machines.png)

Generating a state machine is better than writing from scratch.

## Security

* Bi-directional protocols use SASL
* One-way protocols use AES and it's ilk

SASL: all about challenge/response

## FileMQ

File sharing protocol over 0MQ

# Questions

## What is the problem with AMQP?

* No distinction between cheap and fast protocol, all binary
* Strange messaging, slow

## What of the java port of 0MQ?

It's awesome, and the guy who did it is crazy, but brilliant.

## Discovery? Failover?

Discovery depends on infra:

* UDP broadcast for small controlled network
* Central mediation point for larger networks

Failover is complex, depends on what part of the system is failing.  Making brokers simpler makes things easier.

## Crossroads IO vs 0MQ?

Former is a fork of the latter.  The community is different and that's all that matters.

He documents the contracts of the community.  Others handle the code.

As they removed the dominant ego from the process, contributions got better.  Because people were wholly responsible for the quality of their code.  They owned it.

* Crossroads: Vision was to make a product
* 0MQ: Vision is to solve certain problems

# Links

* [FileMQ protocol](http://rfc.zeromq.org/spec:19)
* [FileMQ github](https://github.com/zeromq/filemq)
* [0MQ guide](http://zguide.zeromq.org/page:all)
* [0MQ books](http://zeromq.org/intro:books)

