FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt install -y curl xz-utils && \
    curl https://dl.winehq.org/wine-builds/winehq.key -o /usr/share/keyrings/winehq-archive.key && \
    curl https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources -o /etc/apt/sources.list.d/winehq-jammy.sources && \
    curl https://xpra.org/xpra-2022.gpg -o /usr/share/keyrings/xpra-2022.gpg && \
    curl https://xpra.org/repos/jammy/xpra.list -o /etc/apt/sources.list.d/xpra.list && \
    dpkg --add-architecture i386 && \
    apt update && \
    apt install -y --no-install-recommends winehq-staging && \
    apt install -y --no-install-recommends xpra xpra-html5 && \
    apt install -y --no-install-recommends xdotool xterm && \
    mkdir /opt/wine-staging/share/wine/mono && \
    curl https://dl.winehq.org/wine/wine-mono/7.3.0/wine-mono-7.3.0-x86.tar.xz -o - | tar -xJv -C /opt/wine-staging/share/wine/mono && \
    mkdir /opt/wine-staging/share/wine/gecko && \
    curl https://dl.winehq.org/wine/wine-gecko/2.47.2/wine-gecko-2.47.2-x86.msi -o /opt/wine-staging/share/wine/gecko/wine-gecko-2.47.2-x86.msi && \
    curl https://dl.winehq.org/wine/wine-gecko/2.47.2/wine-gecko-2.47.2-x86_64.msi -o /opt/wine-staging/share/wine/gecko/wine-gecko-2.47.2-x86_64.msi && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 14500

ENV DISPLAY :0

CMD ["/usr/bin/xpra", "start", "--bind-tcp=0.0.0.0:14500", "--html=on", "--exit-with-children=yes", "--daemon=no", "--notifications=no", "--dbus-proxy=no", "--dbus-control=no", "--dbus-launch=no", "--systemd-run=no", "--bell=no", "--start-child=xterm"]
