#!/bin/bash
#Author: DevopsTechStack
#Installing mutliple packages

if [[ $# -eq 0 ]]
then
  echo "Usage: please provide software names as command line arguments"
  exit 1
fi


if [[ $(id -u) -ne 0 ]]
then
  echo "Please run from root user or with sudo privilage"
  exit 2
fi


for softwares in $@
do
  if which $softwares &> /dev/null
  then
     echo "Already $softwares is installed"
  else
     echo "Installing $softwares ......"
     yum install $softwares -y &> /dev/null
     if [[ $? -eq 0 ]]
     then
       echo "Successfully installed $softwares packages"
     else
       echo "Unable to install  $softwares"
     fi
  fi

done
