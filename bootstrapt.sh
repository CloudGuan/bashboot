#!/bin/bash

cd ~

if [ ! -d ~/.local  ]
then
    mkdir .local
fi  

cd .local

if [ ! -d bashboot ]
then
    git clone https://github.com/CloudGuan/bashboot.git bashboot
    if [ $? -gt 0  ]; then
        echo "clone from git error "
        exit -1
    fi
fi

cd bashboot
python init_shell.py 
