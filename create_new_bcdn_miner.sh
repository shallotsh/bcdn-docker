#!/bin/bash
if [ ! -n $2 ];then
	echo "Miner code is null. [$2] Already exit!"
fi
sudo docker run -tdi --name $1 -e CODE=$2 shallotsh/bcdn:v3.1 /root/script/miner_boot.sh
