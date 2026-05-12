# PKI and Certificate Authentication Notes

## Purpose

The first version of the lab used manually configured IPSec parameters and a static demonstration key. In a more realistic IPSec deployment, authentication should not rely on a shared static secret.

Certificate-based authentication provides stronger identity verification and scales better than pre-shared keys.

## Key Concepts

| Concept | Meaning |
|---|---|
| PSK | Pre-shared key; both peers know the same secret |
| PKI | Public Key Infrastructure; trust system based on certificates |
| CA | Certificate Authority; trusted signer of certificates |
| Certificate | Digital identity document for an endpoint |
| Private key | Secret key held by the endpoint |
| Public key | Key embedded in the certificate and shared publicly |
| NSS database | Certificate database used by Libreswan |
| certutil | Tool used to manage certificates in NSS |

## Why Certificates Are Better Than PSKs

| Area | PSK | Certificate Authentication |
|---|---|---|
| Identity | Proves knowledge of a shared secret | Proves possession of a private key tied to a certificate |
| Scalability | Harder to manage across many peers | Easier to manage across many peers |
| Revocation | Requires changing shared secrets | Certificates can be revoked or rotated |
| Auditability | Weak endpoint identity | Stronger per-endpoint identity |

## Example Certificate Flow

1. Create a local Certificate Authority
2. Issue one certificate for the left endpoint
3. Issue one certificate for the right endpoint
4. Configure Libreswan to use RSA signature authentication
5. Reference certificates by nickname

Example Libreswan config:

```ini
conn gre-tunnel
  authby=rsasig
  auto=start
  left=192.168.100.1
  leftcert=left
  right=192.168.100.2
  rightcert=right
  type=transport
  phase2=esp
  phase2alg=aes256-sha256
  ike=aes256-sha256;modp2048
  keyingtries=3