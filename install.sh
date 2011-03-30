#/usr/bin/env sh

create_ln_if_not_yet_created(){
    if [ ! -e "$1" ]; then
        ln -s "$2" "$1"
    else
        echo "did not create link for $1"
    fi
}

pwd=$PWD

create_ln_if_not_yet_created "$HOME/.bash_profile" "$pwd/.bash_profile"
create_ln_if_not_yet_created "$HOME/.git-completion.bash" "$pwd/.git-completion.bash"

# Automatically track new branches
git config --global push.default tracking
git config --global branch.autosetupmerge true

# Colored output
git config --global color.ui auto

# Git aliases
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.lg "log --format='%Cgreen%h %Cred%cr %Creset%s %Cblue%cn'"

