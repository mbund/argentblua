FROM quay.io/fedora-ostree-desktops/silverblue:38

COPY etc /etc

RUN rpm-ostree install gnome-tweaks

RUN systemctl enable rpm-ostreed-automatic.timer
RUN systemctl enable tailscaled.service

RUN ostree container commit
