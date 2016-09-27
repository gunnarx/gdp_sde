#!/bin/sh
sudo mount -t vboxsf /selftest /selftest
entrypoint=/selftest/run.sh
font=Monospace
fontsize=14
geom=80x9+0+0
if [ -f $entrypoint ] ; then

   title="RUNNING SELFTEST, PLEASE WAIT"
   xterm -bg gray -geometry $geom -title "$title" -fs $fontsize -fa $font -e $entrypoint  &

   sleep 1
   wmctrl -a "$title" -b add,above
   sleep 1
   wmctrl -a "$title" -b add,above
fi

