#!/bin/sh

# We need two stamps with different format The key is to guarantee the same
# time for both by only one call to date.  Store them in files for future use.

format1="%Y%m%d_%H%M%S"
format2="%Y-%m-%d %H:%M:%S"
date=$(date +"$format1#$format2")

echo "$date" | sed 's/#.*//' >FILESTAMP
echo "$date" | sed 's/#.*//' >TIMESTAMP

