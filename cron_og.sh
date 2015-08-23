#!/bin/bash
BASE=/root/src/opengate
cnt=$(ps -ef |grep "$BASE/og.sh"|grep -v grep|wc -l)

if [ $cnt -eq 0 ]
then
    nohup $BASE/og.sh >> /tmp/og.log &
fi

