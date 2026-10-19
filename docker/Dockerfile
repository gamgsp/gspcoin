FROM debian:stretch
LABEL maintainer="Gspcoin Developers <dev@gspcoin.us>"
LABEL description="Dockerised GspCoin"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
