#!/bin/bash
# set -e
# echo "Using GRUB to setup the boot process.."

# echo "NOTE: skipped. Check 8.4 chapter of LFS book for details"

# #cd /tmp
# #grub-mkrescue --output=grub-img.iso
# #xorriso -as cdrecord -v dev=/dev/cdrw blank=as_needed grub-img.iso

# # install GRUB
# grub-install /dev/sda

# create grub config
cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,2)

menuentry "GNU/Linux, Linux 4.20.12-lfs-8.4-systemd" {
        linux   /boot/vmlinuz-4.20.12-lfs-8.4-systemd root=/dev/sda2 ro
}
EOF
