# Set the editor to something that does not suck
EDITOR=vi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# ** matches all files and zero or more directories
shopt -s globstar
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# Setup tty-specific history files
ttyname=$(tty)  # set up separate history files for each login
HISTFILE=$HOME/.sh_history/$(date +%m%d%Y).${ttyname##*/}

# Setup a machine specific bin directory in the search path
if [[ -a "$(which uname)" ]]; then
    PATH=$PATH:$HOME/mach_bin/$(uname -s)/$(uname -m)
fi


#set some extra search paths
PATH=$PATH:$HOME/bin:$HOME/scripts

# aliases
alias rm='rm -I'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'

# custom stuff
set -o vi

# Magical prompts

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm) color_prompt=yes;;
    xterm-color) color_prompt=yes;;
esac

function parse_git_branch {
    git_status="$(git status 2> /dev/null)"
    branch_pattern="^# On branch ([^${IFS}]*)"
    remote_pattern="# Your branch is (.*) of"
    diverge_pattern="# Your branch and (.*) have diverged"
    if [[ ! ${git_status} =~ "working directory clean" ]]; then
        state="${RED}*"
    fi

    if [[ ${git_status} =~ ${remote_pattern} ]]; then
        if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
            remote="↑"
        else
            remote="↓"
        fi
    fi
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
        remote="↕"
    fi
    if [[ ${git_status} =~ ${branch_pattern} ]]; then
        branch=${BASH_REMATCH[1]}
        echo " ${YELLOW}(${branch})${remote}${state}${COLOR_NONE}"
    fi
}

EXIT_CODE[0]='SUCCESS'
EXIT_CODE[1]='FAIL'
EXIT_CODE[2]='MISUSE'
EXIT_CODE[127]='CMD_NOT_FOUND'
EXIT_CODE[128]='INVALID_EXIT'
EXIT_CODE[255]='EXIT_OUT_OF_RANGE'

# extract system defined exit statuses from /usr/include/sysexits.h
. <(grep "#define EX_[^_]" /usr/include/sysexits.h | awk '{ print "EXIT_CODE[" $3 "]="$2 }')
# extract signals from kill -l and create exit statuses out of them
. <(kill -l | tr '\t' '\n' | awk '{ if(NF==2) print "EXIT_CODE[" ($1+128) "]=" $2 }')


function parse_exit_status {
    if [[ $1 != 0 ]]; then
        if [[ -n ${EXIT_CODE[$1]} ]];
        then
            echo " ${RED}($1:${EXIT_CODE[$1]})${COLOR_NONE}"
        else
            echo " ${RED}($1)${COLOR_NONE}"
        fi
    else
        echo "${COLOR_NONE}"
    fi
}

function prompt_func()
{
    EXIT_STATUS=$?
    PS1="${WHITE}[${LIGHT_BLUE}\\u${WHITE}@${LIGHT_YELLOW}\\h${WHITE}]:${RED}\\w$(parse_git_branch)$(parse_exit_status ${EXIT_STATUS})\\$ "
}

if [[ -n $color_prompt ]]; then
    RED="\[\033[0;31m\]"
    YELLOW="\[\033[0;33m\]"
    LIGHT_YELLOW="\[\033[1;33m\]"
    GREEN="\[\033[0;32m\]"
    BLUE="\[\033[0;34m\]"
    LIGHT_BLUE="\[\033[1;34m\]"
    LIGHT_RED="\[\033[1;31m\]"
    LIGHT_GREEN="\[\033[1;32m\]"
    WHITE="\[\033[1;37m\]"
    LIGHT_GRAY="\[\033[0;37m\]"
    COLOR_NONE="\[\e[0m\]"
fi

unset color_prompt force_color_prompt

PROMPT_COMMAND=prompt_func
