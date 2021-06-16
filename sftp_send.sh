#!/bin/sh
PATH=$PATH:/usr/bin:/usr/sbin:/bin:/sbin

ip=`hostname -I`
date=`date '+%Y-%m-%d'`

result=`mkdir "/root/perl_script/result_log/"$date`

deletefile="*$(date +%Y-%m-%d --date='6 days ago')*"

Server_model=`dmidecode | grep "Product" | awk -F: '{print $2}'`
CPU_model=`cat /proc/cpuinfo | grep "model name" | awk -F: '{print $2}'`
CPU_physical_count=`cat /proc/cpuinfo | grep "physical id" | sort -su | wc -l`
Memory_full_size=`cat /proc/meminfo | grep MemTotal | awk -F: '{print $2}'`
Disk_info=`fdisk -l | grep "Disk /dev/"`


echo $result || :

echo "/root/perl_script/result_log/"$date"/"$ip"product_name.txt"
echo $Server_model >> "/root/perl_script/result_log/"$date"/"$ip"product_name.txt"
echo $CPU_model >> "/root/perl_script/result_log/"$date"/"$ip"product_name.txt"
echo $CPU_physical_count >> "/root/perl_script/result_log/"$date"/"$ip"product_name.txt"
echo $Memory_full_size >> "/root/perl_script/result_log/"$date"/"$ip"product_name.txt"
echo $Disk_info >> "/root/perl_script/result_log/"$date"/"$ip"product_name.txt"

echo "\"rm -rf /root/perl_script/result_log/\"$deletefile"
rm -rf "/root/perl_script/result_log/"$deletefile
