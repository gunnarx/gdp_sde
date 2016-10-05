#!/bin/bash

# Run QtCreator after sourcing in the yocto-sdk cross dev environment

QT_CREATOR_LOCATION="$(ls ~/Qt*/Tools/QtCreator/bin/qtcreator)"

# You can pass the MACHINE name as argument if multiple SDKs
# are installed.
if [ -n "$1" ] ; then
   ENVSCRIPT="$(ls ~/gdp-sdk/yocto-sdk/$1/environment-setup*)"
else
# Otherwise, let's assume there's only one.
   ENVSCRIPT="$(ls ~/gdp-sdk/yocto-sdk/*/environment-setup*)"
fi

if [ -x "$QT_CREATOR_LOCATION" ] ; then
  if [ -f "$ENVSCRIPT" ] ; then
    source "$ENVSCRIPT"
    $QT_CREATOR_LOCATION
  else
    echo "ERROR: Didn't find environment setup script ($ENVSCRIPT)"
    exit 1
  fi
else
  echo "ERROR: Didn't find an executable qtcreator ($QT_CREATOR_LOCATION)"
  exit 2
fi

