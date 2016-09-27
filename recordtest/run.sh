#!/bin/sh
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
RESOLUTION=1920x1080

# N.B... more settings hardcoded below. :-/
# --------------------------------------------------------------------

[ -z "$1" ] && { echo "Usage: $0 <file.vbox>" ; exit 1 ; }

D=$(dirname "$0") ; cd "$D"
D="$PWD"

# VirtualBox requires absolute path to stuff..
vmfile=$(readlink -f "$1")
selftestdir=$(readlink -f $D/$SELFTESTDIR)

# Time to record (s)
rectime=$(($RECTIME*1000))

# Register .vbox
VBoxManage registervm $vmfile

# OK, from now on we need to the UUID instead of filename, but what is it?
count=$(VBoxManage list vms | grep "$PATTERN" | wc -l)
if [ $count -eq 0 ] ; then
   echo "ERROR: Expected name $PATTERN doesn't match what we registered, or registration failed"
   exit 1
fi

if [ $count -gt 1 ] ; then
   echo "ERROR: Found more than one matching $PATTERN - sorry can't figure out which VM you want to modify now..."
   exit 2
fi

id=$(VBoxManage list vms | grep "$PATTERN" | awk '{print $2}' | sed 's/[{}]//g' )

set -e  # Fail if failure...
[ -n "$id" ]

VBoxManage modifyvm $id --videocap on
VBoxManage modifyvm $id --videocapres $RESOLUTION
VBoxManage modifyvm $id --videocaprate 512
VBoxManage modifyvm $id --videocapfps 25
VBoxManage modifyvm $id --videocapmaxtime $rectime
VBoxManage modifyvm $id --videocapmaxsize $MAX_VIDEO_SIZE

# Defaults are OK for these
#VBoxManage modifyvm $id --videocapfile <filename>]
#VBoxManage modifyvm $id --videocapopts <key=value> [<key=value> ...]]
#VBoxManage modifyvm $id --defaultfrontend default
#VBoxManage modifyvm $id --videocapscreens all

# Add the selftest folder
VBoxManage sharedfolder add $id --name /selftest --hostpath $selftestdir

# Start

VBoxManage startvm $id 

# Wait
sleep $TOTALTIME


# Stop it nicely...
VBoxManage sharedfolder remove $id --name /selftest
VBoxManage controlvm $id acpipowerbutton
sleep 30

# Kill it...
set +e
VBoxManage controlvm $id poweroff 2>/dev/null || true


