#!/bin/sh

alias dit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# attempt to checkout
if dit checkout
then
    echo "Checked out dotfiles.";
else
    echo "Backing up pre-existing dot files.";

    # make backup directory and store already existing files there
    mkdir .dotfiles-backup
    filepaths=$(dit checkout 2>&1 | egrep '^\s+\.' | sed -r 's/^\s+//')
    echo "$filepaths" |
    while read $filepath
    do
        if ! mv "$filepath" ".dotfiles-backup/$filepath"
        then
            # unsucessful move -> directories in path
            dirs="$filepath"
            while echo "$dirs" egrep '.*/'
            do
                # get path in "path/to/dir/filename"
                $make_dir=$(sed -r 's/([^/]*)\//\1/')
                # set remaining dirs to make as "to/dir/filename"
                $dirs=$(sed -r 's/[^/]*\///')
            done
            mv "$filepath" ".dotfiles-backup/$filepath"
        fi
    done

    # re-checkout after backing up files
    dit checkout
fi

dit config status.showUntrackedFiles no
