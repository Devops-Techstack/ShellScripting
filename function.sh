#!/bin/bash
echo "This is function test"
disk_utilization()
{
disk=`df -h`
echo "disk utiliation is : $disk "
}
if [[ $? -eq 0 ]];
then
    echo "this is disk usage report"
    disk_utilization
else
    echo "disk has some issue "
fi
