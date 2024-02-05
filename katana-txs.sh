#!/bin/bash

source_shell() {
    case $SHELL in
    */zsh)
        source ${ZDOTDIR-"$HOME"}/.zshenv
        ;;
    */bash)
        source $HOME/.bashrc
        ;;
    */fish)
        source $HOME/.config/fish/config.fish
        ;;
    */ash)
        source $HOME/.profile
        ;;
    *)
    esac
}

install_dojo() {
    echo "Installing Dojo"
    curl -L https://install.dojoengine.org | bash

    source_shell
    dojoup
}

# check if binary is installed
if [ ! -f $HOME/.dojo/bin/sozo ]; then
    echo "Sozo is not installed. Can I install?"
    select yn in "Yes" "No"; do
        case $yn in
        Yes)
            install_dojo
            break
            ;;
        No)
            echo "Please install Sozo and try again"
            exit 1
            ;;
        esac
    done
fi

git clone https://github.com/dojoengine/dojo.git
cd dojo/examples/spawn-and-move
sozo build && sozo migrate
