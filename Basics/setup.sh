#!/bin/bash 

if test "x$ASCDS_INSTALL" = "x"
then
  echo "Please start CIAO before running this script"
  exit 1
fi

download_chandra_obsid 14022 evt2
mv 14022/primary/acisf14022N001_evt2.fits.gz .
gunzip acisf14022N001_evt2.fits.gz
rmdir -p 14022/primary

exit 0
