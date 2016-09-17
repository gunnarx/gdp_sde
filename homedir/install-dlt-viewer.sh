#!/bin/sh

# Define QT_LOCATION in environment, or on command line
if [ -n "$1" ] ; then
   QT_LOCATION="$1"
fi

if [ -z "$QT_LOCATION" ] ; then
   echo "Please define QT_LOCATION variable, or give it as first argument."
   exit 1
fi

# This is a bit of a mess, but during the go build
# the location is not the same as the final location...
# so in that case install libs and plugins there, and create 
# qt conf based on the final location.
if [ -n "$GO_QT_LOCATION" ] ; then
   INSTALL_LOCATION="$GO_QT_LOCATION"
else
   # If run on a normal system
   INSTALL_LOCATION="$QT_LOCATION"
fi

echo "Installing libs and plugins into $INSTALL_LOCATION"
cp lib* $INSTALL_LOCATION/lib/
cp plugins/* $INSTALL_LOCATION/plugins/

echo "Creating qt.conf"
cat <<EOT >qt.conf
[Paths]
Prefix = $QT_LOCATION
EOT

cat <<EOT >dlt-viewer_wrapper.sh
#!/bin/sh
export LD_LIBRARY_PATH=$QT_LOCATION/lib
# Sometimes dlt-viewer starts up without the title bar visible, causing it to
# be unmoveable.  Let's set a location that prevents that if it happens.
/home/vagrant/dlt-viewer/dlt_viewer -geometry 1400x800+20+20
EOT

chmod 755 dlt-viewer_wrapper.sh

echo "Done"
echo "Remember to run the program with $LD_LIBRARY_PATH = $QT_LOCATION/lib in environment."
