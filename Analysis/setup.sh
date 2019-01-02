#!/bin/bash 

if test "x$ASCDS_INSTALL" = "x"
then
  echo "Please start CIAO before running this script"
  exit 1
fi


find_chandra_obsid SDSSJ1030+0524 download=all
reproject_obs "*/primary/*evt2.fits.gz" outroot=SDSSJ1030+0524 clob+

find * \( -type f -o -type l \) -print | \
  egrep  -v 'SDSSJ1030\+0524_merged_evt.fits' | \
  xargs -I@ rm @

rmdir */secondary/{aspect,ephem} */primary
rmdir -p */secondary

exit 0
