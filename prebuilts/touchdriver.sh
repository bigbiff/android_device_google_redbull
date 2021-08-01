#!/system/bin/sh

fastboot=$(getprop ro.boot.bootreason | cut -d, -F2)
if [[ $fastboot == "bootloader" || $fastboot == "longkey" || $fastboot == "reboot" ]]
then
	insmod /ftm5.ko
	insmod /sec_touch.ko
fi
if [[ $fastboot == "recovery" || $fastboot == "reboot,recovery" ]]
then
	twrp mount vendor
	cp /vendor/lib/modules/heatmap.ko /
	cp /vendor/lib/modules/touch_offload.ko /
	cp /vendor/lib/modules/ftm5.ko /
	cp /vendor/lib/modules/sec_touch.ko /
	twrp unmount vendor
	insmod /heatmap.ko
	insmod /touch_offload.ko
	insmod /ftm5.ko
	insmod /sec_touch.ko
fi
