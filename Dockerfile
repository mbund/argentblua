FROM quay.io/fedora/fedora-silverblue:41

RUN rpm-ostree install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
RUN rpm-ostree install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
RUN rpm-ostree uninstall ffmpeg-free libavcodec-free libavdevice-free libavfilter-free libavformat-free libavutil-free libpostproc-free libswresample-free libswscale-free
RUN rpm-ostree install ffmpeg intel-media-driver

COPY etc /etc

RUN systemctl enable rpm-ostreed-automatic.timer
RUN systemctl enable sshd.service

RUN rpm-ostree install tailscale
RUN systemctl enable tailscaled.service

RUN rpm-ostree install waydroid
RUN systemctl enable waydroid-container.service

# add rpm fusion
# RUN rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# install codecs for h.264 and va-api
# RUN rpm-ostree install ffmpeg-free libavcodec-freeworld intel-media-driver

RUN rpm-ostree install dbus-x11 qemu qemu-user-static qemu-user-binfmt virt-manager libvirt qemu qemu-user-static qemu-user-binfmt edk2-ovmf
RUN rpm-ostree install adw-gtk3-theme papirus-icon-theme
RUN rpm-ostree install gnome-tweaks gparted evolution
RUN rpm-ostree install powertop iotop
RUN rpm-ostree install docker-ce
RUN rpm-ostree install fish alacritty

RUN rm -rf /tmp/* /var/*
RUN ostree container commit
