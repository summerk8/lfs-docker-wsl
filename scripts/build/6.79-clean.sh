#!/bin/bash
set -e
echo "Cleaning up.."

# 6.80. Cleaning Up


rm -rf /tmp/*


exit


chroot "$LFS" /usr/bin/env -i          \
    HOME=/root TERM="$TERM"            \
    PS1='(lfs chroot) \u:\w\$ '        \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash --login

# cleanup leftovers
rm -rf /usr/lib/lib{bfd,opcodes}.a
rm -rf /usr/lib/libbz2.a
rm -rf /usr/lib/lib{com_err,e2p,ext2fs,ss}.a
rm -rf /usr/lib/libltdl.a
rm -rf /usr/lib/libfl.a
rm -rf /usr/lib/libfl_pic.a
rm -rf /usr/lib/libz.a

find /usr/lib /usr/libexec -name \*.la -delete