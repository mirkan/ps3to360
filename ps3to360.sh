#!/bin/bash 
#DEVICE=$1
DS3=$1
##PID_FILE=”/tmp/xboxdrv_pid”
PID_FILE="/tmp/xboxdrv_pid$(echo $DEVICE | sed 's/\//_/g')"


LOGFILE=/tmp/xboxdrv_udev.log
echo "RUN: at `date` by `whoami` action: $ACTION \$1 $1 DEVPATH $DEVPATH DEVNAME $DEVNAME" >> ${LOGFILE}
function fixPerm () {
	chmod 600 $DS3
}
function axisConf () {
	xboxdrv -d -c /home/robin/.config/xboxdrv.conf &
	PID=$!
	echo “$PID” > $PID_FILE
}

if [[ “$ACTION” == “add” ]]; then
	fixPerm
	axisConf	
fi
if [[ “$ACTION” == “remove” ]]; then
	PID=$(cat $PID_FILE)
	kill -9 $PID #SIGKILL is needed because the xboxdrv process can get stuck
fi
