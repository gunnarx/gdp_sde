#!/bin/bash

USER=vagrant
HOMEDIR=/home/$USER
LXDE_CONF=/etc/lxdm/default.conf

apt-get update

apt-get install -y lxde
apt-get install -y openjdk-7-jre
apt-get install -y git wget unzip
apt-get install -y d-feet

# For whatever reason, LXDM by default seems to list users like "syslog" in the
# login screen.  Get rid of all that...
echo "white=$USER" >>$LXDE_CONF
echo "black=syslog usbmux messagebus pollinate colord statd puppet" >> $LXDE_CONF

# Prerequisites according to https://wiki.qt.io/Install_Qt_5_on_Ubuntu
apt-get install -y mesa-common-dev libegl1-mesa libglu1-mesa-dev
apt-get install -y build-essential
apt-get install -y cmake
apt-get install -y libfontconfig1

# Yocto minimal prerequisites (some repetition here but that's OK)
apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm
apt-get install -y gettext

# These seem to always cause trouble when doing vagrant based provisioning
# and complaints will remain on later user apt-get installs.  I don't think
# we need them.
apt-get remove -y dictionaries-common miscfiles

# And some other commonly used packages in other GENIVI software
# Let's be lazy and reuse the file we already have for Go Agent setup (again, I would say some repetition here)
wget https://raw.githubusercontent.com/gunnarx/gocd-setup/master/install_common_build_dependencies.sh
. ./install_common_build_dependencies.sh

# There's some bug currently with x flags disappearing from the filesystem
# somewhere along the build pipeline (files unpacked on a noexec filesystem?)
# Quick fix...
chmod 755 $HOMEDIR/gdp-sdk $HOMEDIR/gdp-sdk/eclipse $HOMEDIR/gdp-sdk/eclipse/eclipse
chmod 755 $HOMEDIR/dlt-viewer/dlt_viewer
chmod -R 755 $HOMEDIR/Qt-5.6/5.6/gcc_64/bin $HOMEDIR/Qt-5.6/Tools/QtCreator/bin
chmod -R 755 $HOMEDIR/gdp-sdk/bin

# Unpack SDK
chmod 755 ./gdp-sdk/oecore*toolchain*.sh
./gdp-sdk/oecore*toolchain*.sh -d ./gdp-sdk/yocto-sdk/* -y
rm ./gdp-sdk/oecore*toolchain*.sh

# Some unnecessary packages...
apt-get remove -y juju --auto-remove

# Clear apt caches
apt-get clean
rm -rf /tmp/* /var/{cache,tmp}/* /var/lib/apt/lists/*

