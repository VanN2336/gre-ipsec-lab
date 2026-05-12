#!/bin/bash

# GRE over IPSec Lab Setup
# Creates two network namespaces, connects them with a veth pair,
# builds a GRE tunnel, and protects GRE traffic with IPSec ESP using XFRM.

ip netns add left 2>/dev/null || true
ip netns add right 2>/dev/null || true

ip link add veth-left type veth peer name veth-right 2>/dev/null || true

ip link set veth-left netns left 2>/dev/null || true
ip link set veth-right netns right 2>/dev/null || true

ip netns exec left ip addr add 192.168.100.1/24 dev veth-left 2>/dev/null || true
ip netns exec right ip addr add 192.168.100.2/24 dev veth-right 2>/dev/null || true

ip netns exec left ip link set veth-left up
ip netns exec right ip link set veth-right up

ip netns exec left ip tunnel add gre1 \
  mode gre \
  local 192.168.100.1 \
  remote 192.168.100.2 \
  dev veth-left 2>/dev/null || true

ip netns exec right ip tunnel add gre1 \
  mode gre \
  local 192.168.100.2 \
  remote 192.168.100.1 \
  dev veth-right 2>/dev/null || true

ip netns exec left ip addr add 10.0.0.1/30 dev gre1 2>/dev/null || true
ip netns exec right ip addr add 10.0.0.2/30 dev gre1 2>/dev/null || true

ip netns exec left ip link set gre1 up
ip netns exec right ip link set gre1 up

KEY=0x0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f20

ip netns exec left ip xfrm state add \
  src 192.168.100.1 dst 192.168.100.2 \
  proto esp spi 0x1001 mode transport \
  auth "hmac(sha256)" $KEY enc aes $KEY 2>/dev/null || true

ip netns exec right ip xfrm state add \
  src 192.168.100.1 dst 192.168.100.2 \
  proto esp spi 0x1001 mode transport \
  auth "hmac(sha256)" $KEY enc aes $KEY 2>/dev/null || true

ip netns exec right ip xfrm state add \
  src 192.168.100.2 dst 192.168.100.1 \
  proto esp spi 0x1002 mode transport \
  auth "hmac(sha256)" $KEY enc aes $KEY 2>/dev/null || true

ip netns exec left ip xfrm state add \
  src 192.168.100.2 dst 192.168.100.1 \
  proto esp spi 0x1002 mode transport \
  auth "hmac(sha256)" $KEY enc aes $KEY 2>/dev/null || true

ip netns exec left ip xfrm policy add \
  src 192.168.100.1 dst 192.168.100.2 proto 47 dir out \
  tmpl src 192.168.100.1 dst 192.168.100.2 proto esp mode transport 2>/dev/null || true

ip netns exec right ip xfrm policy add \
  src 192.168.100.1 dst 192.168.100.2 proto 47 dir in \
  tmpl src 192.168.100.1 dst 192.168.100.2 proto esp mode transport 2>/dev/null || true

ip netns exec right ip xfrm policy add \
  src 192.168.100.2 dst 192.168.100.1 proto 47 dir out \
  tmpl src 192.168.100.2 dst 192.168.100.1 proto esp mode transport 2>/dev/null || true

ip netns exec left ip xfrm policy add \
  src 192.168.100.2 dst 192.168.100.1 proto 47 dir in \
  tmpl src 192.168.100.2 dst 192.168.100.1 proto esp mode transport 2>/dev/null || true

echo "GRE over IPSec lab tunnel is up."
