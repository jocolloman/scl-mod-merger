FROM ubuntu:14.04
MAINTAINER jocolloman <gamepsychos@gmail.com>

RUN apt-get update
RUN apt-get install -y wget git
RUN apt-get install -y haskell-platform

