GITDIR=${BASH_SOURCE%/*}

# pull the latest copy of the files
cd $GITDIR
git pull origin master
cd -

# source the files
. $GITDIR/bashrc

# source a machine-specific file
[[ -e $GITDIR/bashrc_$HOSTNAME ]] && . $GITDIR/bashrc_$HOSTNAME
