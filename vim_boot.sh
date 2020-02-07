#!/bin/bash

function download_vim(){
    wget https://github.com/vim/vim/archive/v8.2.0226.tar.gz
}

function build_vim(){
    
    if [ -d vim-8.2.0226 ]; then
        rm -rf vim-8.2.0226
    fi

    if [ -d /usr/local/vim8 ]
    then
        rm -rf /usr/local/vim8
    fi

    tar zxvf v8.2.0226.tar.gz 
    if [ $? -gt 0  ]
    then
        echo "unpack error!!!!!!!!!!!!!"
        exit -1 
    fi 

    cd vim-8.2.0226

    #这里必须 写 dynamic ，不然装了YCM之后会 crash  

    ./configure \
        --enable-multibyte \
        --enable-perlinterp \
        --enable-rubyinterp \
        --enable-pythoninterp=dynamic \
        --enable-python3interp=dynamic \
        --with-python-config-dir=/usr/lib64/python2.7/config \
        --with-python3-config-dir=/usr/local/python37/lib/python3.7/config-3.7m-x86_64-linux-gnu \
        --enable-cscope \
        --enable-gui=auto \
        --with-features=huge \
        --enable-fontset \
        --enable-largefile \
        --disable-netbeans \
        --prefix=/usr/local/vim8 \
        --with-compiledby="cloudguan"

    make -j8 
    if [ $? -gt 0  ]
    then
        echo "config error !!!!"
        exit -1 
    fi 
    make install
}

function deal_link(){
    vimpath=`which vim`
    if [ $? -eq 0  ]
    then
        # bak python
        Sp=${vimpath%/*}
        mv $vimpath $Sp/vim_bak
    fi
    ln -s /usr/local/vim/bin/vim /usr/bin/vim
}

# for centos 
function yum_op(){
    yum remove -y vim
    yum install -y perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-Embed
}

if [ -f /usr/local/bin/vim ]; then
    rm /usr/local/bin/vim
fi 

yum_op

cd /home/cloudguan/.local/Download
if [ ! -f v8.2.0226.tar.gz ]
then
    download_vim 
fi 

build_vim

deal_link

