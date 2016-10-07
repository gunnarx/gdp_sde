#!/bin/sh

# Define QT_LOCATION in environment, or on command line
if [ -n "$1" ] ; then
   QT_LOCATION="$1"
fi

DLT_VIEWER_LOCATION=/home/vagrant/dlt-viewer

if [ -z "$QT_LOCATION" ] ; then
   echo "Please define QT_LOCATION variable, or give it as first argument."
   exit 1
fi

cat <<EOT >dlt-viewer_wrapper.sh
#!/bin/sh

# Ensure libraries are found
export LD_LIBRARY_PATH=$QT_LOCATION/lib:$DLT_VIEWER_LOCATION

# Sometimes dlt-viewer starts up without the title bar visible, causing it to
# be unmoveable.  Seting a location/geometry prevents this.
$DLT_VIEWER_LOCATION/dlt_viewer -geometry 1400x800+20+100
EOT

chmod 755 dlt-viewer_wrapper.sh

echo "Done"
