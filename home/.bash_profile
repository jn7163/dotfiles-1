# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -f ~/.bash_alias ]] && . ~/.bash_alias

if [ $(tty) == /dev/tty1 ]; then
    mp --kill
    mpd
fi

PS1='\[\e[1;36m\]^_^\[\e[m\] \[\e[0;32m\]\w\[\e[m\] \[\e[0;32m\]\$\[\e[m\] '

export PATH=$PATH:$HOME/Bash

[[ -x /usr/bin/vim ]] && export EDITOR=vim

complete -cf sudo

[[ -f /etc/profile.d/bash-completion.sh ]] && source /etc/profile.d/bash-completion.sh
