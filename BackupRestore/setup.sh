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

python make_lut_and_region.py

download_chandra_obsid 4638 evt2
mv 4638/primary/acisf04638N003_evt2.fits.gz ./
rmdir -p 4638/primary

dmcopy acisf04638N003_evt2.fits.gz"[x=3580.5:5072.5,y=3148.5:4640.5]" crop.evt

dmcopy "crop.evt[bin sky=4][energy=0:200]" outfile=0-p
dmcopy "crop.evt[bin sky=4][energy=200:500]" outfile=1-r
dmcopy "crop.evt[bin sky=4][energy=500:850]" outfile=2-o
dmcopy "crop.evt[bin sky=4][energy=850:1000]" outfile=3-y
dmcopy "crop.evt[bin sky=4][energy=1000:1200]" outfile=4-g
dmcopy "crop.evt[bin sky=4][energy=1200:2000]" outfile=5-b
dmcopy "crop.evt[bin sky=4][energy=2000:3500]" outfile=6-i
dmcopy "crop.evt[bin sky=4][energy=3500:7000]" outfile=7-v
dmcopy "crop.evt[bin sky=4][energy=7000:10000]" outfile=8-k

rm acisf04638N003_evt2.fits.gz crop.evt

exit 0


