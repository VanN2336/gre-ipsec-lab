#!/bin/bash

echo "=== Network namespaces ==="
ip netns list

echo
echo "=== Underlay connectivity: left to right veth IP ==="
ip netns exec left ping 192.168.100.2 -c 4

echo
echo "=== GRE tunnel connectivity: left GRE IP to right GRE IP ==="
ip netns exec left ping 10.0.0.2 -c 4

echo
echo "=== Left XFRM state ==="
ip netns exec left ip xfrm state

echo
echo "=== Right XFRM state ==="
ip netns exec right ip xfrm state

echo
echo "=== Left XFRM policy ==="
ip netns exec left ip xfrm policy

echo
echo "=== Right XFRM policy ==="
ip netns exec right ip xfrm policy
