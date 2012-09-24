
# If not running interactively, don't do anything
[ -z "$PS1" ] && return


use_color=true

export EDITOR=vim

#Laptop swap between monitors
alias dm="xrandr --output VGA-0 --mode 1920x1080 --pos 1280x0 --output LVDS-0 --mode 1280x800 --pos 0x500"
alias sm="xrandr --output VGA-0 --off --output LVDS-0 --mode 1280x800"
