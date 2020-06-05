FROM archlinux/base:latest

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed base-devel && \
    yes | pacman -Scc && \
    useradd -u 1000 -d /home/builder -m builder && \
    echo 'builder ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers && \
     && \
    chown -R builder /build /repo

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
