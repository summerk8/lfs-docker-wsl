#!/bin/bash
set -e
echo "Building M4.."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 31 MB"

# 6.14. The M4 package contains a macro processor.
tar -xf /sources/m4-*.tar.xz -C /tmp/ \
  && mv /tmp/m4-* /tmp/m4 \
  && pushd /tmp/m4

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h

./configure --prefix=/usr
make
if [ $LFS_TEST -eq 1 ]; then make check; fi
make install

popd \
  && rm -rf /tmp/m4
