---
layout: post
title: "Git subtree tracking made easy"
date: 2012-02-12 16:33
comments: true
categories: 
- Code
- Computers
- dfm
---

Last year, when I made my [list of pros and cons comparing git subtrees with submodules](/2011/05/18/git-submodules-vs-subtrees-for-vim-plugins/), one of the downsides listed for subtrees was that it's hard to figure out where the code came from originally.

Well, it seems that the internet hasn't been sitting on its hands.  While the main repository remained stable, a [couple](https://github.com/matthoffman/git-subtree) [forks](https://github.com/bibendi/git-subtree) took it upon themselves to teach git-subtree to keep a record of what it merges in a `.gittrees` file.  When a subtree is added, something like the following is added to the file:

```
[subtree "bin/remotecopy"]
    url = git@github.com:justone/remotecopy.git
    path = bin/remotecopy
    branch = master
```

I created [my own fork](https://github.com/justone/git-subtree) and merged in those ones as well as adding the [ability to prune stale entries](https://github.com/justone/git-subtree/commit/84185583ccabc97da7627a5fd2e01c32ea4c0965).

The next task was finding all the subtrees in my dotfiles repository and adding entries like the one above.  Here's the shell script I used:

``` sh
#!/bin/sh

# for each path that was subtree merged
for path in `git log --grep Squashed --oneline | awk '{ print $3 }' | sort | uniq | sed "s/'//g" | sed "s/\/$//g"`; do

    # check to see if the subpath is already in .gittrees
    git config -f .gittrees subtree.$path.url &> /dev/null
    if [ $? -eq 0 ]; then
        echo "$path already configured"
    else

        # look for the most recent commit
        commit=`git log --grep "Squashed '$path/'" --oneline | head -n 1 | awk '{ print $NF }'`
        if [[ $commit =~ '..' ]]; then
            commit=`echo $commit | cut -d . -f 3`
        fi
        echo "last commit for $path is $commit";

        # ask for the git url
        echo "Enter url: "
        read URL

        # record the subtree info
        git config -f .gittrees --unset subtree.$path.url
        git config -f .gittrees --add subtree.$path.url $URL
        git config -f .gittrees --unset subtree.$path.path
        git config -f .gittrees --add subtree.$path.path $path
        git config -f .gittrees --unset subtree.$path.branch
        git config -f .gittrees --add subtree.$path.branch master
    fi

    echo "------------------------------"
done
```

When run, it finds any subtrees that have been squashed in and shows the path and the last short commit id.  For instance:

``` plain
$ sh ../subtree_commits.sh 
last commit for .vim/bundle/tabular is b7b4d87
Enter url: 

```

Then all I had to do was find the right git repository online and paste the url in.  I usually accomplished this by searching for `github [pluginname]` and then appending `/commit/[short sha1]` to the url to see if the commit existed.  For instance, looking for `github tabular` led me to [https://github.com/godlygeek/tabular](https://github.com/godlygeek/tabular), and appending [/commit/b7b4d87](https://github.com/godlygeek/tabular/commit/b7b4d87) shows that the commit exists in that repository, so it's likely the right one.  For the plugins that aren't hosted by their authors on github or elsewhere, the [vim-scripts](https://github.com/vim-scripts) mirror was usually where I ended up.  The script can be run multiple times, it skips any subtrees that already have entries in `.gittrees`.

After running the script for a while, and searching for all the home repositories for my subtrees, I ended up with [this .gittrees file](https://github.com/justone/dotfiles/blob/personal/.gittrees).

Now, if I want to list my subtrees:

``` plain
$ dfm subtree list
    bin/git-subtree        (merged from https://github.com/justone/git-subtree.git branch master) 
    bin/remotecopy        (merged from git@github.com:justone/remotecopy.git branch master) 
    .bashrc.d/resty        (merged from https://github.com/micha/resty.git branch master) 
    .bashrc.d/z        (merged from https://github.com/rupa/z.git branch master) 
    .vim/bundle/AutoTag        (merged from https://github.com/vim-scripts/AutoTag.git branch master) 
    .vim/bundle/FuzzyFinder        (merged from https://github.com/vim-scripts/FuzzyFinder.git branch master) 
    .vim/bundle/L9        (merged from https://github.com/vim-scripts/L9.git branch master) 
    .vim/bundle/ack        (merged from https://github.com/mileszs/ack.vim.git branch master) 
    .vim/bundle/bufexplorer        (merged from https://github.com/vim-scripts/bufexplorer.zip.git branch master) 
    .vim/bundle/bufkill        (merged from https://github.com/vim-scripts/bufkill.vim.git branch master) 
    .vim/bundle/conque-shell        (merged from https://github.com/vim-scripts/Conque-Shell.git branch master) 
    .vim/bundle/gundo        (merged from https://github.com/sjl/gundo.vim.git branch master) 
    .vim/bundle/regbuf        (merged from https://github.com/tyru/regbuf.vim.git branch master) 
    .vim/bundle/syntastic        (merged from https://github.com/scrooloose/syntastic.git branch master) 
    .vim/bundle/tabular        (merged from https://github.com/godlygeek/tabular.git branch master) 
    .vim/bundle/taglist        (merged from https://github.com/vim-scripts/taglist.vim.git branch master) 
    .vim/bundle/ultisnips        (merged from https://github.com/SirVer/ultisnips.git branch master) 
    .vim/bundle/vcscommand        (merged from git://repo.or.cz/vcscommand.git branch master) 
    .vim/bundle/vim-colors-solarized        (merged from https://github.com/altercation/vim-colors-solarized.git branch master) 
    .vim/bundle/vim-fugitive        (merged from https://github.com/tpope/vim-fugitive.git branch master) 
    .vim/bundle/vim-markdown-preview        (merged from https://github.com/robgleeson/hammer.vim.git branch master) 
    .vim/bundle/vim-octopress        (merged from https://github.com/tangledhelix/vim-octopress.git branch master) 
    .vim/bundle/vim-r        (merged from https://github.com/jcfaria/Vim-R-plugin.git branch master) 
    .vim/bundle/vim-speeddating        (merged from https://github.com/tpope/vim-speeddating.git branch master) 
    .vim/bundle/vim-unimpaired        (merged from https://github.com/tpope/vim-unimpaired.git branch master) 
```

And to update a particular subtree:

``` plain
$ dfm subtree pull -P .bashrc.d/z --squash
From https://github.com/rupa/z
 * branch            master     -> FETCH_HEAD
git fetch using:  https://github.com/rupa/z.git master
Merge made by recursive.
 .bashrc.d/z/z.sh |   49 +++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 43 insertions(+), 6 deletions(-)
```

Alright, that's all I have time for today.  Enjoy.
