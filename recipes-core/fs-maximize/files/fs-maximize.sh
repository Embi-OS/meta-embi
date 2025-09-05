#!/bin/sh
# resize the rootfs ext filesystem size to its full partition size
# usually used on first boot in a postinstall script
# or set in an autostart file from a postinstall script

DISK=@ROOTFS_DISK@
PART=@ROOTFS_PART@

# resize now
parted -s $DISK resizepart 2 100%
resize2fs $PART

reboot

