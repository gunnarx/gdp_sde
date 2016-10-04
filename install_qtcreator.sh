#!/bin/bash
# echo installing Qt-Creator from qt.io, existing copy in homedir/Qt-Creator will be removed
wget http://download.qt.io/official_releases/qtcreator/4.1/4.1.0/qt-creator-opensource-linux-x86_64-4.1.0.run 
chmod a+x qt-creator-opensource-linux-x86_64-4.1.0.run
rm -rf homedir/Qt-Creator
./qt-creator-opensource-linux-x86_64-4.1.0.run --script qtcreator_install_script.qs -v -platform minimal
rm -f qt-creator-opensource-linux-x86_64-4.1.0.run
