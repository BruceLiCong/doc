#!/bin/bash
# mount
sudo mount /dev/xvdf /home/ubuntu/tc-server
sleep 5s

cd tc-server

# another way to run bnet server
# nohup but cannot be interactive, redirect output automatically
# tail -f to check the nohup.out
# nohup ./bin/bnetserver &
# 
# wait for the bnetser to end execution
#sleep 5s


# screen run the bnet server 
screen -dmS bnet bash -c './bin/bnetserver; exec bash'

sleep 10s

# screen run the world server interactively
screen -dmS world bash -c './bin/worldserver; exec bash'



