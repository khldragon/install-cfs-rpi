#!/bin/bash

################################################################################
##
## Raspberry Pi Core Flight System Setup Script
## --------------------------------------------
##
## Dependencies: network access and git
##
################################################################################

## Clone the repository
if [ ! -d "cFE" ]; then
    echo -e ">> Downloading latest cFE from GitHub (this could take a while)"
    git clone https://github.com/nasa/cFE.git >> /dev/null
fi
cd cFE

## Setup the submodules
echo -e ">> Updating the submodules (this could take a while)"
git submodule init >> /dev/null
git submodule update >> /dev/null

## Sanitize for Raspberry Pi
## Get rid of -m32 and -melf_i386 flag
echo -e ">> Removing compiler flags not supported by Pi"
sed -i 's/-m32//g' psp/fsw/pc-linux/make/link-rules.mak psp/fsw/pc-linux/make/compiler-opts.mak tools/elf2cfetbl/for_build/Makefile
sed -i 's/-melf_i386//g' psp/fsw/pc-linux/make/compiler-opts.mak

## Clean & Build cFS
echo -e ">> Building cFS"
source setvars.sh
cd build/cpu1
echo -e "  >> Cleaning"
make clean >> /dev/null
echo -e "  >> Configuring"
make config >> /dev/null
echo -e "  >> Building (this could take a while)"
make >> /dev/null
cd ../../..

## Increase the message queue length
echo -e ">> Increasing message queue length"
echo 256 | sudo tee -a /proc/sys/fs/mqueue/msg_max >> /dev/null

echo -e ">> DONE. Run cFE/build/cpu1/exe/core-linux.bin"
