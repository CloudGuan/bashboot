#!/usr/bin/python
# -*- coding:utf-8 -*-

import os
import sys
import platform
import locale
import subprocess

local_encode = locale.getdefaultlocale()
print("local encode : ", local_encode)

global username
cache_dir=".local"
python_link=""
vim8_link=""


def CheckPip():
    error = os.system("pip --version")
    if error != 0:
        print("=======install pip=======")


def CheckCMake():
    error = os.system("cmake --version")
    if error != 0:
        print("==========install cmake==========")

def CheckGo():
    error = os.system("go --version")
    if error != 0:
        print("========install go==============")

def CheckPython():
    python_info = subprocess.check_output(["python", "--version"]).decode(local_encode[1])
    print(python_info)

def CheckVim():
    error = os.system("vim --version")
    if error != 0:
        print("===== install vim =====")
    else:
        # check vim version , we need  >= 8.0
        vim_info = subprocess.check_output(["vim","--version"]).decode(local_encode[1])
        res = vim_info.split('\n', 1)
        if int(res[0].split(' ')[4].split('.')[0]) < 8:
            print("===== uninstall old vim version ======")
            print("===== start install vim8 ========")
        else:
            print("vim version: ", res[0])

def CheckVersion():
    if os.system("gcc --version") != 0:
        print("Please Install gcc first!!!!")
        exit(-1)

    CheckPython()
    CheckPython()
    CheckCMake()
    CheckGo()
    CheckVim()

    return True

def CheckOSVersion():
    sys = platform.system()
    plats = platform.platform().split('-')
    uname_info = platform.uname()

    #print(sys, plats,platform.node(), platform.version(), platform.machine(), platform.release())
    print("System: ", sys)
    print("Platform: ", uname_info[0])
    print("Version: ", uname_info[3])

    if sys == "Windows":
        print("Not Support windows yet")
        #exit(-1)
    else:
        if "centos" in plats:
            return "yum"
        elif "debain" in plats:
            return "apt-get"

def Main(argv):
    if len(argv) < 1 :
        print("参数类型错误")
        exit(-1)

    packmgr = CheckOSVersion()
    print("Package Manager:", packmgr)
    print("===== start init shell =====")
    CheckVersion()

if __name__=="__main__":
    Main(sys.argv)
