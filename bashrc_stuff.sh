@cat .bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# [AzherKhan] Below are GIT ALIAS
alias ghelp='cat ~/.bashrc| grep "git"'
alias gad='git add'
alias gbr='git branch'
alias gcl='git clone'
alias gci='git commit'
alias gssl='git config --global http.sslVerify false'
alias gcn='git config --list'
alias gr='git review'
alias gs='git status'
alias gsub='git submodule update --init'
alias gp='git pull --ff-only'
alias glpr='git log --pretty=oneline'
alias glp='git log -p'
alias glst='git log --stat'
alias gcat='cat .git/config'
alias gcfp='git cat-file -p '
alias gcft='git cat-file -t '
alias gck='git checkout '
alias gsubs='git submodule status'

# [AzherKhan] Below are GIT ALIAS with COMMANDS
alias ghelp='cat ~/.bashrc| grep "git"'
alias gad='git add'
alias gbr='echo "git branch"; git branch'
alias gcl='git clone'
alias gci='git commit'
alias gssl='echo "git config --global http.sslVerify false"; git config --global http.sslVerify false'
alias gcn='echo "git config --list"; git config --list'
alias gr='git review'
alias gs='echo "git status"; git status'
alias gsub='echo "git submodule update --init"; git submodule update --init'
alias gp='echo "git pull --ff-only"; git pull --ff-only'
alias glpr='echo "git log --pretty=oneline"; git log --pretty=oneline'
alias glp='git log -p'
alias glst='echo "git log --stat"; git log --stat'
alias gcat='echo "cat .git/config"; cat .git/config'
alias gcfp='git cat-file -p '
alias gcft='git cat-file -t '
alias gck='git checkout '
alias gsubs='echo "git submodule status"; git submodule status'

# some more ls aliases
alias ll='ls -altr'
alias la='ls -A'
alias l='ls -CF'
alias cc='clear'
alias cl='cc ; ls -ltr'
alias up='. cd-up-n.sh $1'
alias p='pushd'
alias o='popd'
alias cdog='cd ~/openstack-infra/openstack/config'
alias cdos='cd ~/openstack-infra/openstack/system-config'
alias cdg='cd ~/openstack-infra/org/config'
alias cds='cd ~/openstack-infra/org/system-config'

# Set the vi editor mode
set -o vi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_03
#export PATH=$PATH:$JAVA_HOME/bin
export MAVEN_HOME=/var/lib/jenkins/apache-maven-2.2.1
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
export PATH=$PATH:$JAVA_HOME/bin
PS1='{\u@\h \W$(__git_ps1 " (%s)")} \n@'
# The below feature will ensure the user to CD to their favourite/specified directory, without having to type the full PATH
export CDPATH=.:~:/var/lib/jenkins
# The below function mkdircd will create the directory and CD into it
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
# The below command corrects the typos in the cd command automatically
shopt -s cdspell


export http_proxy="http://web-proxy.houston.org.com:8080/"
export https_proxy="http://web-proxy.houston.org.com:8080/"

## To capture session history
shopt -s histappend
## cd spell check
shopt -s cdspell
