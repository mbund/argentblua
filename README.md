[![Build Argentblua Badge](https://github.com/mbund/argentblua/actions/workflows/build.yaml/badge.svg)](https://github.com/mbund/argentblua/actions/workflows/build.yaml)

With Fedora Silverblue, we can cleanly separate a powerful immutable operating system base from its user facing applications. Building on top of Silverblue with a simple [Dockerfile](Dockerfile), we can create an automatically updating operating system base, with nearly guaranteed stability, and distribute it through a world-class CDN for free using GitHub.

## Changes

The following are installed/configured

- Automatic nightly updates, staged for the next reboot
- Installed [Docker](https://docker.com) (alongside the normal [Podman](https://podman.io))
- Installed [Tailscale](https://tailscale.com)
- Installed [Waydroid](https://waydro.id)
- Installed QEMU and [virt-manager](https://virt-manager.org)
- Working hardware accelerated media codecs (for Intel CPUs only)

## Usage

Rebase a normal installation of [Fedora Silverblue](https://silverblue.fedoraproject.org).

```
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/rebelandroid/argentblua:latest
```
