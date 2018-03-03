#!/bin/bash

yestoday=`date -d "-1 day" "+%Y%m%d"`
sleep_seconds=1800
function split_log()
{	
	cd ~/
	# check date and split the log
	pre_day=`date -d "-1 day" "+%Y%m%d"`
	if [ x"$yestoday" != x"$pre_day" ]; then
		split -b 65535000 -d -a 2 log/log.txt log/log_${pre_day}_ 
		cat /dev/null > log/log.txt
		yestoday=$pre_day
	fi
}

if [ $CODE ]; then
	echo "Write miner code: "$CODE
	echo $CODE > /root/conf/code.txt
else
	echo "Code error"
fi

cd ~
./script/ctrl_bcdn.sh start

if [ $? -ne 0 ];then
	echo "miner boot error"
	exit
else
	echo "miner boot success"
fi
while sleep ${sleep_seconds}; do
	split_log
done

