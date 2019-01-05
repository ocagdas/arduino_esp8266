FROM ubuntu:bionic-20180821

# change sh from, possibly, dash to bash
RUN cd /bin && rm sh && ln -s bash sh

# apt
RUN apt-get update -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	--no-install-recommends apt-utils

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	vim bash-completion sudo

# build-essential and other build/make package
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	build-essential make cmake cmake-curses-gui python3 \
	flex bison automake bc

# nice to have extras
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	curl wget

# user setup
RUN useradd docker -d /home/docker -m -s /bin/bash && \
 	passwd -d docker && \
	echo "docker  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers; echo "Defaults    !requiretty" >> /etc/sudoers

# Replace 1000 with your user / group id
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        software-properties-common \
	openjdk-11-jdk \
	xvfb \
        xz-utils \
	git
#    && add-apt-repository ppa:ubuntuhandbook1/apps \
#    && apt-get update \
#    && apt-get install -y avrdude avrdude-doc \

RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq \
		libgtk2.0 \
		libcanberra-gtk-module \
		libcanberra-gtk3-module

RUN apt-get clean \
	&& apt-get autoremove -y
#	&& rm -rf /var/lib/{apt,dpkg,cache,log}/

# Add docker user to the dialout group to be ale to write the serial USB device
RUN sed "s/^dialout.*/&docker/" /etc/group -i \
    && sed "s/^root.*/&docker/" /etc/group -i

ENV ARDUINO_IDE_VERSION 1.8.8
RUN (wget -q -O- https://downloads.arduino.cc/arduino-${ARDUINO_IDE_VERSION}-linux64.tar.xz \
	| tar xJC /usr/local/share \
	&& ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION} /usr/local/share/arduino \
	&& ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION}/arduino /usr/local/bin/arduino)

RUN cd /usr/local/share/arduino/hardware && mkdir esp8266com && cd esp8266com &&\
	git clone https://github.com/esp8266/Arduino.git esp8266 &&\
	cd esp8266/tools &&\
	python get.py && \
	cd ../ && \
	git submodule update --init

ENV DISPLAY :1.0

USER docker

ENV HOME /home/docker
ENV EXPORT_DIR /export
VOLUME ["$EXPORT_DIR"]
WORKDIR $EXPORT_DIR

#ENTRYPOINT ["tail", "-f", "/dev/null"]

