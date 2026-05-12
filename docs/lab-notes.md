# Lab Notes: GRE over IPSec

## Purpose

This lab was built to understand how GRE tunneling and IPSec encryption work at the Linux networking level.

The lab uses two Linux network namespaces, `left` and `right`, to simulate two separate VPN endpoints on one RHEL host. A veth pair connects the namespaces, a GRE tunnel is built between them, and IPSec ESP is applied using Linux XFRM.

## Core Concepts

| Concept | Meaning |
|---|---|
| Network namespace | Isolated Linux network stack used to simulate a separate host |
| veth pair | Virtual Ethernet pair that acts like a cable between namespaces |
| GRE | Generic Routing Encapsulation; creates a tunnel but does not encrypt traffic |
| IPSec ESP | Encrypts and protects traffic |
| XFRM | Linux kernel framework used for IPSec state and policy |
| Security Association | Defines crypto parameters for IPSec traffic |
| Security Policy | Defines which traffic must be protected by IPSec |

## Lab Flow

1. Create two namespaces: `left` and `right`
2. Create a veth pair between them
3. Assign underlay IPs:
   - `192.168.100.1`
   - `192.168.100.2`
4. Build GRE tunnel interfaces:
   - `10.0.0.1`
   - `10.0.0.2`
5. Add IPSec ESP Security Associations using `ip xfrm state`
6. Add IPSec policies using `ip xfrm policy`
7. Verify connectivity and encryption

## Verification

The lab was verified with:

```bash
ip netns list
ip netns exec left ping 192.168.100.2 -c 4
ip netns exec left ping 10.0.0.2 -c 4
ip netns exec left ip xfrm state
ip netns exec left ip xfrm policy