GITDIR=${BASH_SOURCE%/*}

# pull the latest copy of the files
cd $GITDIR
git pull origin master
cd -

# source the files
. $GITDIR/bashrc
