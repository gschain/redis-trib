#!/bin/bash

if [ $# != 2 ]
then
    echo "parse error! not equal 2"
    exit -1
fi

replicas=$1
nodes=$2
echo $nodes
arrNode=(${nodes// / })

sleep 8

while true
do
flag=true
for node in ${arrNode[@]}
do
    echo $node
    hostIp=(${node//:/ })
    echo ${hostIp[0]}:${hostIp[1]}
    eval "/usr/local/bin/redis-cli -h ${hostIp[0]} -p ${hostIp[1]} ping"
    if [ $? != 0 ];then
         flag=flase
    fi
done

if [ $flag == true ];then
    break
fi
sleep 5
done

echo "cluster all nodes ping success!"

hosts=""
for node in ${arrNode[@]}
do
    hostIp=(${node//:/ })
    hosts+="\`dig +short ${hostIp[0]}\`:${hostIp[1]} "
done

echo $hosts
eval "/usr/local/bin/redis-cli --cluster create --cluster-replicas $replicas $hosts"
