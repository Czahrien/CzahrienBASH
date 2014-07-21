# If you insist on running this script directly, it will only work if run
# one of the following ways:
# $ . source_all_files.sh
# $ source source_all_files.sh

# we only really care about this stuff if we have an interactive terminal
tty > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    GITDIR=$(readlink -f $(dirname ${BASH_SOURCE}))

# pull the latest copy of the files if this is a login shell
if shopt -q login_shell; then
    ( cd $GITDIR; git pull origin master )
fi

# source the files
    . $GITDIR/bashrc
    . $GITDIR/funcs
    . $GITDIR/aliases

# source a machine-specific file
    [[ -e $GITDIR/bashrc_$HOSTNAME ]] && . $GITDIR/bashrc_$HOSTNAME
    [[ -e $GITDIR/project_$HOSTNAME ]] && . $GITDIR/project_$HOSTNAME
    [[ -e $GITDIR/project_${HOSTNAME%%.*} ]] && . $GITDIR/project_${HOSTNAME%%.*}

# make links to resource files
    FILES=( $GITDIR/resource_* )
    for file in "${FILES[@]}"; do
        if [[ ! -e ~/${file#*/resource_} ]]; then
            echo No ${file#*/resource_} present in $HOME. Creating symbolic link to $file
            ln -s $file ~/${file#*/resource_}
        fi
    done
fi
