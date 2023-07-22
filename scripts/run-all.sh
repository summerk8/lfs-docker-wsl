#!/bin/bash
set -e
echo "Start.."

# check versions
sh /tools/version-check.sh


# prepare to build
sh /tools/run-prepare.sh

read -p "Press any key to start build ..."

# execute rest as root
exec sudo -E -u root /bin/sh - <<EOF
#  change ownership
chown -R root:root $LFS/tools
# prevent "bad interpreter: Text file busy"
sync
# continue
sh /tools/run-build.sh

sh /tools/run-image.sh
EOF

