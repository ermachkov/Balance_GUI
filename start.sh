#!/bin/bash

export MOUSE="1"

if [ `lsusb -v 2> /dev/null| grep -i mouse -c` -eq 0 ]; then
  export MOUSE="0"
fi

if [ `lsusb -v 2> /dev/null| grep -i egalax -c` -gt 0 ]; then
    export MOUSE="2";
fi

DEFAULT_ROUTER=`netstat -r -n | awk '/^0.0.0.0/ {print}'`
DEFAULT_GW=`echo $DEFAULT_ROUTER | awk '{print($2)}'`
INT=`echo $DEFAULT_ROUTER | awk '{print($8)}'`
IFCONFIG=`ifconfig $INT`
IP_ADDRESS=`expr "$IFCONFIG" : '.*addr:\(.*\)\sBcast'`
NETMASK=`expr "$IFCONFIG" : '.*Mask:\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\).*'`
RESOLV=`cat /etc/resolv.conf`
DNS=`expr "$RESOLV" : '.*nameserver \([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\).*'`

SETTINGS=`cat /home/test/.Sibek/Balance/3.0/Balance.xml | grep -v "</clres:resources>" | grep -v local_addr | grep -v netmask | grep -v gateway | grep -v dns | grep -v input_dev`

echo $SETTINGS | sed -e 's/\/>/\/>\n/g' | sed -e 's/> </>\n </' > /home/test/.Sibek/Balance/3.0/Balance.xml
echo " <clres:option clres:name=\"gateway\" value=\"$DEFAULT_GW\"/>" >> /home/test/.Sibek/Balance/3.0/Balance.xml
echo " <clres:option clres:name=\"local_addr\" value=\"$IP_ADDRESS\"/>" >> /home/test/.Sibek/Balance/3.0/Balance.xml
echo " <clres:option clres:name=\"netmask\" value=\"$NETMASK\"/>" >> /home/test/.Sibek/Balance/3.0/Balance.xml
echo " <clres:option clres:name=\"dns\" value=\"$DNS\"/>" >> /home/test/.Sibek/Balance/3.0/Balance.xml
echo " <clres:option clres:name=\"input_dev\" value=\"$MOUSE\"/>" >> /home/test/.Sibek/Balance/3.0/Balance.xml
echo "</clres:resources>" >> /home/test/.Sibek/Balance/3.0/Balance.xml

balance
