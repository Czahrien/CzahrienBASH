GITDIR=$(readlink -f $(dirname ${BASH_SOURCE}))

# pull the latest copy of the files
cd $GITDIR
git pull origin master
cd - > /dev/null

# source the files
. $GITDIR/bashrc
. $GITDIR/funcs
. $GITDIR/aliases

# source a machine-specific file
if [[ -e $GITDIR/bashrc_$HOSTNAME ]]; then
    . $GITDIR/bashrc_$HOSTNAME
fi

#make links to resource file.
for file in $(ls $GITDIR/resource_* 2> /dev/null); do
  if [[ ! -e ~/${file#*/resource_} ]]; then
    echo No ${file#*/resource_} present in $HOME. Creating a link to $file.
    ln -s $file ~/${file#*/resource_}
  fi
done
