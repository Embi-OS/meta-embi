#!/bin/sh

set -eu

if [ $# -lt 1 ]; then
    exit 0
fi

BOOT_PART_MOUNTPOINT=${BOOT_PART_MOUNTPOINT:-/boot}
PERSISTENT_BOOT_BACKUP_DIR=${PERSISTENT_BOOT_BACKUP_DIR:-/config/boot-persistent}
PERSISTENT_BOOT_PATTERNS=${PERSISTENT_BOOT_PATTERNS:-"uboot.env"}
BOOT_PART=${BOOT_PART:-"1"}

log() {
    echo "[update.sh] $*"
}

require_boot_mount() {
    if ! mountpoint -q "$BOOT_PART_MOUNTPOINT"; then
        log "$BOOT_PART_MOUNTPOINT is not mounted"
        exit 1
    fi
}

get_current_root_device() {
    PARTUUID=$(sed -n 's/.*root=PARTUUID=\([^ ]*\).*/\1/p' /proc/cmdline)
    if [ -z "$PARTUUID" ]; then
        log "Unable to determine current root PARTUUID from /proc/cmdline"
        exit 1
    fi

    CURRENT_ROOT=$(readlink -f "/dev/disk/by-partuuid/$PARTUUID") || {
        log "Unable to resolve current root device from PARTUUID=$PARTUUID"
        exit 1
    }
}

get_update_part() {
    CURRENT_PART=$(printf '%s' "$CURRENT_ROOT" | sed -n 's/.*[^0-9]\([0-9][0-9]*\)$/\1/p')
    if [ -z "$CURRENT_PART" ]; then
        log "Unable to determine rootfs partition number from $CURRENT_ROOT"
        exit 1
    fi

    case "$CURRENT_PART" in
        2)
            UPDATE_PART="3"
            ;;
        3)
            UPDATE_PART="2"
            ;;
        *)
            log "Unsupported current rootfs partition: $CURRENT_PART"
            exit 1
            ;;
    esac
}

get_update_device() {
    case "$CURRENT_ROOT" in
        *p[0-9])
            CURRENT_BASE=$(printf '%s' "$CURRENT_ROOT" | sed 's/p[0-9][0-9]*$//')
            PART_SEPARATOR="p"
            ;;
        *[0-9])
            CURRENT_BASE=$(printf '%s' "$CURRENT_ROOT" | sed 's/[0-9][0-9]*$//')
            PART_SEPARATOR=""
            ;;
        *)
            log "Unsupported block device naming scheme: $CURRENT_ROOT"
            exit 1
            ;;
    esac

    UPDATE_ROOT="${CURRENT_BASE}${PART_SEPARATOR}${UPDATE_PART}"
    UPDATE_BOOT="${CURRENT_BASE}${PART_SEPARATOR}${BOOT_PART}"
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
    require_boot_mount
    rm -rf "$PERSISTENT_BOOT_BACKUP_DIR"
    mkdir -p "$PERSISTENT_BOOT_BACKUP_DIR"
    for pattern in $PERSISTENT_BOOT_PATTERNS; do
        for src in "$BOOT_PART_MOUNTPOINT"/$pattern; do
            if [ ! -e "$src" ]; then
                continue
            fi
            rel=${src#"$BOOT_PART_MOUNTPOINT"/}
            dest="$PERSISTENT_BOOT_BACKUP_DIR/$rel"
            mkdir -p "$(dirname "$dest")"
            cp -a "$src" "$dest"
            log "Backed up boot artifact: $rel"
        done
    done
    sync
}

restore_persistent_boot() {
    require_boot_mount
    if [ ! -d "$PERSISTENT_BOOT_BACKUP_DIR" ]; then
        log "No persistent boot artifacts to restore."
        return 0
    fi

    cp -a "$PERSISTENT_BOOT_BACKUP_DIR"/. "$BOOT_PART_MOUNTPOINT"/
    rm -rf "$PERSISTENT_BOOT_BACKUP_DIR"
    sync
    log "Restored persistent boot artifacts from backup."
}

case "$1" in
    preinst)
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
        ;;
    postinst)
        log "Running postinst"

        restore_persistent_boot

        get_current_root_device
        get_update_part

        log "Setting U-Boot environment variables distro_rootpart=$UPDATE_PART and root_part=$UPDATE_PART"
        fw_setenv distro_rootpart "$UPDATE_PART"
        fw_setenv root_part "$UPDATE_PART"

        log "Update prepared. Next boot will use rootfs on partition $UPDATE_PART"
        ;;
esac
