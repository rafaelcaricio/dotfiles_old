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