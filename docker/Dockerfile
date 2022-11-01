FROM debian:stretch
LABEL maintainer="Gspcoin Developers <dev@gspcoin.org>"
LABEL description="Dockerised GspCoin, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
