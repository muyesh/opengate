#!/bin/bash
no=$1
if [ -e /sys/class/gpio/gpio${no} ]
then
    echo $no > /sys/class/gpio/unexport
fi

