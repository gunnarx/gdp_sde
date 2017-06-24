#!/bin/sh
export LD_LIBRARY_PATH=/home/vagrant/Qt-5.6.1/5.6.1/gcc_64/lib:/home/vagrant/dlt-viewer

# Sometimes dlt-viewer starts up without the title bar visible, causing it to
# be unmoveable.  Let's set a location that prevents that it happens.
/home/vagrant/dlt-viewer/dlt_viewer -geometry 1400x800+20+100
