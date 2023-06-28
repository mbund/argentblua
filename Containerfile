FROM quay.io/fedora-ostree-desktops/silverblue:38

COPY etc /etc

RUN sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/user.conf
RUN sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/system.conf

RUN systemctl enable rpm-ostreed-automatic.timer
RUN systemctl enable dconf-update.service
RUN systemctl enable sshd.service

RUN rpm-ostree install tailscale
RUN systemctl enable tailscaled.service

RUN rpm-ostree install podman-compose podman-docker podman-plugins podman-tui dbus-x11
RUN rpm-ostree install qemu qemu-user-static qemu-user-binfmt virt-manager libvirt qemu qemu-user-static qemu-user-binfmt edk2-ovmf
RUN rpm-ostree install cockpit-bridge cockpit-doc cockpit-kdump cockpit-networkmanager cockpit-packagekit cockpit-pcp cockpit-selinux cockpit-sosreport cockpit-storaged cockpit-system cockpit-tests cockpit-ostree cockpit-podman cockpit-machines libvirt-client libvirt-dbus tuned-utils virt-install
RUN rpm-ostree install adw-gtk3-theme papirus-icon-theme
RUN rpm-ostree install gnome-tweaks
RUN rpm-ostree install libgda libgda-sqlite
RUN rpm-ostree install p7zip p7zip-plugins
RUN rpm-ostree install codium fish gh
RUN rpm-ostree install powertop iotop

RUN rm -rf /tmp/* /var/*
RUN ostree container commit
