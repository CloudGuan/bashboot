#!/bin/bash 

cd /home/cloudguan/.local

if [ ! -d Download ]
then
	mkdir Download
fi 

cd /home/cloudguan/.local/Download

function install_ctags(){
    ## 检测ctags 还有 gtags的安装
    if [ -f /usr/local/bin/ctags ]; then
        echo "ctags has install"
        return
    fi 
    
    ctagsp=`which ctags`
    if [ $? -eq 0 ]; then
        echo "ctags uninstall" 
        rm -rf $ctagsp
    fi 

    if [ ! -d ctags ]; then
        echo "ctags is not install"
        git clone https://github.com/universal-ctags/ctags.git ctags
    fi

    cd ctags
    ./autogen.sh
    mkdir build
    cd build
    ../configure --prefix=/usr/local
    make -j6 
    make install

    cd /home/cloudguan/.local/Download
}

function gtags_install(){
    
    if [ ! -f /usr/local/bin/gtags ]; then
        echo "gtags install!!!!"
        return
    fi 

    cd /home/cloudguan/.local/Download

    gtagsp=`which gtags`

    if [ $? -eq 0 ]; then
        echo "gtags install"
        rm -rf $gtagsp
    fi 

    if [ ! -f global-6.6.4.tar.gz ]; then
        echo "gtags is not install"
        wget http://tamacom.com/global/global-6.6.4.tar.gz
    fi

    tar -zxvf global-6.6.4.tar.gz
    cd global-6.6.4
    mkdir build 
    cd build/
    ../configure --prefix=/usr/local
    make -j6
    make install 
    cd /home/cloudguan/.local/Download
}

function apt_op(){
    apt install \
        gcc make \
        pkg-config autoconf automake \
        python3-docutils \
        libseccomp-dev \
        libjansson-dev \
        libyaml-dev \
        libxml2-dev

    apt install build-essential cmake python3-dev
}

function yum_op(){
    yum remove -y ctags
}

function go_install(){
    ## check golang YCM need golang
    if [ -d /usr/local/go ]; then
        echo "go exit!!!!"
    else
        if [ ! -f go1.13.7.linux-amd64.tar.gz ]; then
            wget https://dl.google.com/go/go1.13.7.linux-amd64.tar.gz
        fi 

        tar -zxvf go1.13.7.linux-amd64.tar.gz
        mv go /usr/local
        cd /home/cloudguan/.local/Download
    fi 

}

yum_op 

go_install
install_ctags
gtags_install 

## YCM 依赖检查 cmake3 python3-dev build-essential 

## defx目录树环境
pip3 install --user pynvim
pip3 install --user pygments
