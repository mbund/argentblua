FROM quay.io/fedora-ostree-desktops/silverblue:39

COPY etc /etc

RUN systemctl enable rpm-ostreed-automatic.timer
RUN systemctl enable sshd.service

RUN rpm-ostree install tailscale
RUN systemctl enable tailscaled.service

RUN rpm-ostree install waydroid
RUN systemctl enable waydroid-container.service

RUN rpm-ostree install dbus-x11 qemu qemu-user-static qemu-user-binfmt virt-manager libvirt qemu qemu-user-static qemu-user-binfmt edk2-ovmf
RUN rpm-ostree install adw-gtk3-theme papirus-icon-theme
RUN rpm-ostree install gnome-tweaks gparted
RUN rpm-ostree install powertop iotop
RUN rpm-ostree install docker-ce
RUN rpm-ostree install fish alacritty

RUN rm -rf /tmp/* /var/*
RUN ostree container commit
