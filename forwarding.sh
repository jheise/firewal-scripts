#!/bin/sh
IP=/sbin/iptables
WIRED=eth0
VPN=tap0

echo -n "clearing old rules...   "
# flush old rules
$IP --flush
$IP -X
echo "done"

echo -n "Forward traffic from $WIRED to $VPN...   "
$IP -t nat -A POSTROUTING --out-interface $VPN -j MASQUERADE
$IP -A FORWARD --in-interface $WIRED -j ACCEPT
echo "done"

echo "firewall complete, ssh proxy required"
