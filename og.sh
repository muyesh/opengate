#!/bin/bash
BASE=/root/src/opengate
tmpf=/tmp/ogflag
GETFLAG="curl -s http://localhost:8080/ogflag/index.html"

if [ ! -e $tmpf ]
then
    echo $($GETFLAG) > $tmpf
fi

while :
do
    sleep 5
    prev_flag=$(cat $tmpf)
    flag=$($GETFLAG)
    echo $(date)" : flag:[${flag}]  / pref:[${prev_flag}]"
    if [ -z $flag ] || [ -z $prev_flag ]
    then
        echo  $(date)" : maybe curl couldn't connect! so wait 15 sec" >&2
        # reset flags
        echo 0 > $tmpf
        prev_flag=0
        flag=0
        sleep 10
        echo $($GETFLAG) > $tmpf
        sleep 5
    elif [ $prev_flag -ne $flag ]
    then
        echo $prev_flag
        for i in {1..2}
        do
            echo $flag
            #echo $i
            echo $flag > $tmpf
            $BASE/switch.sh 17 1
            $BASE/switch.sh 18 1
            sleep 0.5
            for n in {1..3}
            do
                #echo $n
                $BASE/switch.sh 27 1
                sleep 0.3
                $BASE/switch.sh 27 0
                sleep 0.3
            done
            sleep 0.5
            $BASE/switch.sh 17 0
            $BASE/switch.sh 18 0
            sleep 2
        done
    fi
done
