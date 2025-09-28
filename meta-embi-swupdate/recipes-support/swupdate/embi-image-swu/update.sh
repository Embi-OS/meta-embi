#!/bin/sh

if [ $# -lt 1 ]; then
    exit 0;
fi

function get_current_root_device
{
    # Extract current root partition from kernel cmdline (PARTUUID)
    PARTUUID=$(sed -n 's/.*root=PARTUUID=\([^ ]*\).*/\1/p' /proc/cmdline)
    CURRENT_ROOT=$(readlink -f "/dev/disk/by-partuuid/$PARTUUID")
}

function get_update_part
{
    CURRENT_PART="${CURRENT_ROOT: -1}"
    if [ $CURRENT_PART = "2" ]; then
        UPDATE_PART="3";
    else
        UPDATE_PART="2";
    fi
}

function get_update_device
{
    UPDATE_ROOT=${CURRENT_ROOT%?}${UPDATE_PART}
}

function format_update_device
{
    umount -q $UPDATE_ROOT
    if [ $UPDATE_PART = "2" ]; then
        mkfs.ext4 -q $UPDATE_ROOT -L RFS1 -E nodiscard
    else
        mkfs.ext4 -q $UPDATE_ROOT -L RFS2 -E nodiscard
    fi
}

if [ $1 == "preinst" ]; then
    echo "[update.sh] Running preinst"

    get_current_root_device
    get_update_part
    get_update_device

    echo "[update.sh] Current root: $CURRENT_ROOT (part $CURRENT_PART)"
    echo "[update.sh] Update target: $UPDATE_ROOT (part $UPDATE_PART)"

    format_update_device

    ln -sf "$UPDATE_ROOT" /dev/update
    echo "[update.sh] Created symlink /dev/update -> $UPDATE_ROOT"
fi

if [ $1 == "postinst" ]; then
    echo "[update.sh] Running postinst"

    get_current_root_device
    get_update_part
    get_update_device

    echo "[update.sh] Setting U-Boot environment variable distro_rootpart=$UPDATE_PART"
    fw_setenv distro_rootpart "$UPDATE_PART"

    echo "[update.sh] Update prepared. Next boot will use rootfs on partition $UPDATE_PART"
fi
