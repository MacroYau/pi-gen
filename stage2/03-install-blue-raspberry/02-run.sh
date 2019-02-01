#!/bin/bash -e

mkdir -p "${ROOTFS_DIR}/usr/share/blue-raspberry"

git clone https://github.com/MacroYau/BlueRaspberry.git files/src/

install -m 644 files/src/app.js "${ROOTFS_DIR}/usr/share/blue-raspberry/"
install -m 644 files/src/pi-wifi-wrapper.js "${ROOTFS_DIR}/usr/share/blue-raspberry/"
install -m 644 files/src/connectivity-service.js "${ROOTFS_DIR}/usr/share/blue-raspberry/"
install -m 644 files/src/wifi-config-service.js "${ROOTFS_DIR}/usr/share/blue-raspberry/"

on_chroot << EOF
npm install bleno wireless-tools child_process async
EOF

install -m 644 files/blue-raspberry.service "${ROOTFS_DIR}/etc/systemd/system/"

on_chroot << EOF
systemctl daemon-reload
systemctl enable blue-raspberry
EOF
