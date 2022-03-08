 #!/bin/bash

echo "Disabling iptables rules"
sudo iptables -t mangle -D PREROUTING -m set --match-set vpn dst -j MARK --set-mark 51820
sudo iptables -t mangle -D OUTPUT -m set --match-set vpn dst -j MARK --set-mark 51820

echo "Destroying ipset"
sudo ipset destroy vpn

echo "Done!"
