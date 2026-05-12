# Persistence Notes

## Purpose

The initial GRE/IPSec lab is temporary. Network namespaces, veth interfaces, GRE tunnels, XFRM states, and XFRM policies exist in memory and disappear after reboot.

To make the lab repeatable, the setup commands were moved into an idempotent shell script.

## Idempotent Script Design

The setup script uses:

```bash
2>/dev/null || true