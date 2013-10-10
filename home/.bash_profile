# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -f ~/.bash_alias ]] && . ~/.bash_alias

if [ $(tty) == /dev/tty1 ]; then
    [[ -f ~/.mpd/mpd.pid ]] && mpd --kill
    mpd
fi

[[ -d ~/.bash ]] && export PATH=$PATH:$HOME/.bash

[[ -d ~/.gem ]] && export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin

[[ -x /usr/bin/vim ]] && export EDITOR=vim

#[[ -f /usr/bin/sudo ]] && complete -cf sudo

#[[ -f /usr/bin/man ]] && complete -cf man

#[[ -f /etc/profile.d/bash-completion.sh ]] && source /etc/profile.d/bash-completion.sh
