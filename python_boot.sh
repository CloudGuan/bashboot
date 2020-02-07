#!/bin/bash


function download_python(){
    wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz
}

function build_python(){
    tar -zxvf Python-3.7.6.tgz
    cd Python-3.7.6
    mkdir build
    cd build
    ../configure --prefix=/usr/local/python37 --enable-shared
    make -j8
    make install
}

function pre_check(){
    if [ -d /usr/local/python37 ];
    then
        rm -rf /usr/local/python37
    fi
}

function after_check(){
    #处理好 python3 环境变量 和 软连接
    pypath=`which python`
    if [ $? -eq 0  ]
    then
        # bak python
        Sp=${pypath%/*}
        echo $pypath $Sp/python_bak
    fi

    ln -s /usr/local/python37/bin/python3 /usr/bin/python 
}

pre_check 
