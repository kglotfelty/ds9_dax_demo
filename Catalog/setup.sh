#!/bin/bash 

if test "x$ASCDS_INSTALL" = "x"
then
  echo "Please start CIAO before running this script"
  exit 1
fi

download_chandra_obsid 3750 evt2
mv 3750/primary/acisf03750N003_evt2.fits.gz .
gunzip acisf03750N003_evt2.fits.gz
rmdir -p 3750/primary

obsid_search_csc 3750 3750.tsv col='o.ks_prob_b,o.photflux_aper_b,o.cnts_aper_b'  clob+

cat << EOM > ds9.sym
condition	shape	color	width	dash	font	fontsize	fontweight	fontslant	text	size	size2	units	angle
---------	-----	-----	-----	----	----	--------	----------	---------	----	----	-----	-----	-----
$ks_prob_b>0.9	circle point	green	1	0	helvetica	10	normal	roman	$name			physical	
$ks_prob_b<=0.9	box point	yellow	1	0	helvetica	10	normal	roman	$name			physical	
EOM

exit 0
