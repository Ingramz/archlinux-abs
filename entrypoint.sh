#!/bin/sh

su -l builder -c "echo $PRIVATE_KEY | gpg --import"
su -l builder -c "echo $PUBLIC_KEY | gpg --import"
pacman -Syu --nonconfirm
mkdir /build
cp -r * /build
chown -R builder /build
su -l builder -c 'cd /build && PACKAGER=$PACKAGER GPGKEY=$GPGKEY makepkg --sign --noconfirm -s'
mkdir /repo
mv /build/*.pkg.tar.xz /build/*.pkg.tar.xz.sign /repo
cd /repo
repo-add $REPONAME.db *.pkg.tar.xz
mv /repo $GITHUB_WORKSPACE
