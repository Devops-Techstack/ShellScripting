#!/bin/bash

 # Define the mount point or device
 MOUNT_POINT="/mnt/wsl/docker-desktop/docker-desktop-user-distro"  # Change to your mount point(The directory where the disk is mounted)
 DEVICE="/dev/sdc"         # Change to your disk/device

 # Function to check if disk is in use
 #This function checks if there are any processes using files on the disk using the lsof +D command.
 #If the disk is in use, it will print an error message and return a non-zero exit code (1), preventing unmounting.

 check_disk_usage() {
     lsof +D "$MOUNT_POINT" > /dev/null 2>&1
     if [ $? -eq 0 ]; then
         echo "Error: Disk is still in use. Please close all files and processes accessing the disk."
         return 1
     else
         return 0
     fi
 }
 #The script first checks whether the disk is mounted using mount | grep.
 # If the disk is not mounted, it will print an error message and exit.
 # Check if the disk is mounted
 if mount | grep "on $MOUNT_POINT " > /dev/null; then
     echo "Disk is mounted at $MOUNT_POINT."

     # Step 1: Ensure no files are in use on the disk
     echo "Checking if disk is in use..."
     if ! check_disk_usage; then
         echo "Unable to unmount disk. Please stop processes using the disk."
         exit 1
     fi
 #The script tries to unmount the disk using sudo umount. If the unmount is successful, it prints a success message.
 # If it fails, it suggests that the disk may need to be forcefully unmounted (though this is avoided in this script).
     # Step 2: Attempt to unmount the disk
     echo "Attempting to unmount $DEVICE at $MOUNT_POINT..."
     sudo umount "$MOUNT_POINT"

     # Check if umount was successful
     if [ $? -eq 0 ]; then
         echo "Successfully unmounted $DEVICE from $MOUNT_POINT."
     else
         echo "Error: Failed to unmount $DEVICE. You may need to force unmount."
     fi
 #The script handles errors gracefully by printing messages and exiting when necessary (e.g., if the disk is in use or not mounted).
 else
     echo "Error: $DEVICE is not mounted at $MOUNT_POINT."
     exit 1
 fi
