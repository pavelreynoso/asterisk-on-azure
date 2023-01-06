FROM ubuntu:22.04

RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt -y install git curl wget libedit-dev libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev build-essential libjansson-dev libxml2-dev uuid-dev

WORKDIR /usr/src/
RUN curl -O http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
RUN tar xvf asterisk-16-current.tar.gz
RUN  cd asterisk-16*/ && contrib/scripts/get_mp3_source.sh && echo 'libvpb1 libvpb1/countrycode string 52' | debconf-set-selections -v && contrib/scripts/install_prereq
RUN cd asterisk-16*/ && ./configure && make && make install
RUN cd asterisk-16*/ && make samples && make config && ldconfig