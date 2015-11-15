FROM ubuntu:14.04
MAINTAINER jocolloman <gamepsychos@gmail.com>

RUN apt-get update
RUN apt-get install -y wget git
RUN apt-get install -y haskell-platform
RUN apt-get install -y python
RUN apt-get install -y zip unzip
ADD conf/known_hosts /root/.ssh/known_hosts
ADD conf/id_rsa /root/.ssh/id_rsa
RUN eval "$(ssh-agent -s)"; ssh-add /root/.ssh/id_rsa
RUN git config --global user.email "gamepsychos@gmail.com"
RUN git config --global user.name "jocolloman"
WORKDIR /repos/
RUN git clone git@github.com:jocolloman/scl-mods
RUN git clone git@github.com:jocolloman/SCL-Text-Assets

ADD files /files
ADD scripts /scripts
WORKDIR /files
