#!/bin/bash

function start()
{
	cd /bcdn
	if [ $CODE ]; then
		echo "write miner code: "$CODE
		echo $CODE > /bcdn/conf/code.txt
	fi

	nohup ./miner_guarder.sh &

	echo "Miner boot completed!!"
}

stop()
{
	monitor_pid=`ps -ef | grep -w miner_guarder.sh | grep -v grep | awk '{print $2}'`
	if [ ${monitor_pid} ];then
		kill -9 ${monitor_pid}
	fi

	sleep_pid=`ps -ef | grep -w sleep | grep -v grep | awk '{print $2}'`
	if [ ${sleep_pid} ];then
		kill -9 ${sleep_pid}
	fi
	echo "Miner demons stopped!"
}
if [ x"$1" = x"start" ];then
	echo "start..."
	start
elif [ x"$1" = x"stop" ];then
	echo "stop..."
	stop
else
	echo "Usage:$0 [start/stop]"
fi


