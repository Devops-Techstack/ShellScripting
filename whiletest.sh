#!/bin/bash
echo "while demo......"
while read -r line;
do
	echo "$line"
done < test.txt
