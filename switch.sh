#!/bin/bash
no=$1
flg=$2

if [ ! -e /sys/class/gpio/gpio${no} ]
then
    echo $no > /sys/class/gpio/export
    echo out > /sys/class/gpio/gpio${no}/direction
fi
echo $flg > /sys/class/gpio/gpio${no}/value

