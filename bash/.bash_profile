export PATH="/usr/local/bin:/usr/local/sbin:~/bin:/usr/local/share/npm/bin:$PATH"
export NODE_PATH="/usr/local/lib/node"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWSTASHSTATE=1

# Basique…
# export PS1='\u@\h:\W$(__git_ps1 " (%s)")\$ '
# Avec plein de couleurs…
# export PS1='\[\033[0;37m\]\u@\h:\[\033[0;33m\]\W\[\033[0m\]\[\033[1;32m\]$(__git_ps1)\[\033[0m\] \$ '
export PS1='\[\033[0;33m\]\W\[\033[0m\]\[\033[1;32m\]$(__git_ps1)\[\033[0m\] \$ '

if ! shopt -oq posix; then
  if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
  fi
fi

if [ -f ~/.git-prompt.sh ]; then
. ~/.git-prompt.sh
fi

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
