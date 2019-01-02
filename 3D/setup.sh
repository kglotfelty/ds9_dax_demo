#!/bin/bash 

if test "x$ASCDS_INSTALL" = "x"
then
  echo "Please start CIAO before running this script"
  exit 1
fi


download_chandra_obsid 13182 evt2
mv 13182/primary/hrcf13182N002_evt2.fits.gz ./
rmdir -p 13182/primary

dmcopy \
  "hrcf13182N002_evt2.fits.gz[sky=circle(16404,16499,40)][bin chipx=7370:7857:1,chipy=7590:8080:1,time=::#100]" \
  ar_lac.cube clob+

rm hrcf13182N002_evt2.fits.gz

exit 0
