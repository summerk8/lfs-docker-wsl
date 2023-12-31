#!/bin/bash
set -e

# 5.30. Python-3.8.1
# The Python 3 package contains the Python development environment.
# It is useful for object-oriented programming, writing scripts, prototyping
# large programs or developing entire applications. 

echo "Building python3..."
echo "Approximate build time: 1.3 SBU"
echo "Required disk space: 409 MB"

tar -xf Python-3*.tar.* -C /tmp/ \
  && mv /tmp/Python-* /tmp/python3 \
  && pushd /tmp/python3

sed -i '/def add_multiarch_paths/a \        return' setup.py

./configure --prefix=/tools --without-ensurepip

make 

make install

popd \
  && rm -rf /tmp/python3