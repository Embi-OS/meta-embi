# meta-embi
Meta layer for Embi-OS Software Stack

# Basic build
For a basic first build simply run the following commands
```bash
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.local/bin/repo
chmod a+rx ~/.local/bin/repo

repo init -u https://github.com/Embi-OS/embi-manifest -m stable.xml
repo sync

export MACHINE=raspberrypi-armv8 && source ./setup-environment.sh

bitbake b2qt-image-swu --runall=fetch
bitbake b2qt-image-swu

# To build with usb boot support
export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS PRODUCT_IMAGE_BRANCH"
PRODUCT_IMAGE_BRANCH="usb" bitbake b2qt-image-swu

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
