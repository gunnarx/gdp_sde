#!/bin/bash

HOMEDIR=/home/vagrant

apt-get update

apt-get install -y lxde
apt-get install -y openjdk-7-jre
apt-get install -y git wget unzip
apt-get install -y d-feet

# Prerequisites according to https://wiki.qt.io/Install_Qt_5_on_Ubuntu
apt-get install -y mesa-common-dev libegl1-mesa libglu1-mesa-dev
apt-get install -y build-essential
apt-get install -y libfontconfig1

# There's some bug currently with x flags disappearing from the filesystem
# somewhere along the build pipeline.
# Quick fix...
chmod 755 $HOMEDIR/Qt-5.6/Tools/QtCreator/bin/qtcreator
chmod 755 $HOMEDIR/gdp-sdk/eclipse/eclipse
chmod 755 $HOMEDIR/dlt-viewer/dlt_viewer

