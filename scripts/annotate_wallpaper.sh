#!/bin/sh
convert=/usr/bin/convert
if [ ! -x $convert ] ; then
    echo "ERROR: No imagemagick convert installed?" 2>&1
    echo "Skipping wallpaper annotation" 2>&1
    exit
fi

# Remember to run script in the right directory...
file=wallpaper.png
textsize=40
text="$1"
color="#3C5256FF"
tempfile=wallpaper_new.$$.png

$convert $file -gravity NorthEast  -pointsize $textsize -undercolor "#00000080" -fill $color -annotate +2+0 "$text" $tempfile
mv $tempfile $file
