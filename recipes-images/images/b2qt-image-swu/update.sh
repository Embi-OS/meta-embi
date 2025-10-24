#!/bin/sh

set -eu

if [ $# -lt 1 ]; then
    exit 0
fi

BOOT_PART_MOUNTPOINT=${BOOT_PART_MOUNTPOINT:-/boot}
PERSISTENT_BOOT_BACKUP_DIR=${PERSISTENT_BOOT_BACKUP_DIR:-/config/boot-persistent}
PERSISTENT_BOOT_PATTERNS=${PERSISTENT_BOOT_PATTERNS:-"uboot.env config.txt"}
BOOT_PART=${BOOT_PART:-"1"}

log() {
    echo "[update.sh] $*"
}

get_current_root_device() {
    PARTUUID=$(sed -n 's/.*root=PARTUUID=\([^ ]*\).*/\1/p' /proc/cmdline)
    CURRENT_ROOT=$(readlink -f "/dev/disk/by-partuuid/$PARTUUID")
}

get_update_part() {
    CURRENT_PART="${CURRENT_ROOT: -1}"
    if [ -z "$CURRENT_PART" ]; then
        log "Unable to determine rootfs partition number from $CURRENT_ROOT"
        exit 1
    fi
    if [ "$CURRENT_PART" = "2" ]; then
        UPDATE_PART="3"
    else
        UPDATE_PART="2"
    fi
}

get_update_device() {
    CURRENT_BASE=${CURRENT_ROOT%${CURRENT_PART}}
    UPDATE_ROOT="${CURRENT_BASE}${UPDATE_PART}"
    UPDATE_BOOT="${CURRENT_BASE}${BOOT_PART}"
}

format_update_device() {
    umount -q "$UPDATE_ROOT" 2>/dev/null || true
    if [ "$UPDATE_PART" = "2" ]; then
        mkfs.ext4 -q "$UPDATE_ROOT" -L RFS1 -E nodiscard
    else
        mkfs.ext4 -q "$UPDATE_ROOT" -L RFS2 -E nodiscard
    fi
}

backup_persistent_boot() {
    local pattern src rel dest

    mkdir -p "$PERSISTENT_BOOT_BACKUP_DIR"
    for pattern in $PERSISTENT_BOOT_PATTERNS; do
        for src in "$BOOT_PART_MOUNTPOINT"/$pattern; do
            if [ ! -e "$src" ]; then
                continue
            fi
            rel=${src#"$BOOT_PART_MOUNTPOINT"/}
            dest="$PERSISTENT_BOOT_BACKUP_DIR/$rel"
            mkdir -p "$(dirname "$dest")"
            if [ -d "$src" ]; then
                cp -a "$src" "$dest"
            else
                cp -a "$src" "$dest"
            fi
            log "Backed up boot artifact: $rel"
        done
    done
    sync
}

restore_persistent_boot() {
    cp -a "$PERSISTENT_BOOT_BACKUP_DIR"/. "$BOOT_PART_MOUNTPOINT"/
    rm -rf "$PERSISTENT_BOOT_BACKUP_DIR"
    sync
    log "Restored persistent boot artifacts from backup."
}

if [ "$1" = "preinst" ]; then
    log "Running preinst"

    backup_persistent_boot

    get_current_root_device
    get_update_part
    get_update_device

    log "Boot target: $UPDATE_BOOT (part $BOOT_PART)"
    log "Current root: $CURRENT_ROOT (part $CURRENT_PART)"
    log "Update target: $UPDATE_ROOT (part $UPDATE_PART)"

    format_update_device

    ln -sf "$UPDATE_BOOT" /dev/boot
    log "Created symlink /dev/boot -> $UPDATE_BOOT"

    ln -sf "$UPDATE_ROOT" /dev/update
    log "Created symlink /dev/update -> $UPDATE_ROOT"
fi

if [ "$1" = "postinst" ]; then
    log "Running postinst"

    restore_persistent_boot

    get_current_root_device
    get_update_part

    log "Setting U-Boot environment variable distro_rootpart=$UPDATE_PART"
    fw_setenv distro_rootpart "$UPDATE_PART"

    log "Update prepared. Next boot will use rootfs on partition $UPDATE_PART"
fi
