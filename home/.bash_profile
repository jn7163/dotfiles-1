# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -f ~/.bash_alias ]] && . ~/.bash_alias

[[ -f /usr/bin/sudo ]] && complete -cf sudo

[[ -f /usr/bin/man ]] && complete -cf man

# history
export HISTTIMEFORMAT="%Y-%m-%d %T "
export HISTCONTROL=ignoreboth:erasedups

# personal bash path
[[ -d ~/.bash ]] && export PATH=$PATH:$HOME/.bash

[[ -d ~/.gem ]] && export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin
