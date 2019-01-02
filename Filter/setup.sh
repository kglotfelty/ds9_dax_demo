#!/bin/bash 

if test "x$ASCDS_INSTALL" = "x"
then
  echo "Please start CIAO before running this script"
  exit 1
fi

download_chandra_obsid 19004 evt2
mv 19004/primary/acisf19004N001_evt2.fits.gz .
gunzip acisf19004N001_evt2.fits.gz
rmdir -p 19004/primary

exit 0
