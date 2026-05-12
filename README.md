# GRE over IPSec VPN Lab (RHEL 9)

## Overview

This project demonstrates a GRE-over-IPSec VPN tunnel built on RHEL 9 using Linux networking primitives. The lab simulates two endpoints using network namespaces and connects them through a veth pair, then applies GRE tunneling protected by IPSec ESP using Linux XFRM.

---

## Lab Architecture

- Two network namespaces: `left` and `right`
- veth pair simulating a physical link
- GRE tunnel between endpoints
- IPSec ESP encryption using XFRM
- Static lab routing using private IP space

---

## Technologies Used

- RHEL 9 Linux
- Linux Network Namespaces
- veth interfaces
- GRE tunneling
- IPSec ESP (XFRM framework)
- Bash scripting
- systemd concepts
- PKI concepts (certificate-based authentication theory)

---

## Project Structure

```text id="v9q1lm"
gre-ipsec-lab/
├── scripts/        Setup, verification, cleanup scripts
├── docs/           Technical explanations and theory
├── output/         Command outputs and verification logs
├── diagrams/       Architecture explanation
├── screenshots/    Proof of execution (optional)
``` id="q2m8pw"

---

## Verification Steps

The lab was validated using:

- Namespace creation checks
- veth connectivity tests (ping)
- GRE tunnel connectivity tests
- XFRM state inspection
- XFRM policy verification

---

## Key Concepts Demonstrated

- GRE encapsulation vs IPSec encryption
- Linux XFRM Security Associations vs Policies
- Kernel-level packet transformation
- Namespace-based network isolation
- Persistence limitations in Linux networking labs

---

## Key Takeaways

- GRE provides tunneling but no encryption
- IPSec ESP provides encryption and integrity protection
- XFRM enforces kernel-level IPSec policy
- Network namespaces simulate real multi-host environments
- Clear documentation is as important as implementation

---

## Security Notes

This lab uses static keys and simplified configurations for educational purposes only. Production IPSec deployments should use IKE, certificate-based authentication, key rotation, and proper policy management.
