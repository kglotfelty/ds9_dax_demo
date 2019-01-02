#!/bin/bash 

if test "x$ASCDS_INSTALL" = "x"
then
  echo "Please start CIAO before running this script"
  exit 1
fi


download_chandra_obsid 1648,17172,17173,17557,17568,7901 evt2,asol,msk,bpix,fov
merge_obs infiles="1648,17172,17173,17557,17568,7901" outroot="a1664" bin=1 
dmcopy "a1664_broad_thresh.img[(x,y)=box(4117.7639,4017.2639,902.47226,769.1639,0)]" \
    "a1664_broad_thresh_crop.img"
celldetect a1664_broad_thresh_crop.img cell.src fixedcell=6
dmcopy "cell.src[exclude (x,y)=circle(4120,4010,25)]" ciao_reg.fits 
roi ciao_reg.fits out=%02d_reg.fits group=individual targetbkg=target mode=h clob+
/bin/ls ??_reg.fits | sed 's,.*,region(&),' > src.lis
/bin/ls ??_reg.fits | sed 's,.*,region(&[bkgreg]),' > bkg.lis
dmfilth infile="a1664_broad_thresh_crop.img" outfile="a1664_broad_thresh_crop_fill.img" \
    method="POISSON" srclist="@src.lis" bkglist="@bkg.lis"

/bin/rm -rf 1648 17172 17173 17557 17568 7901 

/bin/ls | egrep -v a1664_broad_thresh_crop_fill.img | xargs -I@ /bin/rm @

exit 0

