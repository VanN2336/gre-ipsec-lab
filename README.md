# GRE over IPSec Lab on RHEL 9

## Overview

This project documents a GRE-over-IPSec lab built on a RHEL 9 Linux host.

The lab uses Linux network namespaces to simulate two isolated VPN endpoints on one system. The endpoints are connected with a virtual Ethernet pair, a GRE tunnel is built between them, and GRE traffic is protected with IPSec ESP using Linux XFRM.

A second phase adds boot persistence with systemd, persistent kernel parameter tuning with sysctl, and certificate-based IPSec authentication using a local Certificate Authority.

## Why I Built This

I built this lab to better understand how tunneling, IPSec encryption, Linux networking, and VPN authentication work below the GUI layer.

## Architecture

```text
+-----------------------------+             +-----------------------------+
| left namespace              |             | right namespace             |
|                             |             |                             |
| veth-left: 192.168.100.1    |<----------->| veth-right: 192.168.100.2   |
|                             |  veth pair  |                             |
| gre1: 10.0.0.1              |<===========>| gre1: 10.0.0.2              |
|                             | GRE tunnel  |                             |
+-----------------------------+             +-----------------------------+

GRE traffic between the two namespace endpoints is protected with IPSec ESP.

This lab uses a static demonstration key for manual XFRM configuration. It is not intended for production use. Production IPSec deployments should use proper IKE negotiation, key rotation, and certificate-based authentication.