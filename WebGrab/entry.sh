#!/bin/bash
set -ex

num=$1

if [ -z $num ]; then
  cd /xml
  set +x
  /root/merge_xml.sh

else

  cp /data/cfg_${num}.xml /root/.wg++/WebGrab++.config.xml

  .wg++/run.sh

  cp .wg++/guide.xml /xml/guide_${num}.xml

fi
