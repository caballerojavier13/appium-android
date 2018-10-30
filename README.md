Appium - Android
==============

Appium Server setup for automated android testing using real devices

start a container by running:  

docker run --privileged -v /dev/bus/usb:/dev/bus/usb -i -p 4723:4723 aluedeke/appium-android:latest  

contains the following software:  

ubuntu 16.04  
openjdk 7  
nodejs  
appium server  
android sdk  
