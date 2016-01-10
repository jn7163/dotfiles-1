# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bash_color ]] && . ~/.bash_color

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -f ~/.bash_alias ]] && . ~/.bash_alias

[[ -f /usr/bin/sudo ]] && complete -cf sudo

[[ -f /usr/bin/man ]] && complete -cf man

[[ -f $(which lantern.sh) ]] && complete -cf lantern.sh

# history
export HISTTIMEFORMAT="%Y-%m-%d %T "
export HISTCONTROL=ignoreboth:erasedups

# personal bash path
[[ -d ~/.bash ]] && export PATH=$PATH:$HOME/.bash

case `uname` in
    Darwin)
        # git-completion
        if [ -f $(xcode-select -p)/usr/share/git-core/git-completion.bash ]; then
            source $(xcode-select -p)/usr/share/git-core/git-completion.bash
        fi
        # HOMEBREW
        if [ -f /usr/local/bin/brew ]; then
            #export HOMEBREW_GITHUB_API_TOKEN=19a5822bd74d7643de20d39835d2b9254eba810b
            export HOMEBREW_EDITOR=/usr/bin/vim
            export PATH=$(brew --prefix)/sbin:$PATH
        fi
        # HOMEBREW CASK
        #export HOMEBREW_CASK_OPTS="--appdir=$HOME/My\ Applications"
        if [ -d $(brew --prefix)/Library/Taps/caskroom ]; then
            export PATH=$(brew --prefix)/Library/Taps/caskroom/homebrew-cask/developer/bin:$PATH
        fi
        # bash-completion
        if [ -f $(brew --prefix)/etc/bash_completion ]; then
            . $(brew --prefix)/etc/bash_completion
        fi
        # bash-completion2
        if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
            . $(brew --prefix)/share/bash-completion/bash_completion
        fi
        # mono
        [[ -f /usr/local/bin/mono ]] &&  export MONO_GAC_PREFIX="/usr/local"
        # pip home
        if [ -d ~/Library/Python/2.7/bin ]; then
            export PYTHONUSERBASE=$HOME/Library/Python/2.7
            export PATH=$PYTHONUSERBASE/bin:$PATH
        fi
        # gem home
        if [ -f /usr/bin/gem ]; then
            export GEM_HOME=$HOME/.gem
            export PATH=$GEM_HOME/bin:$PATH
        fi
        ;;
    Linux)
        # gem
        [[ -d ~/.gem ]] && export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin
        ;;
esac
