
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f /etc/profile.d/bash-completion.sh ]] && . /etc/profile.d/bash-completion.sh

[[ -f /usr/bin/sudo ]] && complete -cf sudo

[[ -f /usr/bin/man ]] && complete -cf man

[[ -d ~/.bash ]] && export PATH=$PATH:$HOME/.bash

export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin

[[ -f ~/.bash_alias ]] && . ~/.bash_alias

#PS1='[\u@\h \W]\$ '
PS1='\[\e[1;36m\]^_^\[\e[m\] \[\e[0;32m\]\w\[\e[m\] \[\e[0;32m\]\$\[\e[m\] '

function hello() {
    [[ "-x /usr/bin/cowsay" && "-x /usr/bin/fortune" ]] && fortune-zh joke | cowsay
}
