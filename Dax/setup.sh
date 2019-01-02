#!/bin/bash 

if test "x$ASCDS_INSTALL" = "x"
then
  echo "Please start CIAO before running this script"
  exit 1
fi


download_chandra_obsid 635 evt1,asol,bpix,bias,flt,fov,stat,msk,mtl,dtf,pbk
chandra_repro 635 out=./

/bin/rm -rf 635
\ls | \
  egrep -v 'pcadf072039163N004_asol1.fits|acisf00635_repro_fov1.fits|acisf00635_repro_evt2.fits|acisf00635_repro_bpix1.fits|acisf00635_000N004_msk1.fits' | \
  xargs -I@ rm @


exit 0
