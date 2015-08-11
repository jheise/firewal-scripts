#!/bin/sh
echo -n "clearing all firewall rules...   "
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
echo "done"

echo -n "Blocking all traffic that is not expected..."
iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -s localhost -j ACCEPT
iptables -A INPUT -j REJECT
echo "done"
