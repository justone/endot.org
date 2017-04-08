---
layout: post
title: "outputdiff: easily spot differences in command output"
date: 2017-04-08 20:45:22 +0000
comments: true
categories: 
- Computers
- CLI
---

When I'm in front of a computer, I spend much of my time at the command line,
logged into various systems, running commands.

Now, there are two basic categories of commands:

1. Commands that change - install a package, add a firewall rule, restart a service
2. Commands that report - list installed packages, list firewall rules, list running services

This post is about making the second category of commands more useful.  Quite
often, those commands have copious amounts of output.  This is usually fine,
but sometimes, I just want to see how the output has changed, because that
indicates a change in the state of the system.

## Firewall changes with Puppet

Not very long ago, I would manage firewall rules with Puppet, and I usually
wanted to see if my code change had the correct effect on the system.  Here's
what I used to do:

```
$ iptables -L -n > before.txt
$ sudo puppet agent ...
$ iptables -L -n > after.txt
$ diff before.txt after.txt
```

This turned out to be a very effective way of determining if my intended
changes had been applied, because the diff only shows changes and I didn't have
to hunt through dozens of lines of output.  It also helped me see if my puppet
run inadvertently removed a firewall rule that I didn't want to remove.

The problem was that I would end up with `before.txt` and `after.txt` files
lying around. I also invariably would need to do another puppet run, so I'd end
up with `after2.txt` and so on.

## Itch scratched

So, I wrote [outputdiff](https://github.com/justone/outputdiff).  Outputdiff
takes the output of your command and uses git to maintain a history of changes.
With output diff, the above turns into this:

```
$ iptables -L -n | outputdiff --new
$ sudo puppet agent ...
$ iptables -L -n | outputdiff --compare
```

Upon running that third command, either a diff or a message indicating there is
no change would show.  No temporary files are created, and if I make another
change, I simply re-run the compare command again to see what changed.

I also created several aliases to make using outputdiff easier (and because I'm
lazy):

```
alias odn="outputdiff --new"
alias odc="outputdiff --compare"
alias odv="outputdiff --compare --no-diff && outputdiff --last --vimdiff"
alias odu="outputdiff --undo"
```

Now, all I need to do to start a comparison is append `| odn` or `| odc` to
a command to start or add a new comparison.

## Other use cases

Once I had outputdiff in my tool belt, I started finding uses for it everywhere:

* Check two different generated CloudFormation JSON documents to make sure my generating code is properly triggered
* Check differences in contents of two zip files to ensure a new file is present
* Check for updates in the output of a large `aws` CLI call to see if a database snapshot is complete

I use outputdiff all the time, and I find it incredibly useful.

Enjoy.
