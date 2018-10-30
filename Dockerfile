############################################################
# Dockerfile to run appium for android devices
############################################################

FROM ubuntu:16.04
MAINTAINER Javier Hernán Caballero García

RUN apt-get update
RUN apt-get install -y wget

# install Android SDK dependencies
RUN apt-get install -y openjdk-8-jdk lib32z1 lib32ncurses5 lib32ncurses5 lib32stdc++6 g++-multilib zip unzip
    
# Main Android SDK
WORKDIR /opt
RUN wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN wget -q https://dl.google.com/android/repository/platform-26_r02.zip
RUN unzip -q sdk-tools-linux-4333796.zip -d android-sdk-linux
RUN rm sdk-tools-linux-4333796.zip
RUN unzip -q platform-26_r02.zip
RUN rm platform-26_r02.zip

RUN /opt/android-sdk-linux/tools/bin/sdkmanager --update

ENV ANDROID_HOME /opt/android-sdk-linux

RUN apt-get -y install software-properties-common build-essential curl
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN rm nodesource_setup.sh
RUN apt-get -y install nodejs

RUN npm install appium

RUN yes | /opt/android-sdk-linux/tools/bin/sdkmanager --licenses

RUN touch  /root/.android/repositories.cfg

RUN /opt/android-sdk-linux/tools/bin/sdkmanager "platforms;android-26"

RUN /opt/android-sdk-linux/tools/bin/sdkmanager "system-images;android-26;google_apis_playstore;x86"

RUN /opt/android-sdk-linux/tools/bin/avdmanager -v create avd --force --name testAVD --abi google_apis_playstore/x86 --package 'system-images;android-26;google_apis_playstore;x86' --device 'Nexus 5X'

EXPOSE 4723
CMD appium
