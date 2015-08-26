
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
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;$COL\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] "
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

#Make cross compiler tools easier to reach
alias agcc="arm-linux-gnueabi-gcc"
alias aobjdump="arm-linux-gnueabi-objdump"

alias compress="tar czvf out.tar.gz" #<inputs>

alias svim="vim"

alias v="vim"
alias :e="vim"
alias vs="vim -S"

alias :q="exit"

alias gca="git commit -a"
alias gcam="git commit -a -m"

alias tmux="tmux attach || tmux new"

#remove dead sym links
alias rmdeadln="find -L -type l -delete"

function command_exists()
{
    type "$1" &> /dev/null ;
}

#-------------------------------------------------------------
# Greeting, motd etc...
#-------------------------------------------------------------



if [[ $EUID -ne 0 ]]; then
    # Define some colors first:
    # TODO work out the proper way of setting OSX terminal colours.
    if [[ `uname` == 'Darwin' ]]; then
        RED=''
        GREEN=''
        YELLOW=''
        BLUE=''
        CYAN=''
        NC=''              # No Color
    else
        RED='\e[1;31m'
        GREEN='\e[0;32m'
        YELLOW='\e[0;33m'
        BLUE='\e[1;34m'
        CYAN='\e[1;36m'
        NC='\e[0m'              # No Color
    fi

    GA='`'
    echo -e "$GREEN                    ${RED}   (__)    )"
    echo -e "$GREEN                    ${RED}   (${BLUE}..$RED)   /|\\"
    echo -e "$GREEN    ____            ${RED}  (${YELLOW}o${RED}_${YELLOW}o${RED})  / | \\"
    echo -e "$GREEN   / __/__ ___ _    ${RED}  ___) \/,-|,-\\"
    echo -e "$GREEN  _\ \/ _ $GA/  ' \\\\${RED}   //,-/_\ )  '  '"
    echo -e "$GREEN /___/\_,_/_/_/_/   ${RED}   (//,-'\\"
    echo -e "$GREEN                    ${RED}   (  ( . \_"
    echo -e "$GREEN                    ${BLUE}gnv $RED$GA._\\\(___$GA."
    echo -e "$GREEN                    ${RED}     '---' _)/"
    echo -e "$GREEN                    ${RED}          $GA-'"

    # Looks best on a terminal with black background.....
    echo -e "${CYAN}This is BASH ${RED}${BASH_VERSION%.*}\
    ${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}"
    #Show vim version
    if command_exists vim; then
        echo -e "${YELLOW}"`vim --version | head -n 1 | sed 's/([^-]*$//'`"${NC}\n"
    else
        echo -e "${YELLOW}Oh no VIM is not installed!!${NC}"
    fi
    date
    if command_exists fortune; then
        fortune -s     # Makes our day a bit more fun.... :-)
    fi
    echo ""
fi

function _exit()        # Function to run upon exit of shell.
{
    echo -e "${RED}Bye bye :'(${NC}"
}

if [[ $EUID -ne 0 ]]; then
    trap _exit EXIT
fi

#-------------------------------------------------------------
# Programs
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
            sudo yum install $1
        elif [ -f /etc/debian_version ]; then
            sudo apt-get install $1
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

#run tmux by default
#if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ] && [ $(which tmux) ];
#then
#    tmux new; exit
#fi

#Following commands require bash 4
#if [ "${BASH_VERSION%.*}" \< "3.0" ]; then
#    echo "You will need to upgrade to version 3.0 \
#for full programmable completion features."
#    return
#fi

