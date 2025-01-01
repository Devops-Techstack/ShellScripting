#!/bin/bash

echo "Checking users with root privileges..."

# 1. Users with UID 0 (direct root access)
echo "Users with UID 0 (direct root access):"
awk -F: '$3 == 0 {print $1}' /etc/passwd

# 2. Users in the 'sudo' group (indirect root access via sudo)
echo "Users in the 'sudo' group:"
getent group sudo | awk -F: '{print $4}' | tr ',' '\n'

# 3. Users explicitly granted sudo privileges in the sudoers file
echo "Users with explicit sudo privileges in /etc/sudoers:"
awk '/^[^#].*ALL=\(ALL\)/ {print $1}' /etc/sudoers

# 4. Users in files under /etc/sudoers.d (additional sudo privileges)
echo "Users with sudo privileges in /etc/sudoers.d:"
for file in /etc/sudoers.d/*; do
  [ -f "$file" ] && awk '/^[^#].*ALL=\(ALL\)/ {print $1}' "$file"
done
