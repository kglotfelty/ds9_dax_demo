
ROOT=`pwd`/..


# ----------------------------------------
# 01 - Customize UI,  ACT J0102-4915, Obsid 14022

demo_01 ()
{
cd $ROOT/Basics
ds9 acisf14022N001_evt2.fits & 

  # scale Log
  # middle-mouse: pan to 3760 4290 physical
  # bin 2
  
  # View -> Vertical

  # File -> tear-off
  
  # View Horizontal and Vertical graphs

  # Quit
}
# -----------------------------------
# 02 - Bin, Block, Zoom,  ACT J0102-4915, Obsid 14022

demo_02()
{
cd $ROOT/Basics
ds9 acisf14022N001_evt2.fits -scale log \
  -pan to 3760 4290 physical -bin factor 2 & 

  # Bin 8
  # Bin 0.5
  
  # Bin 1
  # Block 8
  # Block 0.5
  
  # Block 1
  # Zoom 8
  # Zoom 0.5

  # Quit
}

# ----------------------------------
# 03 - Bin Menu Filter, 4U 1630-47

demo_03() 
{
cd $ROOT/Filter
ds9 acisf19004N001_evt2.fits -scale log -bin to 4 & 

  # Bin -> Binning Parameters
  # Filter:  energy=2000:7000
  
  # Analysis -> Smooth Parameters, rad=4
  # Colors -> Invert

  # Quit
}

# ---------------------------------
# 04a - Region Decorations, Merged Abell 401

demo_04a()
{
cd $ROOT/RegionDecoration
ds9 a401_sm_thresh.flux -block 4 \
  -scale linear -pan to 4205.73 4357.09 physical &  

  # Region -> Load $ROOT/RegionDecoration/ds9.reg

  # Region List Regions, ds9 format
  
  # Highlight Fill Section
  # Highlight Green Section
  # Highlight Width Section
  # Highlight Tag Section
  
  # Region -> Groups    
  # Select different groups
    
}
  
# ------------------------------------------
# 04b - Region Functionality, 

demo_04b()
{

cd $ROOT/RegionFunctionality
ds9 acisf62554N003_evt2.fits -scale log \
  -zoom 8 -pan to 3893 4038 physical & 

  # Edit -> Region
  # Draw circle around point src
  # Region, Get Info
  # Analysis -> Statistics
  # Move circle
  # Delete circle
  
  # Region -> Shape -> Projection
  # Draw along jet
  # Double click, increase width
  # Move endpoints
    
}

# -------------------------------------
# 04c - Region 3D Cubes, Rho Oph, 635

demo_04c()
{
cd $ROOT/RegionFunctionality

dmlist time_cube.fits cols | \
  grep "Axis#" --after-context=4

ds9 time_cube.fits -scale log &

  # Draw circle around pile src
  # Move to cube slice #80
  # Double click circle
  # Change coords to physical
  # Analysis -> Plot3D 
  # Move circle around

}


# ----------------------------
# 05a - RGB multiwavelength, IC443, OBS_ID 13736

demo_05a()
{
    
cd $ROOT/RGB;
ds9 -scale limits -8.5 -4 broad_flux.log &

sleep 5
xpaset -p ds9 view info no
xpaset -p ds9 view buttons no
xpaset -p ds9 view panner no
xpaset -p ds9 view magnifier no
xpaset -p ds9 pan to 4586.5 4390.5 physical

  # Quit

ds9 -scale limits -8.5 -4 -scale linear  \
  soft_flux.log   -cmap load my_red.lut  \
  medium_flux.log -cmap load my_grn.lut  \
  hard_flux.log   -cmap load my_blu.lut \
  -tile column &


sleep 5
xpaset -p ds9 view info no
xpaset -p ds9 view buttons no
xpaset -p ds9 view panner no
xpaset -p ds9 view magnifier no
xpaset -p ds9 pan to 4086.5 4390.5 physical
xpaset -p ds9 match frame wcs

  # Quit

ds9 -frame delete \
  -rgb \
  -red   soft_flux.log   -scale limits -8.5 -4 \
  -green medium_flux.log -scale limits -8.5 -4 \
  -blue  hard_flux.log   -scale limits -8.5 -4 & 

sleep 5
xpaset -p ds9 view info no
xpaset -p ds9 view buttons no
xpaset -p ds9 view panner no
xpaset -p ds9 view magnifier no
xpaset -p ds9 pan to 4586.5 4390.5 physical
  
  # Click indivial color channels on/off
  # Quit
    
}

# ------------------------------
# 05b - RGB cube, time

demo_05b()
{
cd $ROOT/RGB

dmlist time.cube cols

ds9 -frame delete -scale log \
  -rgbcube time.cube &

  # Same RGB controls
  
}

# ------------------------------------------
# 06 - Color Lookup Tables 

demo_06()
{
  
cd $ROOT/LUT
ds9 G310.6-1.6_merged_evt.fits \
  -pan to 4096.5 4096.5 -bin factor 1 \
  -scale log -smooth yes &

  # Color -> Load Color Map
  # ciao-4.11/contrib/data/vt2.lut
    
}

# ----------------------------------------
# 07 Backup & Resotore, CasA

demo_07()
{

cd $ROOT/BackupRestore;

/bin/ls -lRF | \
  sed -e s,$USER,user, -e s,$GROUP,group, 

ds9 -restore ds9.bck &

  # Adjust zoom in each frame    
    
}


# --------------------------------
# 08 3D Rendering, HRC ARLac, Chip coordinates

demo_08()
{
    
cd $ROOT/3D

ds9 -3d ar_lac.cube -scale log &

  # Rotate 
        
}


# -------------------------------------------
# 09 Contours, merge A1664 

demo_09()
{

cd $ROOT/Contour;
ds9 a1664_broad_thresh_crop_fill.img  \
  -cmap load \
  $ASCDS_CONTRIB/data/heart.lut \
  -scale asinh -smooth yes &

  # Contour Parameters
  # 10 Levels
  # Smoothing 10
  # Generate
  # Apply
  
  # Analysis -> Image Servers -> SAO DSS
  # Retrieve

  # Select chandra, 
  # Match frame WCS
  
  # Contour: File -> Copy Contour
  # DSS Frame: File -> Paste Contour
    
}

#-------------------------------
# 10 Catalogs

demo_10()
{

cd $ROOT/Catalog
ds9 acisf03750N003_evt2.fits -scale log \
  -scale limits 0 100 &

  # Analysis -> catalog import tsv 3750.tsv 

  # Plot 
  #    x = $cnts_aper_b
  #    y = $photflux_aper_b
  #    log/log
  
  # Edit -> cat
  # Click srcs in UI, table, plot
  
  # Catalog, Symbol, Advanced
  # Load ds9.sym
  
  # Zoom in

}


# ----------------------------------
# 11 Analysis menu

demo_11()
{

cd $ROOT/Analysis

ds9 SDSSJ1030+0524_merged_evt.fits \
  -scale log -bin factor 2 &

  # Turn off view elements one-by-one

cat kjg.ans

/bin/ls -l simple.sh | \
  sed -e s,$USER,user, -e s,$GROUP,group, 

cat simple.sh

xpaset -p ds9 analysis load kjg.ans

    # Press 'm'

}

# ------------------------
# 20 Dax : Rho Oph, Obsid 635

demo_20()
{

cd $ROOT/Dax

ds9 acisf00635_repro_evt2.fits \
  -bin factor 4 -scale log -scale limits 0 100 &

  # Analysis -> CIAO, tear off
  
  # Draw circle around src, selected
  # CIAO -> Statistics -> Net Counts
  # Draw background circle somewhere
  # CIAO -> Statistics -> Net Counts

  # CIAO -> Statistics -> Photometry
    
  # CIAO -> Histograms -> GLvary
  # Right click, select, 
  # move, resize title
  # show gui
  
  # CIAO -> Sherpa -> specfit
  # show temp dir

  # CIAO -> Sherpa -> 2D fit
    
}









