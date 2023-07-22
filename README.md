## Description

This repository contains docker configuration to build bootable iso
image with [Linux From Scratch 8.4-systemd](https://www.linuxfromscratch.org/museum/lfs-museum/8.4-systemd/LFS-BOOK-8.4-systemd-NOCHUNKS.html#ch-system-revisedchroot).

Software tools used in this project:
Windows 10, WSL, Ubuntu 22.04, Docker 

## Why

General idea is to learn and help everyone who wants to learn Linux by building and running LFS system.

## Structure

Scripts are organized in the way of following book structure whenever
it makes sense. Some deviations are done to make a bootable iso image.

## Build

Use the following command:

    docker rm lfs                                       && \
    docker build --tag lfs:8.4 .                        && \
    sudo docker run -it --privileged --name lfs lfs:8.4 && \
    sudo docker cp lfs:/tmp/lfs.iso .
    # Ramdisk you can find here: /tmp/ramdisk.img

Please note, that extended privileges are required by docker container
in order to execute some commands (e.g. mount).

## Usage

Final result is bootable iso image with LFS system which, for
example, can be used to load the system inside virtual machine (tested
with VMware Workstation).


## License

This work is based on instructions from [Linux from Scratch](http://www.linuxfromscratch.org/lfs)
project and provided with MIT license.

## Links

This project [is based on a true story](https://github.com/reinterpretcat/lfs)