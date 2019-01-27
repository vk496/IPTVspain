#!/bin/sh
set -x

echo "<tv>" >guide.xml

for f in guide_*; do

  cat $f |xmlstarlet sel -E utf-8 -t -c "/tv/channel" >> guide.xml

done


for f in guide_*; do

  cat $f |xmlstarlet sel -E utf-8 -t -c "/tv/programme" >> guide.xml

done

echo "</tv>" >> guide.xml

cat guide.xml | xmlstarlet fo -e utf-8 - > guide.xml.1
mv guide.xml.1 guide.xml
