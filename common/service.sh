#!/system/bin/sh
MODDIR=${0%/*}
while true;do 
	BOOT=$(getprop sys.boot_completed);
	if [ "$BOOT" -eq "1" ];then
	 sleep 9;break;
	else 
		sleep 3;
	fi;
done;
/system/etc/fde.ai/r.bin &

