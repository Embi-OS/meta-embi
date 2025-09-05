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

bitbake meta-b2qt-embedded-qbsp --runall=fetch
bitbake meta-b2qt-embedded-qbsp

# To build with a static build of Qt
export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS EMBI_QTBASE_STATIC"
EMBI_QTBASE_STATIC="1" bitbake meta-b2qt-embedded-qbsp

# Print VARIABLE content
bitbake -e meta-b2qt-embedded-qbsp | grep "^DISTRO_FEATURES"
bitbake -e meta-b2qt-embedded-qbsp | grep "^IMAGE_FEATURES"
bitbake -e meta-b2qt-embedded-qbsp | grep "^EXTRA_IMAGE_FEATURES"

# Print PACKAGECONFIG content for qtbase
bitbake -e qtbase | grep "^PACKAGECONFIG"

# Clean
bitbake -c cleanall meta-b2qt-embedded-qbsp
```
Once the build is done, the image is located in this folder and can directly be used with the pi-imager:
```filenames
<YoctoBuildDir>/tmp/deploy/images/${MACHINE}/b2qt-embedded-qt6-image-${MACHINE}.wic.xz
```

A QBSP file is also available and can be used by the Qt MaintenanceTool:
```filenames
<YoctoBuildDir>/tmp/deploy/qbsp/meta-b2qt-embedded-qbsp-x86_64-${MACHINE}.qbsp
```

# Resize sd card partition
After the first boot you may notice that the root partition does not fill the entire sd card space. It can be resized like so:
```bash
/usr/sbin/fs-maximize.sh
```

# Audio support
A test can then be run by executing:
```bash
speaker-test -t wav -c 2 -l 1
```
