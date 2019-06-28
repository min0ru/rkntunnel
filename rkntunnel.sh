#!/bin/bash

ssh rkntunnel-tor -D 1080 -fN

echo "Initializing iptables"
sudo iptables -t nat -N REDSOCKS
sudo iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12345

echo "Initializing ipset"
sudo ipset destroy rkn
sudo ipset create rkn hash:net maxelem 20000000
sudo ipset flush rkn

echo "Downloading banned ip list"
#for ip in $(python3 antizapret_csv.py)
for ip in $(wget https://reestr.rublacklist.net/api/v2/ips/csv -q -O - | sed '/:/d' - | tr "," " ")
do
    #echo "Adding ip $ip"
    >&2 echo -n ". "
	sudo ipset -A rkn ${ip}
done

echo "Adding insane subnet list"
cat blocked_subnets | while read subnet
do
    echo "Subnet from subnet_list: $subnet"
    sudo ipset add rkn ${subnet}
done

echo "Enabling iptables rule"
sudo iptables -t nat -A OUTPUT -p tcp -m set --match-set rkn dst -j REDSOCKS

echo "Done! Fuck RKN!"
