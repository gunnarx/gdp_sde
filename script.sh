#!/bin/bash

HOMEDIR=/home/vagrant

apt-get update

apt-get install -y lxde
apt-get install -y openjdk-7-jre
apt-get install -y git wget unzip
apt-get install -y d-feet
apt-get install libegl1-mesa

# There's some bug currently with x flags disappearing from the filesystem
# somewhere along the build pipeline.
# Quick fix...
chmod 755 $HOMEDIR/Qt-5.6/Tools/QtCreator/bin/qtcreator
chmod 755 $HOMEDIR/gdp-sdk/eclipse/eclipse
chmod 755 $HOMEDIR/dlt-viewer/dlt_viewer

