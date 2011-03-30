export TERM="xterm-color"
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export EDITOR="mvim"
export PATH=$HOME/bin:$PATH
export GLB_PROJECTS_ROOT_PATH=$HOME/Sites/dev
source $HOME/.git-completion.bash

DEFAULT_VENV="globocom"

# command aliases
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias cdhome='cd ~/'
alias uuid='python -c "import sys;import uuid;sys.stdout.write(str(uuid.uuid4()))" | pbcopy'

# remove .svn folders
alias rmsvn='find . -type d -name .svn | xargs rm -rf'

# remove *.pyc files
alias rmpyc='find . -name "*.pyc" -delete'

# mysql commands
alias mysql_start='mysqld &'
alias mysql_stop='killall mysqld'


# simulate slow connection
start_slow() {
    sudo ipfw pipe 1 config bw 100KByte/s
    sudo ipfw add 1 pipe 1 src-port $1
}

stop_slow() {
    sudo ipfw delete 1
}

# Automatically activate Git projects' virtual environments based on the
# directory name of the project. Virtual environment name can be overridden
# by placing a .venv file in the project root with a virtualenv name in it
function workon_cwd {
    # Check that this is a Git repo
    GIT_DIR=`git rev-parse --git-dir 2> /dev/null`
    if [ $? == 0 ]; then
        # Find the repo root and check for virtualenv name override
        GIT_DIR=`\cd $GIT_DIR; pwd`
        PROJECT_ROOT=`dirname "$GIT_DIR"`
        ENV_NAME=`basename "$PROJECT_ROOT"`
        if [ -f "$PROJECT_ROOT/.venv" ]; then
            ENV_NAME=`cat "$PROJECT_ROOT/.venv"`
        fi
        # Activate the environment only if it is not already active
        if [ "$VIRTUAL_ENV" != "$WORKON_HOME/$ENV_NAME" ]; then
            if [ -e "$WORKON_HOME/$ENV_NAME/bin/activate" ]; then
                workon "$ENV_NAME" && export CD_VIRTUAL_ENV="$ENV_NAME"
            fi
        fi
    elif [ $CD_VIRTUAL_ENV ]; then
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        deactivate && unset CD_VIRTUAL_ENV
        # my default virtualenv
        workon "$DEFAULT_VENV" && export CD_VIRTUAL_ENV="$DEFAULT_VENV"
    fi
}

# New cd function that does the virtualenv magic
function venv_cd {
    cd "$@" && workon_cwd
}

alias cd="venv_cd"

function PWD {
    pwd | awk -F\/ '{if (NF>4) print "...", $(NF-2), $(NF-1), $(NF); else if (NF>3) print $(NF-2),$(NF-1),$(NF); else if (NF>2) print $(NF-1),$(NF); else if (NF>1) print $(NF);}' | sed -e 's# #\/#g'
}

function git_branch {
    __git_ps1
}

function custom_console {
    local RED="\[\033[0;31m\]"
    local YELLOW="\[\033[0;33m\]"
    local GREEN="\[\033[0;32m\]"
    local BLUE="\[\033[0;34m\]"
    local GRAY="\[\033[0;37m\]"
    local LIGHTBLUE="\[\033[1;34m\]"
    local LIGHTYELLOW="\[\033[1;33m\]"
    local LIGHTCYAN="\[\033[1;36m\]"
    local NOCOLOR="\[\e[0m\]"
    export PS1="$NOCOLOR|\$(date +%H:%M)| $LIGHTBLUE\u $LIGHTCYAN@ $NOCOLOR[/\$(PWD)] $GRAY\$(basename $VIRTUAL_ENV)$YELLOW$(git_branch)$NOCOLOR \$ "
    export PS2="> "
}

# virtualenvwrapper settings
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
workon "$DEFAULT_VENV" && export CD_VIRTUAL_ENV="$DEFAULT_VENV"