#!/bin/bash

env > statusenv.txt
rm -f statustemp.txt
rm -f statuslog_before.txt
echo "$MOVES_STATUS" > statustemp.txt

if [ -f "statuslog.txt" ]; then
    mv statuslog.txt statuslog_before.txt
    cat statuslog_before.txt statustemp.txt > statuslog.txt
else
    # If statuslog.txt doesn't exist, just use statustemp
    mv statustemp.txt statuslog.txt
fi
