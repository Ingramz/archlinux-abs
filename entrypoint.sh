#!/bin/sh

su - -w PRIVATE_KEY builder -c 'echo "$PRIVATE_KEY" | gpg --import --no-tty --batch --yes'
pacman -Syu --noconfirm
mkdir /build
cp -r * /build
chown -R builder /build
su - -w PACKAGER,GPGKEY builder -c 'cd /build && makepkg --sign --noconfirm -s'
mkdir /repo
mv /build/*.pkg.tar.xz /build/*.pkg.tar.xz.sign /repo
cd /repo
repo-add $REPONAME.db *.pkg.tar.xz
mv /repo $GITHUB_WORKSPACE
