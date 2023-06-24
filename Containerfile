FROM quay.io/fedora-ostree-desktops/silverblue:38

COPY etc /etc

RUN systemctl enable rpm-ostreed-automatic.timer
RUN systemctl enable dconf-update.service

RUN rpm-ostree install tailscale
# RUN systemctl enable tailscaled.service

RUN rpm-ostree install gnome-tweaks
RUN rpm-ostree install codium
RUN rpm-ostree install fish
RUN rpm-ostree install powertop
RUN rpm-ostree install iotop
RUN rpm-ostree install podman-compose podman-docker podman-plugins podman-tui dbus-x11
RUN rpm-ostree install qemu qemu-user-static qemu-user-binfmt virt-manager libvirt qemu qemu-user-static qemu-user-binfmt edk2-ovmf
RUN rpm-ostree install cockpit cockpit-system cockpit-networkmanager cockpit-selinux cockpit-storaged cockpit-podman cockpit-machines cockpit-pcp
RUN rpm-ostree install cargo nodejs-npm rust
RUN rpm-ostree install p7zip p7zip-plugins

COPY --from=cgr.dev/chainguard/kubectl:latest /usr/bin/kubectl /usr/bin/kubectl
COPY --from=cgr.dev/chainguard/helm:latest /usr/bin/helm /usr/bin/helm
COPY --from=cgr.dev/chainguard/cosign:latest /usr/bin/cosign /usr/bin/cosign

RUN sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/user.conf
RUN sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/system.conf

RUN rm -rf /tmp/* /var/*
RUN ostree container commit
