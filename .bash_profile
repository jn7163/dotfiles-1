# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ $(tty) == /dev/tty1 ]; then
    mpd &
fi

#if which mpd > /dev/null; then
#    mpd --kill
#    mpd &
#fi

export PATH=$PATH:$HOME/Bash

complete -cf sudo
[[ -f /etc/profile.d/bash-completion.sh ]] && source /etc/profile.d/bash-completion.sh
