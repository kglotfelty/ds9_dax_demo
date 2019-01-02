#!/bin/bash 

if test "x$ASCDS_INSTALL" = "x"
then
  echo "Please start CIAO before running this script"
  exit 1
fi


python -m chips_contrib.lut.lutcolors > /dev/null 2>&1 
if test $? -ne 0
then
    echo "Please install color-lookup-table package"
    echo ""
    echo "git clone https://github.com/kglotfelty/LUT"
    echo "cd LUT"
    echo "python setup.py install"
  exit 1
fi

python make_lut.py



download_chandra_obsid 13736 evt1,asol,bpix,bias,flt,fov,stat,msk,mtl,dtf,pbk
chandra_repro 13736 out=
fluximage 13736 out=./ bands=broad,csc bin=4 

mv 13736/primary/acisf13736_000N001_fov1.fits* ./

dmimgadapt "broad_flux.img[sky=region(acisf13736_000N001_fov1.fits)][opt full]" \
  outfile="broad_flux.asm" radfile="broad.radii" \
  function="gaussian" minrad="0.5" maxrad="45" numrad="100" radscale="linear" counts="1e-05" mode=h clob+ 
dmimgcalc broad_flux.asm none broad_flux.log op="imgout=log(img1)"

for band in soft medium hard
do
  dmimgadapt "${band}_flux.img[sky=region(acisf13736_000N001_fov1.fits)][opt full]" \
      outfile="${band}_flux.asm" inradfile="broad.radii" \
      function="gaussian" minrad="0.5" maxrad="45" numrad="100" radscale="linear" counts="1e-05" mode=h clob+ 
      
  dmimgcalc "${band}_flux.asm" none "${band}_flux.log" op="imgout=log(img1)"
done


/bin/rm -rf 13736 

\ls | egrep -v '.log$' | xargs -I@ /bin/rm @


### --- Time cube

download_chandra_obsid 635 evt2
mv 635/primary/acisf00635N004_evt2.fits.gz .
rmdir -p 635/primary

dmcopy "acisf00635N004_evt2.fits.gz[x=2800:6350,y=2890:5820][bin sky=6,time=::#3]" time.cube clob+

rm acisf00635N004_evt2.fits.gz


