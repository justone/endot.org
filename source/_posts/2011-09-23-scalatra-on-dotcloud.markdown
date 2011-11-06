---
author: nate
date: '2011-09-23 17:24:56'
layout: post
slug: scalatra-on-dotcloud
status: publish
title: Scalatra on Dotcloud
wordpress_id: '274'
categories:
- Misc
---

I couldn't easily find information on this, so here's a summary for those that go after me.

A working example is in the <a href="https://github.com/justone/sbt-scalatra-example/tree/sbt-scalatra-on-dotcloud">sbt-scalatra-on-dotcloud branch</a> of my fork of my friend's <a href="https://github.com/christoph-neumann/sbt-scalatra-example">sbt-scalatra-example project</a>.  If it gets merged in, I'll update this post.

The sbt-scalatra-example project combines two great technologies.  The first is <a href="http://www.scalatra.org/">Scalatra</a>, a super light-weight web framework for <a href="http://www.scala-lang.org/">Scala</a> that's modeled after Ruby's <a href="http://www.sinatrarb.com/">Sinatra</a>.  The second is the <a href="https://github.com/harrah/xsbt">simple-build-tool</a> (sbt), a tool for building Scala applications that's more like rake (config file written in real programming language) than make or ant/maven (config file written in an abstract form).  I was able to run the example, but I wanted to try out deploying to <a href="https://www.dotcloud.com/">dotcloud</a>, and doing that requires a war file (according to the <a href="http://docs.dotcloud.com/services/java/">java service documentation</a>).

The biggest thing I had to figure out is that as of version 0.10 of sbt, <a href="https://github.com/harrah/xsbt/wiki/Migrating-from-SBT-0.7.x-to-0.10.x">web application support is now</a> in the <a href="https://github.com/siasia/xsbt-web-plugin">xsbt-web-plugin</a> plugin.  Just knowing that would have saved me an hour this morning. Setting that up and tweaking a few other files means I can now do this:

``` plain
$ sbt clean package-war
... snip ...
[info] Packaging /home/user/sbt-scalatra-example/target/scala-2.9.1.final/sbt-scalatra-example.war ...
[info] Done packaging.
[success] Total time: 13 s, completed Sep 23, 2011 3:57:00 PM

$ cp target/scala-2.9.1.final/sbt-scalatra-example.war dotcloud/ROOT.war

$ dotcloud create sbtscalatra
Created application "sbtscalatra"

$ cd dotcloud && dotcloud push sbtscalatra
... snip ...
Deployment finished. Your application is available at the following URLs
www: http://sbtscalatra-xxx.dotcloud.com/
```

Of course, this assumes you've installed sbt (brew install sbt on the mac) and signed up and configured Dotcloud.

Have fun.