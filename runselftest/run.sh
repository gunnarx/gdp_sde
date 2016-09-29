#!/bin/sh -x
# (C) 2016 Gunnar Andersson
# License: MPLv2

# --- SETTINGS --------------------------------------------------------

# Recording time (s), starts at boot
RECTIME=120

# Total run time (note also RECTIME)
TOTALTIME=140

# An upper limit, just in case (MBytes)
MAX_VIDEO_SIZE=100

# What is a unique Name prefix for the VM in question (no wildcards)?
PATTERN="gdp-sdk"

# Self test dir, relative to this file
SELFTESTDIR=../selftest

# Geometry of the video
W=1920
H=1080
RESOLUTION=${W}x${H}

RECORD=
SELFTEST=

# executable name decides behavior
echo $0 | fgrep -q record.sh && RECORD=yes

# N.B... more settings hardcoded below. :-/
# --------------------------------------------------------------------

[ -z "$1" ] && { echo "Usage: $0 <file.vbox>" ; exit 1 ; }

D=$(dirname "$0") ; cd "$D"
D="$PWD"

# VirtualBox requires absolute path to stuff..
vmfile=$(readlink -f "$1")
selftestdir=$(readlink -f $D/$SELFTESTDIR)

# Extract UUID from .vbox file (XML file)
id=$(fgrep "Machine uuid=" $vmfile | sed 's/ *<Machine uuid="{\(.*\)}.*/\1/')

if [ -z "$id" ] ; then
   echo "FATAL: Failed to extract uuid from vbox file: $vmfile"
   exit 1
fi

VBoxManage list vms | fgrep -q $id

if [ $? = 0 ] ; then
   echo "Looks like UUID $id is already registered. Skipping."
else
   VBoxManage registervm $vmfile
fi

#set -e  # Fail if failure...
#[ -n "$id" ]

if [ -n "$RECORD" ] ; then 
   if [ "$OLD_VIRTUALBOX" = 1 ] ; then
      VBoxManage modifyvm $id --vcpenabled on
      VBoxManage modifyvm $id --vcpwidth $W
      VBoxManage modifyvm $id --vcpheight $H
      VBoxManage modifyvm $id --vcprate 512
      VBoxManage modifyvm $id --vcpfps 25
   else
      VBoxManage modifyvm $id --videocap on
      VBoxManage modifyvm $id --videocapres $RESOLUTION
      VBoxManage modifyvm $id --videocaprate 512
      VBoxManage modifyvm $id --videocapfps 25
      VBoxManage modifyvm $id --videocapmaxtime $(($RECTIME*1000))
      VBoxManage modifyvm $id --videocapmaxsize $MAX_VIDEO_SIZE
   fi
else
   if [ "$OLD_VIRTUALBOX" = 1 ] ; then
      VBoxManage modifyvm $id --vcpenabled off
   else
      VBoxManage modifyvm $id --videocap off
   fi
fi

# Defaults are OK for these
#VBoxManage modifyvm $id --videocapfile <filename>]
#VBoxManage modifyvm $id --videocapopts <key=value> [<key=value> ...]]
#VBoxManage modifyvm $id --defaultfrontend default
#VBoxManage modifyvm $id --videocapscreens all

# Add the selftest folder
VBoxManage sharedfolder add $id --name /selftest --hostpath $selftestdir

# Start

VBoxManage startvm $id 

if [ -n "$RECORD" ] ; then
   # Wait
   sleep $TOTALTIME

   # Stop it nicely...
   VBoxManage sharedfolder remove $id --name /selftest
   VBoxManage controlvm $id acpipowerbutton
   sleep 30

   # Kill it...
   set +e
   VBoxManage controlvm $id poweroff 2>/dev/null || true
fi

