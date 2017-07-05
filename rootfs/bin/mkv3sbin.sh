#!/bin/sh

echo " type $# ."
echo -e "----------------------------------------------------------------"
echo -e "spluboot\r\t\t\t512k\r\t\t\t\t\t0x00000000 - 0x007ffff"
echo -e "dts\r\t\t\t64k\r\t\t\t\t\t0x00080000 - 0x008ffff"
echo -e "kernel\r\t\t\t2560k\r\t\t\t\t\t0x00090000 - 0x030ffff"
echo -e "rootfs\r\t\t\t---k\r\t\t\t\t\t0x00310000 - end"
echo -e "----------------------------------------------------------------"

echo -e "Usage :\n\r\t$0 size bin bootloader dts kernel rootfs"

if [ $# -gt 1 ]
then
	echo "Make empty bin named $2 size $1"
	if [ "$1" == "16m" ]
	then
		dd if=/dev/zero of=$2 bs=16M count=1		
	elif [ "$1" == "8m" ]
	then
		dd if=/dev/zero of=$2 bs=8M count=1		
	else
		echo "error !!!"
	fi
else
	echo "error !!!"
fi

# uboot
if [ $# -gt 2 ]
then
	dd if=$3 of=$2 bs=1K conv=notrunc
fi

# dts
if [ $# -gt 3 ]
then
	dd if=$4 of=$2 bs=1K seek=512 conv=notrunc
fi

# kernel
if [ $# -gt 4 ]
then
	dd if=$5 of=$2 bs=1K seek=576 conv=notrunc
fi

# rootfs
if [ $# -gt 5 ]
then
	dd if=$6 of=$2 bs=1K seek=3136 conv=notrunc
fi


