# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# config for git-prompt
MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[01;32m\]"
BLUE="\[\033[00;34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[01;36m\]"
GREEN="\[\033[00m\]"
RED="\[\033[0;31m\]"
VIOLET='\[\033[01;35m\]'
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
function color_my_prompt {
  local __user_and_host="$GREEN\u" # \h =>to add host
  local __cur_location="$BLUE\W"   #capital 'W': current directory, small 'w':full file path
  local __git_branch_color="$RED"
  #local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
  #local __git_branch='$(__git_ps1 " (%s)")';
  local __git_branch='$(__git_ps1)';  
  # colour branch name depending on state
  if [[ "$(__git_ps1)" =~ "*" ]]; then           # if repository is dirty
     __git_branch_color="$RED"
  elif [[ "$(__git_ps1)" =~ "%" ]]; then         # if there are untracked files
     __git_branch_color="$BLUE"
  elif [[ "$(__git_ps1)" =~ "$" ]]; then         # if there is something stashed
     __git_branch_color="$YELLOW"
  elif [[ "$(__git_ps1)" =~ "=" ]]; then         # if local & remote branches are not ahead/behind
     __git_branch_color="$CYAN"
  fi
  local __prompt_tail="$VIOLET$"
  local __user_input_color="$GREEN"
  PS1="$__user_and_host $__cur_location$__git_branch_color$__git_branch $__prompt_tail$__user_input_color "
}
# call PROMPT_COMMAND which is executed before PS1
export PROMPT_COMMAND=color_my_prompt
#export PROMPT_COMMAND='__git_ps1 "\u:\W" "$"'

if [ -f ~/.git-prompt.sh ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_HIDE_IF_PWD_IGNORED=true
  GIT_PS1_SHOWCOLORHINTS=true
  . ~/.git-prompt.sh
fi

# Execute git completion
if ! shopt -oq posix; then
  if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
  fi
fi