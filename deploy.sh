#!/bin/sh

rsync -avze 'ssh -p 22' public/ endot.org@endot.org:~/domains/endot.org/html/
