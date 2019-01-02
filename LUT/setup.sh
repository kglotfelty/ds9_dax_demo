#!/bin/bash 

if test "x$ASCDS_INSTALL" = "x"
then
  echo "Please start CIAO before running this script"
  exit 1
fi


find_chandra_obsid 'IGR J14003-6326' download=all
reproject_obs "*/primary/*evt*" outroot=G310.6-1.6



find * \( -type f -o -type l \) -print | egrep -v  G310.6-1.6_merged_evt.fits | xargs -I@ /bin/rm @

rmdir */secondary/{aspect,ephem} */primary
rmdir -p */secondary


exit 0
