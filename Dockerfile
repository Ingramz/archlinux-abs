FROM archlinux:base-devel

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x entrypoint.sh && \
    useradd -u 1000 -d /home/builder -m builder && \
    echo 'builder ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers

ENTRYPOINT ["/entrypoint.sh"]
