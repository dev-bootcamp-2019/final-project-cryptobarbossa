#!/bin/bash
value=$(<active.txt)

if [ "$value" = "false" ]
then
node balance.js > balance.txt;
python3 balance.py;
fi
