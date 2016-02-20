#!/bin/bash

HOMEDIR=~/.oh-my-zsh

echo ""
echo "Changing default shell to zsh"
chsh -s $(grep /zsh$ /etc/shells | tail -1)

echo ""
echo "Installing oh-my-zsh"
curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | \
ZSH=$HOMEDIR sh

echo ""
echo "Installing oh-my-zsh finished - now copy default zsh and vim configuration"

if [ -f "zshrc" ]; then
    cp ./zshrc ~/.zshrc
else
    echo "zshrc does not exist - skipping"
fi

if [ -f "vimrc" ]; then
    cp ./vimrc ~/.vimrc
else
    echo "vimrc does not exist - skipping"
fi
