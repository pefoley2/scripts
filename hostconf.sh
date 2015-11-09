#!/bin/bash
DIR=/root/kernel/hostkernel
SRC=/usr/src/linux
config() { echo CONFIG_$2=$1 >> .config; }
#rm -rf $DIR
mkdir -p $DIR
cd $DIR
make -C $SRC distclean &>log
make -C $SRC O=$DIR defconfig &>>log
config y KERNEL_XZ
config y IKCONFIG
config y IKCONFIG_PROC
config y EFI_STUB
config y KVM
config y KVM_INTEL
config y VHOST_NET
config y IGB
config y FB_VESA
config y KSM
config y MCORE2
config y USER_NS
config m TUN
config m BRIDGE
config m BRIDGE_NF_EBTABLES
config m BRIDGE_EBT_T_NAT
config y NETFILTER_ADVANCED
config m NETFILTER_XT_TARGET_CHECKSUM
config m NETFILTER_XT_MATCH_MULTIPORT
config y BLK_CGROUP
config m FUSE_FS
config m MACVLAN
config m MACVTAP
config y BTRFS_FS
yes "" | make oldconfig &>>log
rm -f .config.old
