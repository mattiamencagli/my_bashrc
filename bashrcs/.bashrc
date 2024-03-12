# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export PATH="$HOME/my_programs:$PATH"
#export PATH="$HOME/.local/bin:$PATH"
#export PATH="$HOME/my_programs/clion-2021.1.2/bin:$PATH"
#export PATH="/usr/local/cuda-11.3/bin:$PATH"
#export JUPYTERLAB_DIR="$HOME/.local/share/jupyter/lab"
#export LD_LIBRARY_PATH="/usr/local/cuda-11.3/lib64:$LD_LIBRARY_PATH"

#export CUDACXX='nvcc'
#export CPLUS_INCLUDE_PATH='/usr/local/cuda/include'
export PLUTO_DIR=${HOME}/programming/gpluto_cpp

cat ~/setting_wsl/.pass | sudo -S -k cp /etc/resolv.conf ~/setting_wsl/resolv.conf.OLD &> /dev/null
cat ~/setting_wsl/.pass | sudo -S -k cp ~/setting_wsl/resolv.conf /etc/resolv.conf &> /dev/null

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
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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
	export GIT_PS1_SHOWCOLORHINTS=1
	export GIT_PS1_SHOWDIRTYSTATE=1
	export GIT_PS1_SHOWUNTRACKEDFILES=1
	export GIT_PS1_SHOWUPSTREAM=1
	color_user='\[\e[01;31m\]\u'
	color_work_dir='\[\e[01;36m\]\w'
	color_git='\[\033[1;93m\]$(__git_ps1 "(%s)")'
	color_dollar='\[\e[1;32m\]\$'
	color_input='\[\e[0;37m\] '
    PS1='${debian_chroot:+($debian_chroot)}'${color_user}${color_work_dir}${color_git}${color_dollar}${color_input}
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -lh'
alias lt='ls -lth'
alias la='ls -lah'
alias lat='ls -lath'
alias l='ls -CF'

alias gitlogtot='git log --all --oneline --decorate --graph'
alias git_reset='git restore `git ls-files -m` && git clean -f'

alias jupylab='cd ~/my-python-plots && ~/.local/bin/jupyter-lab --no-browser'

#alias step2FA='step ssh login m.mencagli@cineca.it --provisioner cineca-hpc'

alias cdwin='cd /mnt/c/Users/m.mencagli'
alias cdtest='cd /mnt/c/Users/m.mencagli/OneDrive\ -\ CINECA/Documenti/tests'

#alias pluto_rsync_karo='rsync -azP ~/programming/gpluto_cpp karolina:~/'
#alias pluto_rsync_leo='rsync -azP ~/programming/gpluto_cpp leonardo:~/'

alias qs='export QS=$PWD && echo "save $PWD"'
alias sq='cd $QS'

#my commands:
#yourlogin ALL=(ALL) NOPASSWD: restartblue

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


alias step2FAcert='step ssh certificate m.mencagli@cineca.it --no-password --insecure --force --provisioner cineca-hpc ${HOME}/.ssh/id_ed25519 && cp -v ${HOME}/.ssh/id_ed25519* /mnt/c/Users/m.mencagli/.ssh/'

date=$(date +"%d%m%Y") 
last_date=$(cat ~/setting_wsl/last_log)
eval $(ssh-agent) &> /dev/null

if [ "$date" = "$last_date" ]; then
	echo "not first access today"
else
	echo "first access today"
	echo "$date" > ~/setting_wsl/last_log
	step2FAcert	
fi	


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
