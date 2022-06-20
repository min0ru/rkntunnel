#!/bin/bash

sudo ipset destroy vpn

echo "create vpn hash:net family inet hashsize 16384 maxelem 20000000" > /tmp/vpn.ipset

echo "Downloading antifilter list"
wget https://antifilter.download/list/allyouneed.lst -O /tmp/antifilter-allyouneed.lst

echo "Downloading banned ip list"
#wget https://reestr.rublacklist.net/api/v2/ips/csv -q -O - | sed '/:/d' - | tr "," " " | tr -d " " | sort -u > /tmp/rublacklist.txt 
#echo "" >> /tmp/rublacklist.txt

echo "Downloading zapret-info ip list"
#wget https://github.com/zapret-info/z-i/raw/master/dump.csv -q -O - | tail -n +2 | cut -f1 -d ";" - | tr "| " "\n" | grep '\.' | sort -u > /tmp/zapret.txt

echo "Downloading domain list"
#wget https://github.com/zapret-info/z-i/raw/master/nxdomain.txt -q -O /tmp/zapret-domains.txt

echo "Downloading tor enter points list"
wget https://check.torproject.org/torbulkexitlist -q -O /tmp/tor-ips.txt

echo "Resolving custom domains"
cat domains/* | xargs -P16 dig +short | sort -u \
    | xargs -P16 dig +short | sort -u \
    | xargs -P16 dig +short | sort -u \
    | xargs -P16 dig +short | sort -u \
    | xargs -P16 dig +short | sort -u \
    | xargs -P16 dig +short | sort -u \
    > /tmp/custom-ips.txt

echo "Resolving custom domains second time with google DNS"
cat domains/* | xargs -P16 dig @8.8.8.8 +short | sort -u \
    | xargs -P16 dig @8.8.8.8 +short | sort -u \
    | xargs -P16 dig @8.8.8.8 +short | sort -u \
    | xargs -P16 dig @8.8.8.8 +short | sort -u \
    | xargs -P16 dig @8.8.8.8 +short | sort -u \
    | xargs -P16 dig @8.8.8.8 +short | sort -u \
    >> /tmp/custom-ips.txt

echo "Resolving custom domains second time with cloudflare DNS"
cat domains/* | xargs -P16 dig @1.1.1.1 +short | sort -u \
    | xargs -P16 dig @1.1.1.1 +short | sort -u \
    | xargs -P16 dig @1.1.1.1 +short | sort -u \
    | xargs -P16 dig @1.1.1.1 +short | sort -u \
    | xargs -P16 dig @1.1.1.1 +short | sort -u \
    | xargs -P16 dig @1.1.1.1 +short | sort -u \
    >> /tmp/custom-ips.txt

echo "Resolving custom domains third time with yandex DNS"
cat domains/* | xargs -P16 dig @77.88.8.1 +short | sort -u \
    | xargs -P16 dig @77.88.8.1 +short | sort -u \
    | xargs -P16 dig @77.88.8.1 +short | sort -u \
    | xargs -P16 dig @77.88.8.1 +short | sort -u \
    | xargs -P16 dig @77.88.8.1 +short | sort -u \
    | xargs -P16 dig @77.88.8.1 +short | sort -u \
    >> /tmp/custom-ips.txt

echo "Ckleaning custom ips from duplicates"
sort -u /tmp/custom-ips.txt -o /tmp/custom-ips.txt

echo "Creating combined ip list"
#cat /tmp/rublacklist.txt /tmp/zapret.txt /tmp/tor-ips.txt /tmp/custom-ips.txt | sed '/^[[:space:]]*$/d' | sort -u | sed 's/^/add vpn /' >> /tmp/vpn.ipset
cat /tmp/antifilter-allyouneed.lst /tmp/tor-ips.txt /tmp/custom-ips.txt | sed '/^[[:space:]]*$/d' | sort -u | sed 's/^/add vpn /' >> /tmp/vpn.ipset

echo "Loading ipset"
sudo ipset restore -f /tmp/vpn.ipset

echo "Total ipset ip address number: `sudo ipset list vpn | wc -l`"

sudo iptables -t mangle -A PREROUTING -m set --match-set vpn dst -j MARK --set-mark 51820
sudo iptables -t mangle -A OUTPUT -m set --match-set vpn dst -j MARK --set-mark 51820
