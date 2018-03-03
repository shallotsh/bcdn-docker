FROM ubuntu:latest

MAINTAINER Gary Shallotsh "shallotsh@gmail.com"

RUN apt-get update && apt-get install -y zip wget golang

WORKDIR /root
#RUN wget wget https://storage.googleapis.com/golang/go1.9.1.linux-amd64.tar.gz

#RUN tar -C /usr/local -zxvf go1.9.1.linux-amd64.tar.gz && \
	#rm go1.9.1.linux-amd64.tar.gz && \
	#mkdir -p /root/go/src && \
	#echo "export GOPATH=$HOME/go" >> /root/.bashrc && \
	#echo "export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin" >> /root/.bashrc 

RUN apt-get install -y g++ autoconf automake libtool curl make && \
	apt-get install -y libssl-dev libevent-dev

WORKDIR /root

RUN wget https://github.com/google/protobuf/releases/download/v2.6.1/protobuf-2.6.1.tar.gz
RUN tar -zxvf protobuf-2.6.1.tar.gz && \
	rm protobuf-2.6.1.tar.gz
WORKDIR protobuf-2.6.1/
RUN ./autogen.sh && \
	./configure && \
	make && make install
 
WORKDIR /root
RUN wget https://dl.mybcdn.com//dev//2018-02-23-v0.0.94-61.tar.gz
RUN tar -zxvf 2018-02-23-v0.0.94-61.tar.gz && \
	rm 2018-02-23-v0.0.94-61.tar.gz
COPY scripts/ /root/script/
RUN chmod 755 /root/script/miner_boot.sh
#CMD "/bcdn/miner_guarder.sh"

