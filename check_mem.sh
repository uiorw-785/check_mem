#!/bin/bash
DATE=$(date +%F" "%H:%M)
IP=$(ifconfig eth0 |awk -F"[ :]+" '/inet addr/{print $4}')  
MAIL="example@mail.com"
TOTAL=$(free -m |awk  '/Mem/{print $2}' )
USE=$(free -m |awk  '/Mem/{print $3-$6-$7}' )
FREE=$(($TOTAL-$USE))
if [ $FREE -lt 1024 ]; then
    echo "
    Date: $DATE
    Host: $IP
    Problem: Total=$TOTAL,Use=$USE,Free=$FREE
    " | mail -s "Memory Monitor" $MAIL
fi
