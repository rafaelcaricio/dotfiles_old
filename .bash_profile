export TERM="xterm-color"
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export EDITOR="mvim"
export PATH=$HOME/bin:$PATH
export GLB_PROJECTS_ROOT_PATH=$HOME/dev/globocom/
export PYTHONPATH="/usr/local/lib/python2.6/site-packages/:$PYTHONPATH"
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
source $HOME/.git-completion.bash

DEFAULT_VENV="globo.com"

# command aliases
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias cdhome='cd ~/'
alias uuid='python -c "import sys;import uuid;sys.stdout.write(str(uuid.uuid4()))" | pbcopy'
alias git-init='sh $HOME/.extra_bin/git-init.sh'

# remove .svn folders
alias rmsvn='find . -type d -name .svn | xargs rm -rf'

# remove *.pyc files
alias rmpyc='find . -name "*.pyc" -delete'

# mysql commands
alias mysql_start='mysqld &'
alias mysql_stop='killall mysqld'

alias solr_start='make start -C ~/dev/globocom/busca-nova-plataforma'
alias solr_stop='make stop -C ~/dev/globocom/busca-nova-plataforma'

alias activemq_start='make start -C ~/dev/globocom/barramento'
alias activemq_stop='make stop -C ~/dev/globocom/barramento'

alias stop_all='solr_stop; activemq_stop; selenium stop; mysql_stop'
alias start_all='stop_all; solr_start; activemq_start; selenium start; mysql_start'

alias simple-server='python -m SimpleHTTPServer'

# don't put duplicate lines in the history
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# simulate slow connection
start_slow() {
    sudo ipfw pipe 1 config bw 100KByte/s
    sudo ipfw add 1 pipe 1 src-port $1
}

stop_slow() {
    sudo ipfw delete 1
}

function PWD {
    pwd | awk -F\/ '{if (NF>4) print "...", $(NF-2), $(NF-1), $(NF); else if (NF>3) print $(NF-2),$(NF-1),$(NF); else if (NF>2) print $(NF-1),$(NF); else if (NF>1) print $(NF);}' | sed -e 's# #\/#g'
}

# virtualenvwrapper settings
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
GRAY="\[\033[0;37m\]"
LIGHTBLUE="\[\033[1;34m\]"
LIGHTYELLOW="\[\033[1;33m\]"
LIGHTCYAN="\[\033[1;36m\]"
NOCOLOR="\[\e[0m\]"

export PS1="$NOCOLOR-\$(date +%H:%M)- $NOCOLOR[/\$(PWD)] $YELLOW\$(__git_ps1)$NOCOLOR \$ "
export PS2="> "

workon globo.com

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
export PATH=/opt/local/bin:/opt/local/sbin:/Users/rafael.caricio/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/Users/rafael.caricio/bin
