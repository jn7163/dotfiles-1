#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -r /etc/bash_completion ]] && . /etc/bash_completion

[[ -f ~/.bash_alias ]] && . ~/.bash_alias

#PS1='[\u@\h \W]\$ '
PS1='\[\e[1;36m\]^_^\[\e[m\] \[\e[0;32m\]\w\[\e[m\] \[\e[0;32m\]\$\[\e[m\] '

function hello() {
    [[ "-x /usr/bin/cowsay" && "-x /usr/bin/fortune" ]] && fortune | cowsay
}
