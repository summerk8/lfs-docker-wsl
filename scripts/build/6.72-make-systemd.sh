#!/bin/bash
set -e

# 6.73. Systemd-244
# The systemd package contains programs for controlling the startup,
# running, and shutdown of the system. 

echo "Building systemd..."
echo "Approximate build time: 0.6 SBU"
echo "Required disk space: 238 MB"

tar -xf /sources/systemd-*.tar.gz -C /tmp/ \
  && mv /tmp/systemd* /tmp/systemd \
  && pushd /tmp/systemd

# Apply patch
patch -Np1 -i /sources/systemd-240-security_fixes-2.patch

# Create a symlink to work around missing xsltproc:
ln -sf /tools/bin/true /usr/bin/xsltproc

# Because we have not yet installed the final version of Util-Linux,
# create links to the libraries in the appropriate location:
for file in /tools/lib/lib{blkid,mount,uuid}*; do
  ln -sf "$file" /usr/lib/
done

# Set up the man pages:
tar -xf /sources/systemd-man-pages-240.tar.*

# Remove tests that cannot be built in chroot:
sed '177,$ d' -i src/resolve/meson.build

# Remove an unneeded group, render, from the default udev rules:
sed -i 's/GROUP="render", //' rules/50-udev-default.rules.in

# Prepare systemd for compilation:
mkdir -p build \
  && cd       build

PKG_CONFIG_PATH="/usr/lib/pkgconfig:/tools/lib/pkgconfig" \
LANG=en_US.UTF-8                   \
meson --prefix=/usr                \
      --sysconfdir=/etc            \
      --localstatedir=/var         \
      -Dblkid=true                 \
      -Dbuildtype=release          \
      -Ddefault-dnssec=no          \
      -Dfirstboot=false            \
      -Dinstall-tests=false        \
      -Dkill-path=/bin/kill        \
      -Dkmod-path=/bin/kmod        \
      -Dldconfig=false             \
      -Dmount-path=/bin/mount      \
      -Drootprefix=                \
      -Drootlibdir=/lib            \
      -Dsplit-usr=true             \
      -Dsulogin-path=/sbin/sulogin \
      -Dsysusers=false             \
      -Dumount-path=/bin/umount    \
      -Db_lto=false                \
      ..

# Compile the package:
LANG=en_US.UTF-8 ninja

# Install the package:
LANG=en_US.UTF-8 ninja install

# Remove an unnecessary symbolic link:
rm -rfv /usr/lib/rpm
rm -f /usr/bin/xsltproc

# Create the /etc/machine-id file needed by systemd-journald:
systemd-machine-id-setup

# Create the /lib/systemd/systemd-user-sessions script 
# to allow unprivileged user logins without systemd-logind: 
cat > /lib/systemd/systemd-user-sessions << "EOF"
#!/bin/bash
rm -f /run/nologin
EOF
chmod 755 /lib/systemd/systemd-user-sessions

popd \
  && rm -rf /tmp/systemd