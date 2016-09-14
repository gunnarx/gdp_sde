#!/bin/sh

# Define QT_LOCATION in environment, or on command line
if [ -n "$1" ] ; then
  QT_LOCATION="$1"
fi

if [ -z "$QT_LOCATION" ] ; then
  echo "Please define QT_LOCATION variable, or give it as first argument."
  exit 1
fi

echo "Installing libs and plugins into $QT_LOCATION"
cp lib* $QT_LOCATION/lib/
cp plugins/* $QT_LOCATION/plugins/

echo "Creating qt.conf"
cat <<EOT >qt.conf
[Paths]
Prefix = $QT_LOCATION
EOT

echo "Done"
echo "Remember to run the program with $LD_LIBRARY_PATH = $QT_LOCATION/lib in environment."
