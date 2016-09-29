#!/bin/sh -x
# (C) 2016 Gunnar Andersson
# License: MPLv2

# $1:  A unique Name prefix for the VM in question (no wildcards)
[ -z "$1" ] && { echo "Usage: $0 <vbox-name (prefix)>" ; exit 1 ; }
PATTERN="$1"

D=$(dirname "$0") ; cd "$D"
D="$PWD"

echo "Unregistering old VMs matching pattern: $PATTERN :"
VBoxManage list vms | fgrep "$PATTERN"
for id in $(VBoxManage list vms | fgrep "$PATTERN" | awk '{print $2}' | sed 's/[{}]//g') ; do
    VBoxManage controlvm $id poweroff
    VBoxManage unregistervm $id 
done

