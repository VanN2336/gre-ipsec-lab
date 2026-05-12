#!/bin/bash

# Deletes the lab network namespaces.
# Deleting the namespaces also removes the veth interfaces,
# GRE tunnels, XFRM states, and XFRM policies inside them.

ip netns delete left 2>/dev/null || true
ip netns delete right 2>/dev/null || true

echo "Lab cleanup complete."
