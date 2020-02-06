
import os
import sys
import platform

global username
cache_dir=".local"
python_link=""
vim8_link=""


def CheckPip():
    pass

def CheckCMake():
    pass

def CheckGo():
    pass

def CheckVersion():
    pass

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
        exit(-1)
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

if __name__=="__main__":
    Main(sys.argv)