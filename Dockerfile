FROM archlinux/base:latest

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x entrypoint.sh && \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed base-devel && \
    yes | pacman -Scc && \
    useradd -u 1000 -d /home/builder -m builder && \
    echo 'builder ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers

ENTRYPOINT ["/entrypoint.sh"]
