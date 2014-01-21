---
layout: post
title: "Using Docker to generate my Octopress blog"
date: 2014-01-20 15:09:14 +0000
comments: true
categories: 
- Computers
- docker
- Blog
---

When I originally [set up Octopress](/2011/11/05/wordpress-to-octopress/), I set it up on my Mac laptop using rvm, as recommended at the time.  It worked very well for me until just a few minutes after my last post, when I decided to sync with the upstream changes.

After merging in the changes, I tried to generate my blog again, just to make sure everything worked.  Well, it didn't, and things went downhill from there.  The `rake generate` command failed because a new gem was required.  So, I ran `bundle install` to get the latest gems.  That failed when a gem required ruby 1.9.3.  Then installing ruby 1.9.3 failed in rvm because I needed a newer version of rvm.  After banging on that problem for a few minutes, I decided to take a break and come back to the problem later.

## Docker to the rescue

Fast forward a few weeks, and I came up with a better idea.  I decided to dockerize Octopress.  This keeps all the dependencies sanely bottled up in an image that I can run like a command.

Here is the code:

```
FROM ubuntu:12.10
MAINTAINER  Nate Jones <nate@endot.org>

# instal system dependencies and ruby
RUN apt-get update
RUN apt-get install git ruby1.9.3 build-essential language-pack-en python python-dev -y

# make sure we're working in UTF8
ENV LC_ALL en_US.utf8

# add the current blog source
ADD . /o
WORKDIR /o

# install octopress dependencies
RUN gem install bundler
RUN bundle install

# set up user so that host files have correct ownership
RUN addgroup --gid 1000 blog
RUN adduser --uid 1000 --gid 1000 blog
RUN chown -R blog.blog /o
USER blog

# base command
ENTRYPOINT ["rake"]
```

## How to use it

To use this [Dockerfile](https://github.com/justone/endot.org/blob/master/Dockerfile), I put it at the root of my [blog source](https://github.com/justone/endot.org) and ran this command:

``` sh
$ docker build -t ndj/octodock .
```

Then, since rake is set as the entry point, I can run the image as if it were a command.  I use the `-v` switch to overlay the current blog source over the one cached in the image and `-rm` switch to throw away the container when it's done.

``` sh
$ docker run -rm -v `pwd`:/o ndj/octodock generate
## Generating Site with Jekyll
   remove .sass-cache/
   remove source/stylesheets/screen.css
   create source/stylesheets/screen.css
Configuration from /o/_config.yml
Building site: source -> public
Successfully generated site: source -> public
```

## A few notes

* I had to force the UTF8 locale in order to get ruby to stop complaining about non-ascii characters in the blog entries.
* I add a user called blog with the same UID/GID as my system user, so that any commands that generate files aren't owned by root.  I look forward to proper user namespaces so that I won't have to do this.
* Deploying the blog doesn't use my SSH key, as the 'blog' user in the image is doing the rsync, not my host system user.  I'm ok with typing my password in or just rsync'ing the data directly.

Docker is a great piece of technology, and I keep finding new uses for it.

Enjoy.
