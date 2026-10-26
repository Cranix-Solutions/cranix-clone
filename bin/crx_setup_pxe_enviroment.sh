#!/bin/bash

VERSION=$1
. /etc/sysconfig/language
. /etc/sysconfig/cranix

DATE=$( /usr/share/cranix/tools/crx_date.sh )
LANG=${RC_LANG:3:2}

for i in /srv/itool/config/*.templ
do
   base="/srv/itool/config/"`basename $i .templ`
   if [ ! -e $base ] 
   then
       cp $i $base
       sed -i "s/SCHOOLNAME/$CRANIX_NAME/" $base
       sed -i "s/SCHOOLLANGUAGE/$CRANIX_LANGUAGE/" $base
   fi
done

DATE=`date +%Y-%m-%d:%H-%M`
if [ ! -e /srv/itool/config/WinDomain.xml ]; then
    cp /srv/itool/config/WinDomain.xml.templ /srv/itool/config/WinDomain.xml
fi
mkdir -p /srv/tftp/boot /srv/ftp/agama
/usr/bin/wget http://downloads.cephalix.eu/boot/initrd -O /srv/tftp/boot/initrd
/usr/bin/wget http://downloads.cephalix.eu/boot/linux -O /srv/tftp/boot/linux
/usr/bin/wget http://downloads.cephalix.eu/boot/squashfs.img -O /srv/ftp/agama/squashfs.img

