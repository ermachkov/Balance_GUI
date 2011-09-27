#!/bin/bash

export MOUSE="1"

lsusb -v > /tmp/lsusb 2> /dev/null

if [ `grep -i mouse -c /tmp/lsusb` -eq 0 ]; then
  export MOUSE="0"
fi

if [ `grep -i egalax -c /tmp/lsusb` -gt 0 ]; then
    export MOUSE="2";
fi

rm /tmp/lsusb

SERVER_IP=`expr "\`cat $HOME/.Sibek/Balance/3.0/Balance.xml\`" : '.*server_addr" value="\([0-9]*.[0-9]*.[0-9]*.[0-9]*\)'`
export SERVER_ON="true"

if [ `ping $SERVER_IP -c 1 -W 1 | grep -c req=1` -eq 0 ]; then
  export SERVER_ON="false"
fi

DEFAULT_ROUTER=`netstat -r -n | awk '/^0.0.0.0/ {print}'`
DEFAULT_GW=`echo $DEFAULT_ROUTER | awk '{print($2)}'`
INT=`echo $DEFAULT_ROUTER | awk '{print($8)}'`
IFCONFIG=`ifconfig $INT`
IP_ADDRESS=`expr "$IFCONFIG" : '.*addr:\(.*\)\sBcast'`
NETMASK=`expr "$IFCONFIG" : '.*Mask:\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\).*'`
RESOLV=`cat /etc/resolv.conf`
DNS=`expr "$RESOLV" : '.*nameserver \([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\).*'`

SETTINGS=`cat $HOME/.Sibek/Balance/3.0/Balance.xml | grep -v "</clres:resources>" | grep -v local_addr | grep -v netmask | grep -v gateway | grep -v dns | grep -v input_dev`

echo $SETTINGS | sed -e 's/\/>/\/>\n/g' | sed -e 's/> </>\n </' > $HOME/.Sibek/Balance/3.0/Balance.xml
echo " <clres:option clres:name=\"gateway\" value=\"$DEFAULT_GW\"/>" >> $HOME/.Sibek/Balance/3.0/Balance.xml
echo " <clres:option clres:name=\"local_addr\" value=\"$IP_ADDRESS\"/>" >> $HOME/.Sibek/Balance/3.0/Balance.xml
echo " <clres:option clres:name=\"netmask\" value=\"$NETMASK\"/>" >> $HOME/.Sibek/Balance/3.0/Balance.xml
echo " <clres:option clres:name=\"dns\" value=\"$DNS\"/>" >> $HOME/.Sibek/Balance/3.0/Balance.xml
echo " <clres:option clres:name=\"input_dev\" value=\"$MOUSE\"/>" >> $HOME/.Sibek/Balance/3.0/Balance.xml
echo " <clres:option clres:name=\"server_status\" value=\"$SERVER_ON\"/>" >> $HOME/.Sibek/Balance/3.0/Balance.xml
echo "</clres:resources>" >> $HOME/.Sibek/Balance/3.0/Balance.xml

balance
