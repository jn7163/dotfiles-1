# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS
OS=`uname`

PS() {
    export GIT_PS1_SHOWDIRTYSTATE=1
    export PS1='\[\e[0;32m\](\h) → [\t] \w\[\e[0;33m\]$(__git_ps1) \[\e[0;32m\]\$\[\e[0m\] '
    export LANG="en_US.UTF-8"
}

case $OS in
    Darwin)
        [[ -f $(xcode-select -p)/usr/share/git-core/git-prompt.sh ]] && . $(xcode-select -p)/usr/share/git-core/git-prompt.sh
        [[ ${EUID} == "501" ]] && PS
        export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
        ;;
    Linux)
        [[ -f /usr/share/git/git-prompt.sh ]] && . /usr/share/git/git-prompt.sh
        [[ ${EUID} == "1000" ]] && PS
        ;;
esac

# ccal
if [ -f /usr/bin/ccal ]; then
    tty | egrep -i "pts" > /dev/null && ccal -u
fi

