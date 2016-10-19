#!/bin/sh
IP=/sbin/iptables
ZERO=$1
WIFI=wlan0

echo -n "clearing old rules...   "
# flush old rules
$IP --flush
$IP -X
echo "done"

echo -n "Forward traffic from $ZERO to $WIFI...   "
$IP -t nat -A POSTROUTING --out-interface $WIFI -j MASQUERADE
$IP -A FORWARD --in-interface $ZERO -j ACCEPT
echo "done"

echo "firewall complete, zero should have access"
