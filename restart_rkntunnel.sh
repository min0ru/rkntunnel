#!/bin/bash

echo "Restarting rkntunnel"
./stop_rkntunnel.sh
./rkntunnel.sh
echo "Done restarting"
