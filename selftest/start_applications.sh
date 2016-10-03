#!/bin/sh
# Start each graphical application
cwd="$PWD"
echo
echo "RUNNING ALL APPLICATIONS"
echo
for f in Desktop/* ; do 
  name=$(grep Name $f | head -1 | sed 's/.*=//')
  echo " -------   $name   ---------- "
  pcmanfm $f
  echo "pausing 5s..."
  sleep 5
done
  echo "...and 5 more"
sleep 5
echo Killing all applications
sudo killall d-feet dlt_viewer qtcreator eclipse java lxterminal
sleep 2
cd "$cwd"
