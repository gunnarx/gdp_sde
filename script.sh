#!/bin/bash

USER=vagrant
HOMEDIR=/home/$USER
LXDE_CONF=/etc/lxdm/default.conf

apt-get update

apt-get install -y lxde
apt-get install -y openjdk-7-jre
apt-get install -y git wget unzip
apt-get install -y d-feet
apt-get install -y wmctrl # used by selftest

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
# Then move it out of the way but keep it for documentation purposes
wget https://raw.githubusercontent.com/gunnarx/gocd-setup/master/install_common_build_dependencies.sh
. ./install_common_build_dependencies.sh
mkdir -p bin
mv install_common_build_dependencies.sh bin/

# There's some bug currently with x flags disappearing from the filesystem
# somewhere along the build pipeline (files unpacked on a noexec filesystem?)
# Hmm, the bug should be gone now for yocto-sdk, but I'm not sure about Qt install, etc
# Better safe than sorry for now...
chmod 755 $HOMEDIR/gdp-sdk $HOMEDIR/gdp-sdk/eclipse $HOMEDIR/gdp-sdk/eclipse/eclipse
chmod 755 $HOMEDIR/dlt-viewer/dlt_viewer
chmod -R 755 $HOMEDIR/Qt-5.6/5.6/gcc_64/bin $HOMEDIR/Qt-5.6/Tools/QtCreator/bin
chmod -R 755 $HOMEDIR/gdp-sdk/bin

# Unpack SDK
chmod 755 ./gdp-sdk/oecore*toolchain*.sh
./gdp-sdk/oecore*toolchain*.sh -d ./gdp-sdk/yocto-sdk/* -y
rm ./gdp-sdk/oecore*toolchain*.sh

# Prompt
cd $HOMEDIR
git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1
cd -

# Insert Qt settings files
if [ -z "$MACHINE" ] ; then
  cd $HOMEDIR/gdp-sdk/yocto-sdk
  MACHINE="$(ls)"
fi

cp $HOMEDIR/.config/targets/common/* $HOMEDIR/.config/QtProject/qtcreator/
if [ -n "$MACHINE" ] ; then
   cp $HOMEDIR/.config/targets/$MACHINE/* $HOMEDIR/.config/QtProject/qtcreator/
else
   echo "*** WARNING, \$MACHINE was not set - can't copy the right Qt Creator files"
fi

# Work around some Qt / meta-qt5 bug that causes qmake to complain like this:
#" Cannot read .../mkspecs/oe-device-extra.pri: No such file or directory

# ... I went to rerport the bug upstream but github/meta-qt5 has disabled
# Issues, and the  README didn't say where to log bugs

# Let's put a dummy file there... but we'll use append so if a valid file is
# later on included, this won't overwrite it.
mkspecdir=$(readlink -f $HOMEDIR/gdp-sdk/yocto-sdk/*/sysroots/*/usr/lib/qt5/mkspecs)

if [ -n "$mkspecdir" ] ; then
   echo "# Bug workaround - this file/line is here because this file is included by mkspec linux-oe-g++ but there was no such file..." \
     >>$mkspecdir/oe-device-extra.pri
else
   echo "*** WARNING, failed to find mkspecs dir"
fi

# Create a known name entrypoint for environment script (used by desktop icon)
cd $HOMEDIR/gdp-sdk/yocto-sdk
ln -s */environment* setupenv

# Reset ownership
chown -R $USER:$USER $HOMEDIR

# Skip login screen
echo -e "[base]\nautologin=$USER" >> /etc/lxdm/default.conf

# Some unnecessary packages...
apt-get remove -y lxmusic juju --auto-remove
apt-get autoremove

# Clear apt caches
apt-get autoclean
apt-get clean
rm -rf /tmp/* /var/{cache,tmp}/* /var/lib/apt/lists/*

exit

#---- ICS stuff to consider ----
# TEMP STUFF.  IGNORE THIS, IT IS NOT EXECUTED

#get the VM up-to-date
#DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" 
#apt-get update -y

#make the student account
#useradd ics -s /bin/bash -G sudo -m
#echo 'ics:ics' | chpasswd

#get Qt!
#apt-get install -y qtcreator qtbase5-examples qtbase5-doc-html

