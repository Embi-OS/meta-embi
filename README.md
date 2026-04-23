# meta-embi
Meta layer for Embi-OS Software Stack

## Prerequisites

### System packages (Ubuntu/Debian example)

```bash
sudo apt update
sudo apt install -y \
    git wget diffstat unzip texinfo gcc build-essential chrpath socat \
    cpio pipx python3 python3-pip python3-pexpect xz-utils debianutils \
    iputils-ping python3-git python3-jinja2 libsdl1.2-dev \
    xterm
pipx install kas --system-site-packages
```

## Quick start

For a basic first build simply run the following commands

```bash
git clone git@github.com:Embi-OS/embi-kas.git

# To build with latest meta-embi revision (only use in dev mode)
kas shell embi-kas/latest.yml
# To build with stable meta-embi revision (use for release build)
kas shell embi-kas/stable.yml

bitbake meta-b2qt-embedded-qbsp --runall=fetch
bitbake meta-b2qt-embedded-qbsp

bitbake b2qt-image-swu --runall=fetch
bitbake b2qt-image-swu

# To build with embi release-mode (e.g. using build script build_yocto.sh)
PRODUCT_VERSION="25.10.0" PRODUCT_VERSION_SUFFIX="stable" bitbake b2qt-image-swu

# Print VARIABLE content
bitbake -e b2qt-image-swu | grep "^DISTRO_FEATURES"
bitbake -e b2qt-image-swu | grep "^IMAGE_FEATURES"
bitbake -e b2qt-image-swu | grep "^EXTRA_IMAGE_FEATURES"

# Print PACKAGECONFIG content for qtbase
bitbake -e qtbase | grep "^PACKAGECONFIG"

# Clean
bitbake -c cleanall b2qt-image-swu
```
Once the build is done, the image is located in this folder and can directly be used with the pi-imager or swupdate:
```filenames
<YoctoBuildDir>/tmp/deploy/images/${MACHINE}/embi-image-${MACHINE}.wic.xz
<YoctoBuildDir>/tmp/deploy/images/${MACHINE}/embi-image-${MACHINE}.swu
```

A QBSP file is also available and can be used by the Qt MaintenanceTool:
```filenames
<YoctoBuildDir>/tmp/deploy/qbsp/meta-b2qt-embedded-qbsp-x86_64-${MACHINE}-${QT_VERSION}.qbsp
```

# Resize sd card partition
After the first boot you may notice that the root partition does not fill the entire sd card space. It can be resized like so:
```bash
parted -s /dev/mmcblk0 resizepart 4 100%
resize2fs /dev/mmcblk0p4
reboot
```

# Audio support
A test can then be run by executing:
```bash
speaker-test -t wav -c 2 -l 1
```
