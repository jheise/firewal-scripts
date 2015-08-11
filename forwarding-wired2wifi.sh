#!/bin/sh
IP=/sbin/iptables
WIRED=eth0
WIRELESS=wlan0

echo -n "clearing old rules...   "
# flush old rules
$IP --flush
$IP -X
echo "done"

echo -n "Forward traffic from $WIRED to $WIRELESS"
$IP -t nat -A POSTROUTING --out-interface $WIRELESS -j MASQUERADE
$IP -A FORWARD --in-interface $WIRED -j ACCEPT
echo "done"

echo "firewall complete, ssh proxy required"
