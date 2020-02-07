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
    cp libpython3.7m.so.1.0 /usr/lib64 
    #cp /home/cloudguan/.local/bashboot/vim /usr/bin/vim
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
        mv $pypath $Sp/python_bak
    fi

    ln -s /usr/local/python37/bin/python3 /usr/bin/python 
    ln -s /usr/local/python37/bin/pip3 /usr/bin/pip
}

cd /home/cloudguan/.local/Download

yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
yum install libffi-devel -y

if [ ! -f Python-3.7.6.tgz ]
then
    download_python
fi

pre_check

build_python

after_check

