
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

use_color=true

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Add to to history after each command
export PROMPT_COMMAND="history -a"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000000
HISTFILESIZE=20000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# 日本語の"　"（u+3000） -> " "
bind '"\343\200\200":" "'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# add ~/bin to path if exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
    export PATH
fi

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    if [[ $EUID -ne 0 ]]; then
        COL="32m" # Green
    else
        COL="31m" # Red
    fi
    # Runs before display of prompt. find_git_branch sets the $git_branch
    # variable.
    PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;$COL\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \[\033[38;5;81m\]\$git_branch\[\033[01;34m\]\$\[\033[00m\] "
else
    PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls="ls --color=auto"
    #alias dir="dir --color=auto"
    #alias vdir="vdir --color=auto"

    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"
fi

#Number of make jobs = number of processors
#export MAKEFLAGS="-j"$(grep -c ^processor /proc/cpuinfo)

#Turn off bash hashing
set +h

export EDITOR=vim
export VISUAL=vim

#Rsync aliases
alias rsynccopy="rsync --partial --progress --append --rsh=ssh -r -h "
alias rsyncmove="rsync --partial --progress --append --rsh=ssh -r -h --remove-sent-files"

alias :q="exit"

alias tmux="tmux attach || tmux new"

function command_exists()
{
    type "$1" &> /dev/null ;
}

function find_git_branch() {
    git_branch=""
    if command_exists git; then
        local branch
        if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
            if [[ "$branch" == "HEAD" ]]; then
                branch="detached* "
            fi
            local status=$(git status --porcelain 2> /dev/null)
            if [[ "$status" != "" ]]; then
                local dirty="*"
            else
                local dirty=""
            fi
            git_branch="($branch$dirty) "
        fi
    fi
}

#-------------------------------------------------------------
# Greeting, motd etc...
#-------------------------------------------------------------

function _exit()        # Function to run upon exit of shell.
{
    echo -e "${RED}Bye bye :'(${NC}"
}

if [[ $EUID -ne 0 ]]; then
    trap _exit EXIT
fi

#-------------------------------------------------------------
# Utilities
#-------------------------------------------------------------

function extract()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   echo "tar xjf $1" ; tar xvjf $1 > /dev/null        ;;
             *.tar.gz)    echo "tar xzf $1" ; tar xvzf $1 > /dev/null        ;;
             *.tar.xz)    echo "tar xJf $1" ; tar xvJf $1 > /dev/null        ;;
             *.bz2)       echo "bunzip2 $1  &" ; bunzip2 $1  > /dev/null     ;;
             *.rar)       echo "unrar x $1" ; unrar x $1 > /dev/null         ;;
             *.gz)        echo "gunzip $1 &" ; gunzip $1 > /dev/null         ;;
             *.tar)       echo "tar xf $1" ; tar xvf $1 > /dev/null          ;;
             *.tbz2)      echo "tar xjf $1" ; tar xvjf $1 > /dev/null        ;;
             *.tgz)       echo "tar xzf $1" ; tar xvzf $1 > /dev/null        ;;
             *.zip)       echo "unzip $1 &" ; unzip $1 > /dev/null           ;;
             *.Z)         echo "uncompress $1 &" ; uncompress $1 > /dev/null ;;
             *.7z)        echo "7z x $1" ; 7z x $1 > /dev/null               ;;
#             *.deb)       echo "ar vx $1" ; ar vx $1                         ;;
             *)           echo "'$1' cannot be extracted via >extract<"      ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

function interwebs()
{
    if command_exists google-chrome; then
        google-chrome &> /dev/null
    elif command_exists chromium-browser; then
        chromium-browser &> /dev/null
    elif command_exists python; then
        python -mwebbrowser http://www.google.com/ &> /dev/null
    else
        echo "python not installed"
    fi
}

#install a program
function i()
{
    if [ $# -ne 1 ]; then
        echo "please specify a program to install"
    else
        if [ -f /etc/redhat-release ]; then
            sudo yum install $@
        elif [ -f /etc/debian_version ]; then
            if command_exists apt; then
                sudo apt install $@
            else
                sudo apt-get install $@
            fi
        else
            echo "package manager not supported"
        fi
    fi
}

function opdf()
{
    if [ -f $1 ] ; then
        `evince $1 &> /dev/null` &
    else
        echo "'$1' is not a valid file"
    fi
}

function shutdownin()
{
    if [ $# -ne 1 ]; then
        echo "please spicify a time in minutes to delay shutdown"
    else
        sudo shutdown -h +$1
    fi
}

