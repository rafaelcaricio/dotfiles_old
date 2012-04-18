#/usr/bin/env sh

create_ln_if_not_yet_created(){
    if [ ! -e "$1" ]; then
        ln -s "$2" "$1"
    else
        echo "did not create link for $1"
    fi
}

pushd vim/.vim/bundle
make
popd

git submodule update --init --recursive

# Get root
DOTFILES="$PWD/`dirname $0`"

create_ln_if_not_yet_created "$HOME/.vim" "$DOTFILES/vim/.vim"
create_ln_if_not_yet_created "$HOME/.vimrc" "$DOTFILES/vim/.vimrc"
create_ln_if_not_yet_created "$HOME/.bash_profile" "$DOTFILES/.bash_profile"
create_ln_if_not_yet_created "$HOME/.git-completion.bash" "$DOTFILES/.git-completion.bash"
create_ln_if_not_yet_created "$HOME/.extra_bin" "$DOTFILES/bin"

# Set git user
git config --global user.name "Rafael Carício"
git config --global user.email "rafael.jacinto@gmail.com"

# Automatically track new branches
git config --global push.default tracking
git config --global branch.autosetupmerge true

# Colored output
git config --global color.ui auto

# Git aliases
git config --global alias.st status
git config --global alias.co commit
git config --global alias.com "commit -m"
git config --global alias.ck checkout
git config --global alias.br branch
git config --global alias.pu "pull"
git config --global alias.purr "pull --rebase"
git config --global alias.lg "log --format='%Cgreen%h %Cred%cr %Creset%s %Cblue%cn'"
git config --global alias.logg "log --graph --color --decorate"

source ".bash_profile"
