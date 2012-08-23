---
layout: post
title: "Host-specific bash configuration"
date: 2012-08-22 21:08
comments: true
categories: 
- dfm
- Code
---

Well, I was going to write about a nifty bit of bash to help with ssh-agent in tmux, but [someone beat me to it](http://naydichev.com/blog/2012/08/22/beating-nate-to-the-punch/), so I'll just write up his idea instead.

Every once in a while, it's nice to have a bit of bash initialization that only runs on one system.  You could just throw that at the end of the .bashrc for that system, but that's not very persistent.  It would be better to have, in the spirit of [dotjs](https://github.com/defunkt/dotjs), a directory where you drop files with the same name as the host and they get run.

So, here's a bit of bash initialization that does that and a bit more.

```
HN=$( hostname -f )
HOST_DIR=$HOME/.bashrc.d/host.d

# split hostname
HN_PARTS=($(echo $HN | tr "." "\n"))

TEST_DOMAIN_NAME=
for (( c = ${#HN_PARTS[@]}; c--; c == 0 )); do
    if [[ -z $TEST_DOMAIN_NAME ]]; then
        TEST_DOMAIN_NAME="${HN_PARTS[$c]}"
    else
        TEST_DOMAIN_NAME="${HN_PARTS[$c]}.$TEST_DOMAIN_NAME"
    fi

    if [[ -f $HOST_DIR/$TEST_DOMAIN_NAME ]]; then
        source $HOST_DIR/$TEST_DOMAIN_NAME
    elif [[ -d $HOST_DIR/$TEST_DOMAIN_NAME ]]; then
        for file in $HOST_DIR/$TEST_DOMAIN_NAME/*; do
            source $file
        done
    fi
done
```

One additional bit is that it uses successively longer segments of the hostname, so for the hostname `foo.bar.domain.com`, the following names are checked, in order: `com`, `domain.com`, `bar.domain.com`, `foo.bar.domain.com`.  Doing this means that domain-specific initialization is easy and that more specific filenames can override their general counterparts.

The other extra is that if the name exists as a directory, all the files in that directory are sourced.  So the full list of checked locations for the above hostname would be:

* com
* com/\*
* domain.com
* domain.com/\*
* bar.domain.com
* bar.domain.com/\*
* foo.bar.domain.com
* foo.bar.domain.com/\*

It works pretty well, but I'm sure it could be better written.  I'm not very proficient with bash, so if you have any suggestions for improving it, let me know.

Enjoy.
