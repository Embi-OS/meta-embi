
ALSA_AUDIO ?= "off"
MAX_FRAMEBUFFERS ?= "2"

ENABLE_TOUCH_DISPLAY ?= "0"
ENABLE_TOUCH_DISPLAY_2_7_INCH ?= "0"
ENABLE_TOUCH_DISPLAY_2_5_INCH ?= "0"

ENABLE_WAVESHARE_7_INCH_C_DISPLAY ?= "0"
WAVESHARE_7_INCH_C_DISPLAY_I2C ?= "i2c1"

ENABLE_AUDIO_AMP_SHIM ?= "0"
ENABLE_IQAUDIO_DAC ?= "0"

do_deploy:append() {
    echo "" >> $CONFIG
    echo "# ####################################" >> $CONFIG
    echo "# Those lines are added by meta-embi" >> $CONFIG
    echo "# ####################################" >> $CONFIG

    # ALSA audio support
    sed -i '/dtparam=audio=/ c\dtparam=audio=${ALSA_AUDIO}' $CONFIG

    # Enable/Disable hdmi outputs
    sed -i '/max_framebuffers=/ c\max_framebuffers=${MAX_FRAMEBUFFERS}' $CONFIG
    
    # Touch Display
    if [ "${ENABLE_TOUCH_DISPLAY}" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable Touch Display" >> $CONFIG
        echo "dtoverlay=vc4-kms-dsi-7inch" >> $CONFIG
    fi
    
    # Touch Display 2 7-inch
    if [ "${ENABLE_TOUCH_DISPLAY_2_7_INCH}" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable Touch Display 2 7-inch" >> $CONFIG
        echo "dtoverlay=vc4-kms-dsi-ili9881-7inch" >> $CONFIG
    fi
    
    # Touch Display 2 5-inch
    if [ "${ENABLE_TOUCH_DISPLAY_2_5_INCH}" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable Touch Display 2 5-inch" >> $CONFIG
        echo "dtoverlay=vc4-kms-dsi-ili9881-5inch" >> $CONFIG
    fi
    
    # Waveshare 7_0_inchC display 
    if [ "${ENABLE_WAVESHARE_7_INCH_C_DISPLAY}" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable waveshare 7_0_inchC display" >> $CONFIG
        echo "dtoverlay=vc4-kms-dsi-waveshare-panel,7_0_inchC,${WAVESHARE_7_INCH_C_DISPLAY_I2C}" >> $CONFIG
    fi
    
    # IQAudio DAC
    if [ "${ENABLE_IQAUDIO_DAC}" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable IQAudio DAC" >> $CONFIG
        echo "dtoverlay=rpi-dacpro" >> $CONFIG
    fi
    
    # Audio Amp SHIM
    if [ "${ENABLE_AUDIO_AMP_SHIM}" = "1" ]; then
        echo >> $CONFIG
        echo "# Enable Audio Amp SHIM" >> $CONFIG
        echo "dtoverlay=hifiberry-dac" >> $CONFIG
        echo "gpio=25=op,dh" >> $CONFIG
    fi
    
    # Reduce config.txt file size by removing useless lines
    sed -i '/^#[^ ]/d' $CONFIG
    sed -i '/^$/N;/^\n$/D' $CONFIG
}

