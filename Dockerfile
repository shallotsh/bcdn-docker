FROM ubuntu:latest

MAINTAINER Gary Shallotsh "shallotsh@gmail.com"

RUN apt-get update && apt-get install -y zip

ADD M_BerryMiner_Ubuntu.zip /

RUN unzip M_BerryMiner_Ubuntu.zip
WORKDIR /M_BerryMiner_Ubuntu

RUN tar -C /usr/local -zxvf go1.9.1.linux-amd64.tar.gz && \
	mkdir -p /root/go/src && \
	echo "export GOPATH=$HOME/go" >> /root/.bashrc && \
	echo "export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin" >> /root/.bashrc 

RUN apt-get install -y g++ autoconf automake libtool curl make && \
	apt-get install -y libssl-dev

WORKDIR /M_BerryMiner_Ubuntu
RUN unzip Libevent-release-2.1.8-stable.zip
WORKDIR /M_BerryMiner_Ubuntu/Libevent-release-2.1.8-stable

RUN /M_BerryMiner_Ubuntu/Libevent-release-2.1.8-stable/autogen.sh && \
	/M_BerryMiner_Ubuntu/Libevent-release-2.1.8-stable/configure --prefix=/usr && \
 make && make install

WORKDIR /M_BerryMiner_Ubuntu
RUN unzip protobuf-master.zip
WORKDIR /M_BerryMiner_Ubuntu/protobuf-master
RUN /M_BerryMiner_Ubuntu/protobuf-master/autogen.sh && \
	/M_BerryMiner_Ubuntu/protobuf-master/configure && \
	make && make install
 
WORKDIR /M_BerryMiner_Ubuntu
RUN mv /M_BerryMiner_Ubuntu/M_BerryMiner_ubuntu_v1_0/server /bcdn
COPY scripts/ /bcdn/
WORKDIR /bcdn
RUN chmod 755 *.sh && \
	chmod 755 /bcdn/bcdn && \
	chmod 755 /bcdn/bin/bcdn_server

CMD "/bcdn/miner_guarder.sh"

