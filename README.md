[![build-argentblua](https://github.com/mbund/argentblua/actions/workflows/build.yaml/badge.svg)](https://github.com/mbund/argentblua/actions/workflows/build.yaml)

With Fedora Silverblue, we can cleanly separate a powerful immutable operating system base from its user facing applications. Building on top of Silverblue with a simple [Containerfile](Containerfile), we can create an automatically updating operating system base, with nearly guaranteed stability, and distribute it through a world-class CDN for free using GitHub.

## Usage

Rebase a normal installation of [Fedora Silverblue](https://silverblue.fedoraproject.org). It will check for updates every hour, and will apply them the next time you reboot.

```
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mbund/argentblua:latest
```
