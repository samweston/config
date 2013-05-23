
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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# add ~/bin to path if exists
if [ -d ~/bin ] ; then
	PATH=~/bin:"${PATH}"
	export PATH
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#Number of make jobs = number of processors
export MAKEFLAGS='-j'$(grep -c ^processor /proc/cpuinfo)

#set go root
export GOROOT=$HOME/Software/go

#Turn off bash hashing
set +h

export EDITOR=vim

#Rsync aliases
alias rsynccopy="rsync --partial --progress --append --rsh=ssh -r -h "
alias rsyncmove="rsync --partial --progress --append --rsh=ssh -r -h --remove-sent-files"

#Make cross compiler tools easier to reach
alias agcc="arm-linux-gnueabi-gcc"
alias aobjdump="arm-linux-gnueabi-objdump"

#Laptop swap between monitors
alias dualm="xrandr --output VGA-0 --mode 1920x1080 --pos 1280x0 --output LVDS-0 --mode 1280x800 --pos 0x600"
alias sm="xrandr --output VGA-0 --off --output LVDS-0 --mode 1280x800"

#need to turn off wireless before hibernate / suspend
alias hibernate="sudo ifconfig wlan0 down; sudo pm-hibernate"
alias suspend="sudo ifconfig wlan0 down; sudo pm-suspend"

alias compress="tar czvf out.tar.gz" #<inputs>

alias svim="vim"

alias v="vim"
alias :e="vim"
alias vs="vim -S"

alias :q="exit"

alias gca="git commit -a"
alias gcam="git commit -a -m"

#remove dead sym links
alias rmdeadln="find -L -type l -delete"

function command_exists()
{
	type "$1" &> /dev/null ;
}

#
# Colors
#

# Reset
#Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[10;95m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

#-------------------------------------------------------------
# Greeting, motd etc...
#-------------------------------------------------------------

# Define some colors first:
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'              # No Color
# --> Nice. Has the same effect as using "ansi.sys" in DOS.

echo -e "\e[1;32m"
echo -e "  ______             "
echo -e " / _____)            "
echo -e "( (____  _____ ____  "
echo -e " \____ \(____ |    \ "
echo -e " _____) ) ___ | | | |"
echo -e "(______/\_____|_|_|_|"
echo -e "${NC}"

# Looks best on a terminal with black background.....
echo -e "${CYAN}This is BASH ${RED}${BASH_VERSION%.*}\
${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}"
#Show vim version
if command_exists vim; then
	echo -e "${Yellow}"`vim --version | head -n 1 | sed 's/([^-]*$//'`"${NC}\n"
else
	echo -e "${Yellow}Oh no VIM is not installed!!${NC}"
fi
date
if [ -x /usr/games/fortune ]; then
    /usr/games/fortune -s     # Makes our day a bit more fun.... :-)
fi
echo ""

function _exit()        # Function to run upon exit of shell.
{
    echo -e "${RED}Bye bye :'(${NC}"
}
trap _exit EXIT

#-------------------------------------------------------------
# Programs
#-------------------------------------------------------------

function extract()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   echo "tar xjf $1" ; tar xvjf $1 > /dev/null        ;;
             *.tar.gz)    echo "tar xzf $1" ; tar xvzf $1 > /dev/null        ;;
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
	if command_exists chromium-browser; then
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
		echo "please specify a file"
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

#recursive inplace sed
function sri()
{
    if [ "$#" == "1" ]
    then
        find . -type f -print0 | xargs -0 sed -i "$*"
    else
        echo ">.<"
    fi
}

#recursive grep
function gr()
{
    if [ "$#" == "1" ]
    then
        grep -r "$*" .
    elif [ "$#" == "2" ]
    then
        grep -r "$1" "$2"
    else
        echo ">.<"
    fi
}

function f()
{
    if [ "$#" == "1" ]
    then
	find . -name "$1"
    else
        echo ">.<"
    fi
}

function cindent()
{
	if command_exists indent; then
		indent -linux *.c
		indent -linux *.h 2> /dev/null
		rm *~
	else
		echo "indent not found"
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


