#!/bin/bash
echo "script to install git "
echo "Installation started"
if [ "$(uname)" == "Linux" ];
then
        echo "this is linux box,installing git"
        yum install git -y
elif [ "$(uname)" == "Darwin" ];
then
        echo "this is not linux box"
        echo "this is Macos"
        brew install git
else
        echo "not installing"
fi
