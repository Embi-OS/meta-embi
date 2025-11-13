#!/bin/sh
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

set -e

NETWORK_UNIT=/usr/lib/systemd/network/usb-rndis.network

usage() {
    echo "Usage: $(basename $0) --reset"
    echo "       $(basename $0) --set <network>"
    echo
    echo "Network is given as the device IPv4 address followed by the prefix length."
    echo "For example \"192.168.0.1/24\"."
    exit 1
}

while test -n "$1"; do
    case "$1" in
        "help" | "--help" | "-h")
            usage
            exit 0
            ;;
        "--reset")
            if [ -n "$COMMAND" ]; then
               usage
               exit 1
            fi
            COMMAND="reset"
            ;;
        "--set")
            if [ -n "$COMMAND" ]; then
                usage
                exit 1
            fi
            COMMAND="set"
            shift
            NETWORK=$1
            ;;
    esac
    shift
done

if [ -z "$COMMAND" ]; then
    usage
    exit 1
fi

case "$COMMAND" in
    "set")
        cat <<EOF > $NETWORK_UNIT
# This file is automatically written by b2qt-gadget-network.sh
[Match]
Type=gadget

[Network]
Address=${NETWORK}
DHCPServer=yes

[DHCPServer]
EmitDNS=no
EmitRouter=no

[Link]
RequiredForOnline=no
EOF
        ;;
    "reset")
        cat <<EOF > $NETWORK_UNIT
# This file is automatically written by b2qt-gadget-network.sh
[Match]
Type=gadget

[Network]
DHCPServer=no

[Link]
RequiredForOnline=no
EOF
        ;;
esac

systemctl restart systemd-networkd
