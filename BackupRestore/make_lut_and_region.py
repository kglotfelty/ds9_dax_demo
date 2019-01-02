#!/usr/bin/env python

import chips_contrib.lut.lutcolors as lut

def write_lut(outfile,r,g,b):    
    t = [ "{}\t{}\t{}\n".format(*rgb) for rgb in zip(r,g,b)]    
    t = "".join(t)
    with open(outfile,'w') as fp:
        fp.write(t)


def write_region(outfile, energy):
    with open(outfile, 'w') as fp:
        fp.write('# Region file format: DS9 version 4.1\n')
        fp.write('global color=green dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1\n')        
        fp.write('fk5\n')
        fp.write('# text(350.72934,58.746997) color=white text={{{energy}}}\n'.format(energy=energy))


colors =[ 'hotpink4', 'firebrick', 'darkorange', 'gold4', 'forestgreen', 
          'steelblue', 'mediumpurple4', 'orchid4', 'khaki4']

energies = [ "<0.2", "0.2:0.5", "0.5:0.85", "0.85:1.0",
            "1.0:1.2", "1.2:2.0", "2.0:3.5", "3.5:7.0", ">7.0"]

for i,c in enumerate(colors):
    r,g,b = lut.black_to_color_to_white(c)
    outfile = "{}_{}.lut".format(i,c)
    write_lut(outfile,r,g,b)

for i,e in enumerate(energies):
    outfile = "{}.reg".format(i+1)
    write_region( outfile, e )


        
