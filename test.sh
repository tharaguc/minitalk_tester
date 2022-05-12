#!/bin/bash

make

if [ $# != 2 ]; then
	echo "Usage: ./$(basename "$0") [text] [n]"
	exit 1
fi

echo -e "\n===================="
(./server > result.txt) &

SERVER_PID=`ps | grep "./server" | grep -v "grep" | awk '{print$1}'`

python3 -c "print('${1}' * ${2})" > test.txt

MSG=`cat test.txt`

./client $SERVER_PID $MSG
echo -e "\n" >> result.txt

diff result.txt test.txt
rm -rf result.txt test.txt

kill $SERVER_PID
echo "===================="