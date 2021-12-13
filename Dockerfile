FROM ubuntu:18.04 as builder
MAINTAINER	Eric Dorr <githubcode@mail.ericdorr.de>

WORKDIR /docker-cgminer-gekko
ENV         TZ=Europe/Berlin
RUN         ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN		    apt-get update -y
RUN         apt-get install zlib1g-dev zlib1g git build-essential autoconf automake libtool pkg-config libcurl4-openssl-dev libudev-dev libjansson-dev libncurses5-dev libusb-1.0-0-dev -y
RUN 	    git clone https://github.com/CoreTex/cgminer-gekko .
RUN		    CFLAGS="-O2 -march=native" ./autogen.sh
RUN		    ./configure --enable-gekko
RUN         make

FROM ubuntu:18.04
MAINTAINER	Eric Dorr <githubcode@mail.ericdorr.de>

WORKDIR /docker-cgminer-gekko
COPY --from=builder /docker-cgminer-gekko .
RUN		    apt-get -y update
RUN         apt-get -y install curl
RUN 		ls -lah
ENTRYPOINT	["./cgminer"]
