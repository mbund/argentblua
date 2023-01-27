FROM quay.io/fedora-ostree-desktops/silverblue:37

COPY etc /etc

RUN rpm-ostree override remove firefox firefox-langpacks && \
    rpm-ostree install gnome-tweaks && \
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    ostree container commit
