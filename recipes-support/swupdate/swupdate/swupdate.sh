#!/bin/sh

parse_ini() {
    ini_file="$1"
    current_section=""

    while IFS= read -r line || [ -n "$line" ]; do
        # Trim leading/trailing spaces
        line=$(echo "$line" | sed -e 's/^[[:space:]]*//;s/[[:space:]]*$//')

        # Skip empty lines and comments
        case "$line" in
            ""|\;*|\#*) continue ;;
        esac

        # Section header [SECTION]
        case "$line" in
            \[*\])
                current_section=$(echo "$line" | sed -e 's/^\[\(.*\)\]$/\1/')
                continue
                ;;
        esac

        # Key=value
        key=$(echo "$line" | cut -d '=' -f 1 | sed -e 's/[[:space:]]*$//')
        value=$(echo "$line" | cut -d '=' -f 2- | sed -e 's/^[[:space:]]*//')

        if [ "$current_section" != "" -a "$current_section" != "General" ]; then
            key="${current_section}_${key}"
        fi
        
        # Uppercase the key (and normalize non-alphanumeric to _)
        key=$(echo "$key" | tr '[:lower:]' '[:upper:]' | sed 's/[^A-Z0-9_]/_/g')

        echo "$key = $value"
        eval "$key=\$value"
    done < "$ini_file"
}
 
parse_ini "/etc/swupdate/swupdate.ini"

SWUPDATE_CONF_FILE_IN=@LIBDIR@/swupdate/swupdate.cfg.in
SWUPDATE_CONF_FILE=/tmp/swupdate.cfg

cp ${SWUPDATE_CONF_FILE_IN} ${SWUPDATE_CONF_FILE}
sed -i \
    -e "s|@IDENTIFY_DEVICE@|${DEVICE_ID}|g" \
    -e "s|@SOFTWARE_BRANCH@|${SOFTWARE_BRANCH}|g" \
    -e "s|@MONGOOSE_PORT@|${MONGOOSE_PORT}|g" \
    -e "s|@GSERVICE_URL@|${GSERVICE_URL}|g" \
    -e "s|@GSERVICE_POLLDELAY@|${GSERVICE_POLLDELAY}|g" \
    -e "s|@SURICATTA_ID@|${DEVICE_ID}|g" \
    -e "s|@SURICATTA_URL@|${HAWKBIT_URL}|g" \
    -e "s|@SURICATTA_POLLDELAY@|${HAWKBIT_POLLDELAY}|g" \
    -e "s|@SURICATTA_TARGETTOKEN@|${HAWKBIT_TARGETTOKEN}|g" \
    -e "s|@SURICATTA_GATEWAYTOKEN@|${HAWKBIT_GATEWAYTOKEN}|g" \
    ${SWUPDATE_CONF_FILE}

# Override these variables in sourced script(s) located
# in @LIBDIR@/swupdate/conf.d or /etc/swupdate/conf.d
SWUPDATE_ARGS="-f ${SWUPDATE_CONF_FILE}"
if [ "$AUTO_REBOOT" = true ]; then
    SWUPDATE_ARGS="${SWUPDATE_ARGS} -p reboot"
fi

SWUPDATE_WEBSERVER_ARGS=""
if [ "$MONGOOSE_ENABLED" = true ]; then
    SWUPDATE_WEBSERVER_ARGS="-r /www -p ${MONGOOSE_PORT}"
fi

SWUPDATE_SURICATTA_ARGS=""
if [ "$SURICATTA_SERVICE" != "" ]; then
    SWUPDATE_SURICATTA_ARGS="-S ${SURICATTA_SERVICE}"
fi

# source all files from /etc/swupdate/conf.d and @LIBDIR@/swupdate/conf.d/
# A file found in /etc replaces the same file in @LIBDIR@
for f in `(test -d @LIBDIR@/swupdate/conf.d/ && ls -1 @LIBDIR@/swupdate/conf.d/; test -d /etc/swupdate/conf.d && ls -1 /etc/swupdate/conf.d) | sort -u`; do
  if [ -f /etc/swupdate/conf.d/"$f" ]; then
    . /etc/swupdate/conf.d/"$f"
  else
    . @LIBDIR@/swupdate/conf.d/"$f"
  fi
done

#  handle variable escaping in a simmple way. Use exec to forward open filedescriptors from systemd open.
if [ "$SWUPDATE_WEBSERVER_ARGS" != "" -a "$SWUPDATE_SURICATTA_ARGS" != "" ]; then
  exec /usr/bin/swupdate $SWUPDATE_ARGS  ${SWUPDATE_EXTRA_ARGS} -w "$SWUPDATE_WEBSERVER_ARGS" -u "$SWUPDATE_SURICATTA_ARGS"
elif [ "$SWUPDATE_WEBSERVER_ARGS" != "" ]; then
  exec /usr/bin/swupdate $SWUPDATE_ARGS  ${SWUPDATE_EXTRA_ARGS} -w "$SWUPDATE_WEBSERVER_ARGS"
elif [ "$SWUPDATE_SURICATTA_ARGS" != "" ]; then
  exec /usr/bin/swupdate $SWUPDATE_ARGS  ${SWUPDATE_EXTRA_ARGS} -u "$SWUPDATE_SURICATTA_ARGS"
else
  exec /usr/bin/swupdate $SWUPDATE_ARGS  ${SWUPDATE_EXTRA_ARGS}
fi
