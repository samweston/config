
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

use_color=true

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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

export EDITOR=vim

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

alias gca="git commit -a"
alias gcam="git commit -a -m" 

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
echo -e "${Yellow}"`vim --version | head -n 1 | sed 's/([^-]*$//'`"${NC}\n"
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
             *.tar.bz2)   echo "tar xvjf $1" ; tar xvjf $1 > /dev/null       ;;
             *.tar.gz)    echo "tar xvzf $1" ; tar xvzf $1 > /dev/null       ;;
             *.bz2)       echo "bunzip2 $1  &" ; bunzip2 $1  > /dev/null     ;;
             *.rar)       echo "unrar x $1" ; unrar x $1 > /dev/null         ;;
             *.gz)        echo "gunzip $1 &" ; gunzip $1 > /dev/null         ;;
             *.tar)       echo "tar xvf $1" ; tar xvf $1 > /dev/null         ;;
             *.tbz2)      echo "tar xvjf $1" ; tar xvjf $1 > /dev/null       ;;
             *.tgz)       echo "tar xvzf $1" ; tar xvzf $1 > /dev/null       ;;
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
	if [ $(which google-chrome) ]; then
		`google-chrome &> /dev/null` &
	else
		echo "PMG no chromes!"
		browser="$(which firefox || which opera || which arora)"
		`$browser &> /dev/null` &
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

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
    echo -e "\n${RED}Open connections :$NC "; netstat -pan --inet;
    echo
}

function screen_saver() {
	echo "woo"
	while :; do sl; done
}

function s_timeout()
{
	echo $$ > ~/log/screen_lock.pid
	sleep 10
	screen_saver
}
function s_timeout_reset()
{
	PID=$(<~/log/screen_lock.pid)
	if [ ! -z "$PID" ]
	then
		kill "$PID"
	fi
	s_timeout &
}

function gr()
{
    if [ "$#" == "1" ]
    then
        grep -r $* .
    elif [ "$#" -ge "2" ]
    then
        grep -r $*
    else
        echo ">.<"
    fi
}

#if [ $(which sl) ]; then
#	mkdir -p ~/log
#	if [ ! -f ~/log/screen_lock.pid ]
#	then
#		touch ~/log/screen_lock.pid
#	fi
#	PROMPT_COMMAND=s_timeout_reset
#fi


#Following commands require bash 3
if [ "${BASH_VERSION%.*}" \< "3.0" ]; then
    echo "You will need to upgrade to version 3.0 \
for full programmable completion features."
    return
fi


