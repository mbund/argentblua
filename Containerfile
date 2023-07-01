FROM quay.io/fedora-ostree-desktops/silverblue:38

COPY etc /etc

RUN sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/user.conf
RUN sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/system.conf

RUN systemctl enable rpm-ostreed-automatic.timer
RUN systemctl enable dconf-update.service
RUN systemctl enable sshd.service

RUN rpm-ostree install tailscale
RUN systemctl enable tailscaled.service

RUN rpm-ostree install waydroid
RUN systemctl enable waydroid-container.service

RUN rpm-ostree install podman-compose podman-docker podman-plugins podman-tui dbus-x11
RUN rpm-ostree install qemu qemu-user-static qemu-user-binfmt virt-manager libvirt qemu qemu-user-static qemu-user-binfmt edk2-ovmf
RUN rpm-ostree install cockpit-bridge cockpit-doc cockpit-kdump cockpit-networkmanager cockpit-packagekit cockpit-pcp cockpit-selinux cockpit-sosreport cockpit-storaged cockpit-system cockpit-tests cockpit-ostree cockpit-podman cockpit-machines libvirt-client libvirt-dbus tuned-utils virt-install
RUN rpm-ostree install adw-gtk3-theme papirus-icon-theme
RUN rpm-ostree install gnome-tweaks gparted evolution evolution-ews
RUN rpm-ostree install libgda libgda-sqlite
RUN rpm-ostree install p7zip p7zip-plugins
RUN rpm-ostree install codium fish gh direnv
RUN rpm-ostree install powertop iotop btop
RUN rpm-ostree install bat exa git-delta duf helix ripgrep procs httpie zoxide
COPY --from=cgr.dev/chainguard/kubectl:latest /usr/bin/kubectl /usr/bin/kubectl
COPY --from=cgr.dev/chainguard/helm:latest /usr/bin/helm /usr/bin/helm
COPY --from=cgr.dev/chainguard/cosign:latest /usr/bin/cosign /usr/bin/cosign
COPY --from=cgr.dev/chainguard/terraform:latest /usr/bin/terraform /usr/bin/terraform
RUN curl -s https://cdn.teleport.dev/teleport-v13.1.2-linux-amd64-bin.tar.gz | tar -xzf - --strip-components=1 -C /usr/bin teleport/tsh

RUN rpm-ostree install tlp tlp-rdw stress-ng
RUN rpm-ostree override remove power-profiles-daemon
RUN systemctl enable tlp

RUN rm -rf /tmp/* /var/*
RUN ostree container commit
