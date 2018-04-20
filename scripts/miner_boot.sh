#!/bin/bash

if [ $CODE ]; then
	echo "Write miner code: "$CODE
	echo $CODE > /root/M_BerryMiner_Ubuntu_v4/conf/code.txt
else
	echo "Code error"
	exit
fi

while true; do
	cd /root/M_BerryMiner_Ubuntu_v4/
	./currBCDN
        retval=$?
        if [ $retval -eq 4 ]; then
                exit $retval
        fi
        echo "================Restart BCDN @"`date "+%Y/%m/%d %H:%M:%S"`"================"
done

