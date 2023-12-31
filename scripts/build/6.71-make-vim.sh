#!/bin/bash
#set -e
echo "Building vim.."
echo "Approximate build time: 1.1 SBU"
echo "Required disk space: 128 MB"

# 6.77. Vim package contains a powerful text editor
tar -xf /sources/vim-*.tar.bz2 -C /tmp/ \
  && mv /tmp/vim* /tmp/vim \
  && pushd /tmp/vim

# change default location of the vimrc configuration file to /etc
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h


# prepare Vim for compilation:
./configure --prefix=/usr
make
if [ $LFS_TEST -eq 1 ]; then make -j1 test &> vim-test.log; fi
LANG=en_US.UTF-8 make -j1 test &> vim-test.log

make install
# create symlink for vi
ln -sv vim /usr/bin/vi
for L in /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done
ln -sv ../vim/vim81/doc /usr/share/doc/vim-8.1

# 6.70.2. Configuring Vim
cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1 

set nocompatible
set backspace=2
set mouse=
syntax on
if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF

# touch ~/.vimrc
# cleanup
popd \
  && rm -rf /tmp/vim
