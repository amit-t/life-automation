#!/bin/zsh
if [ -e ~/.zcompdump* ] || [ -e ~/Profiles/.zcompdump* ]; then
    rm -rf ~/.zcompdump*
    rm -rf ~/Profiles/.zcompdump*
fi



