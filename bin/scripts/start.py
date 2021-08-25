import os
from multiprocessing import Process
import time


# CORE SYSTEM TOOLS

def twenty():

    os.system("pkill -f twenty.sh")
    os.system("~/bin/scripts/twenty.sh")


def brave():

    os.system("/usr/bin/brave")


def redshift():

    os.system("redshift -x")
    os.system("redshift -O 3300")


def polybar():

    os.system("pkill polybar")
    os.system("polybar -r simple")


def xfce_power():

    os.system("pkill xfce4-power-manager")
    os.system("xfce4-power-manager")


def aw():

    os.system("pkill aw-qt")
    os.system("/home/musa/Downloads/APPS/Uncompressed/activitywatch/aw-qt")


def network():

    os.system("pkill nm-applet")
    os.system("nm-applet")


def pcloud():

    os.system("pkill pcloud")
    os.system("/home/musa/Downloads/APPS/AppImage/pcloud")


def nitrogen():

    os.system("pkill -f wall.sh")
    os.system("~/bin/scripts/wall.sh")


def unclutter():
	
	os.system("unclutter")

# ADDED PROGRAMS I MIGHT NOT WANT IN THE FUTURE

#def aioz():
#
#    os.system("pkill -f AIOZ")
#    os.system("/home/musa/Downloads/APPS/AppImage/AIOZ/AIOZ-Node-0.7.3.AppImage")



if __name__ == '__main__':

    twentyp = Process(target=twenty)
    bravep = Process(target=brave)
    nitrogenp = Process(target=nitrogen)
    redshiftp = Process(target=redshift)
    polybarp = Process(target=polybar)
    xfce_powerp = Process(target=xfce_power)
    awp = Process(target=aw)
    networkp = Process(target=network)
    pcloudp = Process(target=pcloud)
    unclutterp = Process(target=unclutter)
    #aiozp = Process(target=aioz)
    

    twentyp.start()
    bravep.start()
    redshiftp.start()
    polybarp.start()
    xfce_powerp.start()  
    awp.start()
    networkp.start()
    pcloudp.start()
    time.sleep(5)  
    nitrogenp.start()
    unclutterp.start()

    #aiozp.start()
