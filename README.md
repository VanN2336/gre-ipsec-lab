# Secure GRE over IPsec Site-to-Site VPN Lab

## Overview
This project implements a secure site-to-site VPN using GRE tunnels protected by IPsec encryption. It simulates enterprise-style connectivity between two remote networks over an untrusted transport network.

The design combines:
- GRE for dynamic routing over a virtual point-to-point tunnel
- IPsec for confidentiality, integrity, and authentication of traffic

---

## Architecture Summary
Two remote LANs are connected through a simulated WAN environment. A GRE tunnel provides logical connectivity for routing protocols, while IPsec secures all tunnel traffic between endpoints.

(See `/architecture/topology.png`)

---

## Core Technologies
- GRE Tunnels
- IPsec (IKE Phase 1 & Phase 2)
- Cisco IOS (GNS3 / Packet Tracer / EVE-NG)
- Static routing / OSPF (depending on implementation)

---

## Key Skills Demonstrated
- Secure VPN design and implementation
- IPsec encryption configuration and troubleshooting
- GRE tunneling for routing extension
- Network validation and diagnostic analysis
- End-to-end connectivity verification

---

## Validation Strategy
This project includes structured validation to confirm correct operation:

- LAN-to-LAN connectivity tests
- IPsec Security Association verification
- GRE tunnel interface validation
- Routing table verification

See `/validation` for test cases and expected outputs.
