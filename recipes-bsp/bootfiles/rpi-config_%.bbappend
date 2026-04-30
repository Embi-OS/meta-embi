FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://config.txt.in \
"

ENABLE_DEFAULT_CONFIG ?= "0"
DEFAULT_CONFIG_VERSION ?= "0"

ENABLE_TOUCH_DISPLAY ?= "0"
ENABLE_TOUCH_DISPLAY_2_7_INCH ?= "0"
ENABLE_TOUCH_DISPLAY_2_5_INCH ?= "0"
TOUCH_DISPLAY_ROTATION ?= "90"

ENABLE_WAVESHARE_7_INCH_C_DISPLAY ?= "0"
WAVESHARE_7_INCH_C_DISPLAY_I2C ?= "i2c1"

ENABLE_IQAUDIO_DAC ?= "0"
ENABLE_AUDIO_AMP_SHIM ?= "0"

do_deploy:append() {
    
    # Use default config instead
    if [ "${ENABLE_DEFAULT_CONFIG}" = "1" ]; then
        install -m 644 ${WORKDIR}/config.txt.in $CONFIG
    fi

    enable_touch_display="${ENABLE_TOUCH_DISPLAY}"
    enable_touch_display_2_7_inch="${ENABLE_TOUCH_DISPLAY_2_7_INCH}"
    enable_touch_display_2_5_inch="${ENABLE_TOUCH_DISPLAY_2_5_INCH}"
    touch_display_rotation="${TOUCH_DISPLAY_ROTATION}"
    enable_waveshare_7_inch_c_display="${ENABLE_WAVESHARE_7_INCH_C_DISPLAY}"
    enable_iqaudio_dac="${ENABLE_IQAUDIO_DAC}"
    enable_audio_amp_shim="${ENABLE_AUDIO_AMP_SHIM}"

    case "${DEFAULT_CONFIG_VERSION}" in
        1)
            enable_touch_display="1"
            enable_iqaudio_dac="1"
            ;;
        2)
            enable_waveshare_7_inch_c_display="1"
            enable_audio_amp_shim="1"
            ;;
        3)
            enable_touch_display_2_7_inch="1"
            touch_display_rotation="90"
            enable_audio_amp_shim="1"
            ;;
    esac

    echo "" >> $CONFIG
    echo "# ####################################" >> $CONFIG
    echo "# Those lines are added by meta-embi" >> $CONFIG
    echo "# ####################################" >> $CONFIG

    # Touch Display
    if [ "$enable_touch_display" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable Touch Display" >> $CONFIG
        echo "dtoverlay=vc4-kms-dsi-7inch,rotation=$touch_display_rotation" >> $CONFIG
    fi
    
    # Touch Display 2 7-inch
    if [ "$enable_touch_display_2_7_inch" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable Touch Display 2 7-inch" >> $CONFIG
        echo "dtoverlay=vc4-kms-dsi-ili9881-7inch,rotation=$touch_display_rotation" >> $CONFIG
    fi
    
    # Touch Display 2 5-inch
    if [ "$enable_touch_display_2_5_inch" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable Touch Display 2 5-inch" >> $CONFIG
        echo "dtoverlay=vc4-kms-dsi-ili9881-5inch,rotation=$touch_display_rotation" >> $CONFIG
    fi
    
    # Waveshare 7_0_inchC display 
    if [ "$enable_waveshare_7_inch_c_display" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable waveshare 7_0_inchC display" >> $CONFIG
        echo "dtoverlay=vc4-kms-dsi-waveshare-panel,7_0_inchC,${WAVESHARE_7_INCH_C_DISPLAY_I2C}" >> $CONFIG
    fi
    
    # IQAudio DAC
    if [ "$enable_iqaudio_dac" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable IQAudio DAC" >> $CONFIG
        echo "dtoverlay=rpi-dacpro" >> $CONFIG
    fi
    
    # Audio Amp SHIM
    if [ "$enable_audio_amp_shim" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable Audio Amp SHIM" >> $CONFIG
        echo "dtoverlay=hifiberry-dac" >> $CONFIG
        echo "gpio=25=op,dh" >> $CONFIG
    fi
    
    # Reduce config.txt file size by removing useless lines
    sed -i '/^#[^ ]/d' $CONFIG
    sed -i '/^$/N;/^\n$/D' $CONFIG
}

