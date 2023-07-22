#!/bin/bash
set -e
echo "Downloading toolchain.."

pushd $LFS/sources

case "$FETCH_TOOLCHAIN_MODE" in
  "0")
    
    echo "Downloading LFS packages.."
    echo "Getting wget-list.."
    wget --timestamping https://www.linuxfromscratch.org/museum/lfs-museum/8.4-systemd-rc1/wget-list

    echo "Getting packages.."
    wget --timestamping --continue --input-file=wget-list
    wget --timestamping https://kernel.c3sl.ufpr.br/pub/linux/docs/man-pages/Archive/man-pages-4.16.tar.gz
    wget --timestamping https://ftp.osuosl.org/pub/lfs/lfs-packages/8.4/lfs-bootscripts-20180820.tar.bz2
    wget --timestamping https://toolchains.bootlin.com/downloads/releases/sources/zlib-1.2.11/zlib-1.2.11.tar.xz
    wget --timestamping https://toolchains.bootlin.com/downloads/releases/sources/expat-2.2.6/expat-2.2.6.tar.bz2
    wget --timestamping https://www.linuxfromscratch.org/patches/downloads/systemd/systemd-240-security_fixes-2.patch
    wget --timestamping http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/8.4/file-5.36.tar.gz
    wget --timestamping https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.20.12.tar.xz

    echo "Getting md5.."
    wget --timestamping https://www.linuxfromscratch.org/museum/lfs-museum/8.4-systemd-rc1/md5sums

    echo "Check hashes.."
    md5sum -c md5sums

    echo "Downloading syslinux package.."
    wget --timestamping https://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-6.03.tar.xz
    echo "Check hash.."
    echo "26d3986d2bea109d5dc0e4f8c4822a459276cf021125e8c9f23c3cca5d8c850e $LFS/sources/syslinux-6.03.tar.xz" | sha256sum -c -
    ;;
  "1")
    echo "Assume toolchain from host is already placed in sources folder"
    ;;
  "2")
    ;;
  *)
    echo "Undefined way to get toolchain!"
    false
    ;;
esac

popd
