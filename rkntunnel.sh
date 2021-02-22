#!/bin/bash

autossh rkntunnel-tor -D 1080 -fN

echo "Initializing iptables"
sudo iptables -t nat -N REDSOCKS
sudo iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12345

echo "Initializing ipset"
sudo ipset destroy rkn
#sudo ipset create rkn hash:net maxelem 20000000
#sudo ipset flush rkn

echo "create rkn hash:net family inet hashsize 16384 maxelem 20000000" > /tmp/rkn.ipset

echo "Downloading banned ip list"
wget https://reestr.rublacklist.net/api/v2/ips/csv -q -O - | sed '/:/d' - | tr "," " " | sed 's/^/add rkn /' - >> /tmp/rkn.ipset
#for ip in $(wget https://reestr.rublacklist.net/api/v2/ips/csv -q -O - | sed '/:/d' - | tr "," " ")
#do
#    >&2 echo -n ". "
#	sudo ipset -A rkn ${ip}
#done

echo "Loading ipset"
sudo ipset restore -f /tmp/rkn.ipset

echo "Total ipset ip address number: `sudo ipset list rkn | wc -l`"

echo "Adding insane subnet list"
cat blocked_subnets | while read subnet
do
    echo "Subnet from subnet_list: $subnet"
    sudo ipset add rkn ${subnet}
done

echo "Enabling iptables rule"
sudo iptables -t nat -A OUTPUT -p tcp -m set --match-set rkn dst -j REDSOCKS

echo "Done! Fuck RKN!"
