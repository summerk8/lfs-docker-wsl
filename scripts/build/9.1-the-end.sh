#!/bin/bash
set -e
echo "Finalize LFS configuration.."

# LFS version file
echo 8.4 > /etc/lfs-release

# LSB version file
cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="8.4"
DISTRIB_CODENAME="summerk"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF

# OS-Release version file
cat > /etc/os-release << "EOF"
NAME="Linux From Scratch"
VERSION="8.4-systemd"
ID=lfs
PRETTY_NAME="Linux From Scratch 8.4-systemd"
VERSION_CODENAME="$DISTRIB_CODENAME"
EOF

# define empty password for root
cat > /etc/shadow << "EOF"
root::12699:0:::::
EOF

# add login logo
cat > /etc/issue << "EOF"
███████╗██╗   ██╗███╗   ███╗███╗   ███╗███████╗██████╗      ██████╗ ███████╗
██╔════╝██║   ██║████╗ ████║████╗ ████║██╔════╝██╔══██╗    ██╔═══██╗██╔════╝
███████╗██║   ██║██╔████╔██║██╔████╔██║█████╗  ██████╔╝    ██║   ██║███████╗
╚════██║██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══╝  ██╔══██╗    ██║   ██║╚════██║
███████║╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║███████╗██║  ██║    ╚██████╔╝███████║
╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝     ╚═════╝ ╚══════╝
EOF
