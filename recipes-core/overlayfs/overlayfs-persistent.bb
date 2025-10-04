SUMMARY = "OverlayFS mount for persistent storage"
LICENSE = "CLOSED"

inherit overlayfs

# Mount point for /root persistent storage
OVERLAYFS_MOUNT_POINT[root] = "/config/overlay-root"
OVERLAYFS_WRITABLE_PATHS[root] = "/root"

# Mount point for /var/lib persistent storage
OVERLAYFS_MOUNT_POINT[varlib] = "/config/overlay-varlib"
OVERLAYFS_WRITABLE_PATHS[varlib] = "/var/lib"
