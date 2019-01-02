#!/usr/bin/env python

import chips_contrib.lut.lutcolors as lut

def write_lut(outfile,r,g,b):    
    t = [ "{}\t{}\t{}\n".format(*rgb) for rgb in zip(r,g,b)]    
    t = "".join(t)
    with open(outfile,'w') as fp:
        fp.write(t)


colors = {'red':'firebrick', 'grn':'forestgreen', 'blu':'dodgerblue'}

for c in colors:
    r,g,b = lut.black_to_color_to_white(colors[c])
    outfile = "my_{}.lut".format(c)
    write_lut(outfile,r,g,b)



        
