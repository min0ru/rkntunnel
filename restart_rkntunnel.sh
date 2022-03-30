#!/bin/bash

date
echo "Restarting rkntunnel"
./stop_rkntunnel.sh
./rkntunnel.sh
echo "Done restarting"
