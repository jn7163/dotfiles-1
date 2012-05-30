# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
#complete -cf sudo
#[[ -f /etc/profile.d/bash-completion.sh ]] && source /etc/profile.d/bash-completion.sh
#for i in $(ls --color=no /usr/share/bash-completion/); do eselect bashcomp enable --global $i; done
#bashcomp-config enable gentoo
#export PATH=$PATH:$HOME/Bash
export EDITOR=vim
PS1='\[\e[1;36m\]^_^\[\e[m\] \[\e[0;32m\]\w\[\e[m\] \[\e[0;32m\]\$\[\e[m\] '
#PS1='\[\e[1;36m\]^_^\[\e[m\] \[\e[0;32m\]\w\[\e[m\] \[\e[0;32m\]●\[\e[m\] '
#XSESSION='gnome-session'

#alias rtorrent='screen rtorrent'
#alias irssi='screen irssi'
#alias mutt='screen mutt'
#alias lftp='screen lftp'
#alias canto='screen canto'
#alias wget='screen wget -c'
#alias freetalk='screen freetalk'
#alias w3m='screen w3m'
#alias gtmess='screen gtmess'
#alias mc='screen mc'
alias ls='ls --time-style=long-iso --color'
alias zhcon='zhcon --utf8'
alias ll='ls -lh'
alias grep='grep --color=auto'
alias netstat='netstat -antp'
alias less='less -R'
alias route='route -n'
alias df='df -Th'
alias du='du -sh'
#alias free='free -m'
alias ping='ping -c 4'
#alias rm='rm -i'
alias vboxxp='VBoxManage startvm "Windows XP"'
alias vboxcentos='VBoxManage startvm "CentOS"'
alias vboxslackware='VBoxManage startvm "Slackware"'
alias vboxarch='VBoxManage startvm "Arch"'
alias vboxfreebsd='VBoxManage startvm "FreeBSD"'
alias rdesktop='rdesktop -z -a 16'
alias ssh='ssh -C'
#alias getip1='w3m -dump http://www.ip.cn/getip.php?action=getip'
alias mptv='mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0'
