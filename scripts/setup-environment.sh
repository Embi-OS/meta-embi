#!/bin/sh

while test -n "$1"; do
  case "$1" in
    "--help" | "-h")
      echo "Usage: . $0 [build directory]"
      return 0
      ;;
    *)
      BUILDDIRECTORY=$1
      ;;
  esac
  shift
done

THIS_SCRIPT="setup-environment.sh"
if [ "$(basename -- $0)" = "${THIS_SCRIPT}" ]; then
  echo "Error: This script needs to be sourced. Please run as '. $0'"
  return 1
fi

if [ -z "$MACHINE" ]; then
  echo "Error: MACHINE environment variable not defined"
  return 1
fi

BUILDDIRECTORY=${BUILDDIRECTORY:-build-${MACHINE}}

if [ ! -e ${PWD}/${BUILDDIRECTORY} ]; then
  case ${MACHINE} in
    *)
      LAYERSCONF="bblayers.conf.sample"
      ;;
  esac
  LAYERSCONF=${PWD}/sources/templates/${LAYERSCONF}
  if [ ! -e ${LAYERSCONF} ]; then
    echo "Error: Could not find layer conf '${LAYERSCONF}'"
    return 1
  fi

  mkdir -p ${PWD}/${BUILDDIRECTORY}/conf
  cp ${LAYERSCONF} ${PWD}/${BUILDDIRECTORY}/conf/bblayers.conf
  if [ ! -e "${PWD}/sources/templates/local.conf.sample" ]; then
    cp ${PWD}/sources/meta-embi/conf/templates/default/local.conf.sample  ${PWD}/${BUILDDIRECTORY}/conf/local.conf
  fi
fi

export TEMPLATECONF=$(readlink -f "${PWD}/sources/templates")
. sources/poky/oe-init-build-env ${BUILDDIRECTORY}

unset BUILDDIRECTORY
unset TEMPLATECONF
unset LAYERSCONF
