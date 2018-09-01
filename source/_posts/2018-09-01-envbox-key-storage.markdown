---
layout: post
title: "Envbox: Secure Key Storage"
date: 2018-09-01 13:04:08 -0700
comments: true
categories:
- CLI
- Computers
---

I wrote a few months ago about [envbox](https://github.com/justone/envbox), and
I can say that it has proved useful to me many times over.

One thing that felt unfinished was the way that envbox stores the key that it
uses to encrypt all of the environment variables.  It did move the problem from
the shell/history to one of system security, which was acceptable.  But there
are better ways of storing credentials on most systems.

Each of the major operating systems out there has a native store for secrets
and other credentials.  They unlock the store when you log in and make those
secrets available to other programs.  The primary difficulty is writing code to
support all those native stores.

Thankfully, the Docker project created
[docker-credential-helpers](https://github.com/docker/docker-credential-helpers),
which does just that. It has a set of helper programs that you can call from
any application to store and retrieve credentials.

There is a bit of ceremony around detecting the right helper for the current
system, so I wrote a little library called
[crocker](https://github.com/justone/crocker) to help with that.

And today, I integrated that into envbox.  What that means is that envbox
doesn't have to store it's key in a plaintext file anymore.  That will remain
the default way of operating, but all you need to do to use the native store is
to download the appropriate helper from the
[docker-credential-helpers releases](https://github.com/docker/docker-credential-helpers/releases)
and put it in your path and envbox will use it [^1].

Enjoy.

[^1]: This has not been thoroughly tested on Windows.
