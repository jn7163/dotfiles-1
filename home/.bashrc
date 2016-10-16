# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ -f ~/.bash_alias ]] && . ~/.bash_alias
[[ -f /usr/bin/sudo ]] && complete -cf sudo
[[ -f /usr/bin/man ]] && complete -cf man

# PS
OS=`uname`

PS() {
    export GIT_PS1_SHOWDIRTYSTATE=1
    export PS1='\[\e[0;32m\](\h) → [\t] \w\[\e[0;33m\]$(__git_ps1) \[\e[0;32m\]\$\[\e[0m\] '
    export LANG="en_US.UTF-8"
}

run_ccal() {
    if [ `which ccal 2> /dev/null` ]; then
        tty | egrep -i "tty" > /dev/null && ccal -u
    fi
}

case $OS in
    Darwin)
        [[ -f $(xcode-select -p)/usr/share/git-core/git-prompt.sh ]] && . $(xcode-select -p)/usr/share/git-core/git-prompt.sh
        [[ ${EUID} == "501" ]] && PS
        export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
        run_ccal
        ;;
    Linux)
        [[ -f /usr/share/git/git-prompt.sh ]] && . /usr/share/git/git-prompt.sh
        [[ ${EUID} == "1000" ]] && PS
        run_ccal
        ;;
esac

