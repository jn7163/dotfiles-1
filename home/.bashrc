
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS
OS=`uname`

PS() {
    case "$TERM" in
        xterm-256color)
            export GIT_PS_SHOWDIRTYSTATE=1
            export PS1='\[\e[1;36m\]→\[\e[m\] \[\e[0;32m\]\w\[\e[0;35m\]$(__git_ps1)\[\e[1;32m\] \$\[\e[m\] '
            ;;
        xterm)
            export PS1='\[\e[1;36m\]→\[\e[m\] \[\e[0;32m\]\w\[\e[0;35m\]\[\e[1;32m\] \$\[\e[m\] '
            export LANG="en_US.UTF-8"
            ;;
    esac
}

case $OS in
    Darwin)
        [[ `id -u` == "501" ]] && PS
        ;;
    Linux)
        [[ `id -u` == "1000" ]] && PS
        ;;
esac

# ccal
if [ -f /usr/bin/ccal ]; then
    tty | egrep -i "pts" > /dev/null && ccal -u
fi

# color
C_DEFAULT="\[\033[m\]"
C_BLACK="\[\033[30m\]"			# base02
C_RED="\[\033[31m\]"			# red
C_GREEN="\[\033[32m\]"			# green
C_YELLOW="\[\033[33m\]"			# yellow
C_BLUE="\[\033[34m\]"			# blue
C_MAGENTA="\[\033[35m\]"		# magenta
C_CYAN="\[\033[36m\]"			# cyan
C_WHITE="\[\033[37m\]"			# base2
C_BRBLACK="\[\033[1;30m\]"		# base03
C_BRRED="\[\033[1;31m\]"		# orange
C_BRGREEN="\[\033[1;32m\]"		# base01
C_BRYELLOW="\[\033[1;33m\]"		# base00
C_BRBLUE="\[\033[1;34m\]"		# base0
C_BRMAGENTA="\[\033[1;35m\]"	# violet
C_BRCYAN="\[\033[1;36m\]"		# base1
C_BRWHITE="\[\033[1;37m\]"		# base3
# Background colors (No bright versions, not supported :()
C_BG_BLACK="\[\033[40m\]"		# base02
C_BG_RED="\[\033[41m\]"			# red
C_BG_GREEN="\[\033[42m\]"		# green
C_BG_YELLOW="\[\033[43m\]"		# yellow
C_BG_BLUE="\[\033[44m\]"		# blue
C_BG_MAGENTA="\[\033[45m\]"		# magenta
C_BG_CYAN="\[\033[46m\]"		# cyan
C_BG_WHITE="\[\033[47m\]"		# base2
