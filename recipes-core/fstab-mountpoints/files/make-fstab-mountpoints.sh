#!/bin/sh
set -e

decode() {
    # Decode fstab-style octal escapes (e.g. \040 for space)
    printf '%b' "$1"
}

echo "[fstab-mountpoints] Checking fstab entries..."

# Parse fstab, skip comments and blank lines
grep -v '^[[:space:]]*#' /etc/fstab | \
while read -r device mountpoint fstype options dump pass; do
    # Skip invalid/empty lines
    [ -z "$mountpoint" ] && continue
    
    # Decode escaped sequences
    mp=$(decode "$mountpoint")

    # Skip root
    if [ "$mp" = "/" ]; then
        echo "[fstab-mountpoints] Skipping root mount /"
        continue
    fi

    # Skip pseudo filesystems
    case "$fstype" in
        proc|sysfs|tmpfs|devpts|swap|cgroup*|pstore|efivarfs|mqueue)
            echo "[fstab-mountpoints] Skipping pseudo fs $fstype on $mp"
            continue
            ;;
    esac

    # Skip 'none' devices (common for pseudo mounts)
    if [ "$device" = "none" ]; then
        echo "[fstab-mountpoints] Skipping 'none' device for $mp"
        continue
    fi

    # Skip if noauto option is present
    if echo "$options" | grep -qw noauto; then
        echo "[fstab-mountpoints] Skipping noauto entry for $mp"
        continue
    fi

    # Ensure mountpoint directory
    if [ ! -d "$mp" ]; then
        echo "[fstab-mountpoints] Creating mountpoint: $mp"
        mkdir -p "$mp"
    else
        echo "[fstab-mountpoints] Mountpoint already exists: $mp"
    fi
done

echo "[fstab-mountpoints] Done."

