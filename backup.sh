#!/bin/bash

backup_dirs=("/etc" "/home")
dest_dir="/root/backup_today"
mkdir -p $dest_dir
backup_date=$(date +%b-%d-%y)

echo "Starting backup of: ${backup_dirs[@]}"

for i in "${backup_dirs[@]}"; do
sudo tar -Pczf /tmp/$i-$backup_date.tar.gz $i
if [ $? -eq 0 ]; then
echo "$i backup succeeded."
else
echo "$i backup failed."
fi
cp /tmp/$i-$backup_date.tar.gz $dest_dir
if [ $? -eq 0 ]; then
echo "$i transfer succeeded."
else
echo "$i transfer failed."
fi
done

sudo rm /tmp/*.gz
echo "Backup is done."
