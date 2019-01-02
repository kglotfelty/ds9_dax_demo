#!/bin/bash 

if test "x$ASCDS_INSTALL" = "x"
then
  echo "Please start CIAO before running this script"
  exit 1
fi


download_chandra_obsid 62554 evt2
mv 62554/primary/acisf62554N003_evt2.fits.gz .
gunzip acisf62554N003_evt2.fits.gz
rmdir -p 62554/primary

# 3D cube

download_chandra_obsid 635 evt2,fov
mv 635/primary/*gz .
gunzip *gz
dmcopy "acisf00635N004_evt2.fits[sky=region(acisf00635_000N004_fov1.fits)][bin sky=8,time=::#100]" time_cube.fits
rmdir -p 635/primary
rm acisf00635N004_evt2.fits acisf00635_000N004_fov1.fits

cat << EOM > ds9.reg
# Region file format: DS9 version 4.1
global color=green dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1
physical
# projection(3896.625,4036.125,3919.25,4036.2508,6.3123417)
EOM


exit 0
