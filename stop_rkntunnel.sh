#!/bin/bash

echo "Disabling iptables rules"
sudo iptables -t nat -D OUTPUT -p tcp -m set --match-set rkn dst -j REDSOCKS
sudo iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12345

echo "Destroying ipset"
sudo ipset destroy rkn

echo "Done!"
