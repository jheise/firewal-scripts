#!/bin/sh
IP=/sbin/iptables
WIRELESS=wlan0
WIRED=eth0

echo -n "clearing old rules...   "
# flush old rules
$IP --flush
$IP -X
echo "done"
echo -n "setting default policy to drop...   "
# set default policy to drop
$IP -P INPUT DROP
$IP -P FORWARD DROP
$IP -P OUTPUT DROP
echo "done"

echo -n "allowing ssh out on wlan0...   "
# allow ssh out on wlan0
$IP -A OUTPUT -o $WIRELESS -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
$IP -A INPUT -i $WIRELESS -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
echo "done"

echo -n "allowing icmp on $WIRELESS...   "
# allow icmp out on $WIRELESS
$IP -A OUTPUT -o $WIRELESS -p icmp -j ACCEPT
$IP -A INPUT -i $WIRELESS -p icmp -j ACCEPT
echo "done"

echo -n "allowing dns request out on $WIRELESS...   "
# allow dns out on $WIRELESS
$IP -A OUTPUT -o $WIRELESS -p udp --dport 53 -j ACCEPT
$IP -A INPUT -i $WIRELESS -p udp --sport 53 -j ACCEPT
echo "done"

echo -n "allowing all traffic on eth0...   "
# allow all traffic on eth0
$IP -A INPUT -i $WIRED -j ACCEPT
$IP -A OUTPUT -o $WIRED -j ACCEPT
echo "done"

echo -n "allowing all traffic on lo...   "
$IP -A INPUT -s localhost -j ACCEPT
$IP -A OUTPUT -s localhost -j ACCEPT
echo "done"
echo "firewall complete, ssh proxy required"
