# meta-embi
Meta layer for Embi-OS Software Stack

# Basic build
For a basic first build simply run the following commands
```bash
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.local/bin/repo
chmod a+rx ~/.local/bin/repo

repo init -u https://github.com/Embi-OS/embi-manifest -m <manifest>
repo sync

export MACHINE=raspberrypi4-64 && source ./setup-environment.sh

BB_NUMBER_THREADS="6" bitbake meta-b2qt-embedded-qbsp --runall=fetch
BB_NUMBER_THREADS="6" bitbake meta-b2qt-embedded-qbsp
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
parted -s /dev/mmcblk0 resizepart 2 100%
resize2fs /dev/mmcblk0p2
reboot
```

# WM8960 soundcard support
You may need to adjust volume and toggle switches that are off by default
```bash
amixer -c0 sset 'Headphone',0 80%,80%
amixer -c0 sset 'Speaker',0 80%,80%
amixer -c0 sset 'Left Input Mixer Boost' toggle
amixer -c0 sset 'Left Output Mixer PCM' toggle
amixer -c0 sset 'Right Input Mixer Boost' toggle
amixer -c0 sset 'Right Output Mixer PCM' toggle
```

A test can then be run by executing:
```bash
speaker-test -t wav -c 2 -l 1
```

