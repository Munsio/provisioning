#!/bin/bash


sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

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