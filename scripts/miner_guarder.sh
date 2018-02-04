#!/bin/bash

yestoday=`date -d "-1 day" "+%Y%m%d"`
sleep_seconds=60
function check_and_boot()
{
	cd /bcdn
	miner_pid=`ps -ef | grep -w bcdn | grep -v grep | awk '{print $2}'`
	if [ x"${miner_pid}" = x ];
	then
		echo `date '+%Y-%m-%d %H:%M:%S'`":Exception occurs,trying to restart miner."
		# kill server process
		pid=`ps -ef | grep -w bcdn_server| grep -v grep | awk '{print $2}'`
		if [ x"${pid}" != x ]; then
			echo "Try to stop orignal bcdn_server: "$pid
			kill -9 ${pid}
		fi
                nohup ./bcdn &
		if [ $? -ne 0 ];then
			sleep_seconds=20
		else
			sleep_seconds=60
		fi
        fi
	# check date and split the log
	pre_day=`date -d "-1 day" "+%Y%m%d"`
	if [ x$yestoday != x$pre_day ]; then
		split -b 65535000 -d -a 2 nohup.out log/log_${pre_day}_ 
		cat /dev/null > nohup.out
		yestoday=$pre_day
	fi
}

if [ $CODE ]; then
	echo "Write miner code: "$CODE
	echo $CODE > /bcdn/conf/code.txt
fi
check_and_boot;
while sleep ${sleep_seconds}; do
	# check process
	check_and_boot;
done

