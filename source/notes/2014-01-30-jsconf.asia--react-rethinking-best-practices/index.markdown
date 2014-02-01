---
layout: page
title: "Talk Notes: React - Rethinking Best Practices"
date: 2014-01-30 21:03
comments: true
sharing: true
footer: true
tags:
- notes
---

# Summary

    Title: React - Rethinking Best Practices
    Conference: JSConf ASIA
    Speaker: Pete Hunt
    Date: 2013-11-28

<http://www.youtube.com/watch?v=DgVS-zXgMTk> <http://www.slideshare.net/floydophone/react-preso-v2>

# Notes

Talking about React, the library that the speaker works on.

Bad reaction to it when released, but we should give it [five minutes](http://37signals.com/svn/posts/3124-give-it-five-minutes).

React is the V in MVC, for making user interfaces.  It plays well with part of your app, doesn't require a complete rewrite.

## Prerequisites

Combine DOM generation and display logic

Build components, not templates.  Mix markup and display logic.

Why not separation of concerns?  Let's deconstruct

* Coupling - how much each module depends on other modules, leads to cascading changes; we want to decrease this
* Cohesion - how much elements of a module belong together; we want to increase this

Templates (and angular directives) encourage a poor separation of concerns.  There is an implicit coupling between a template and the display logic.  They are actually highly cohesive.  They both show the UI.  Render the UI and manipulate the UI.  When you separate templates from display logic, you're separating technologies, not concerns.

Templates are underpowered.  They have limited abstractions:

* To re-use templates, you create a partial.  The problem is the coupling of that partial to the display logic, meaning you have to make sure the data is available everywhere the partial is used.
* You are limited by the non-programming nature of templates.  You can't differentiate one section programmatically because the template language isn't expressive enough.

Current approaches introduce new concepts without admitting that they are creating new programming languages.  They end up not being compatible with the language we already have: JavaScript.

The key concept is that frameworks cannot know the separation of concerns for you.  The framework should help you express your problem in the language of the problem domain, instead of the framework itself.

The base element of React is a component that combines a template and display logic into one unit.  You use components to separate your concerns.

It allows you to:

* Abstraction - to put functionality into small pieces, so that it's testable
* Composition - the ability to combine multiple components, reuse components
* Expressivity - the full power of JavaScript in your views
* Unit testable

**What about spaghetti code?**

Keep your components small, only put display logic in your components, not all the data access or other code.

**What about XSS?**

Creating UIs by concatenating strings is dangerous, right?  React.DOM provides a safe way of generating HTML.

**What about Designers?**

They don't like JavaScript.

They built JSX, an optional preprocessor to use an HTML like syntax.  Using this, designers are able to contribute.

## React's design

Re-render app on every update

State is what makes building UIs hard.  In particular, data changing over time is the _root of all evil_.  The solution is functional-reactive programming.

The analogy is refreshing the entire page, ala 1990's programming.

"React components are basically just idempotent functions"  They describe your UI at any point in time, based on the inputs.

React isolates the mutable data as much as possible.  To find where state changes, look for "setState".  Note that it's not "mutateState".  A new state is set, not changed from the old state.

By re-rendering, you avoid:

* Having to know every place that data is rendered
* Data binding
* Model dirty checking
* DOM operations

Seems expensive, right?  Throwing out the DOM loses state and scroll position.

## React's implementation

Virtual DOM and synthetic events

To avoid re-rendering issues, they created a virtual DOM

On every update:

1. Generate a new DOM subtree
2. Diff with old one
3. Compute the minimal set of operations to update real DOM
4. Batch execute the updates at the right time

A lot like a game engine.  And it's fast.

The batch execution mitigates layout thrashing. Adds events in the best way possible, so it's faster. Can do custom updates, but they're rarely used.

Can do 60fps on the non-JIT webview on iphone

Other fun things:

* Can run in Node.js - makes for really fast initial page experience
* Optimize large component changes
* Testability for free
* SVG, VML and canvas support
* Run whole app in a Web Worker

## Key takeaways

* Components, not templates
* Re-render, don't mutate
* Virtual DOM is simple and fast

One more thing.

Announcing [React devtools](http://facebook.github.io/react/blog/2014/01/02/react-chrome-developer-tools.html) - inspect the virtual DOM in inspector

## Questions

Transitions? React-transition
