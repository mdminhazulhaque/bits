#!/bin/sh

inkscape favicon.svg -w 144 -h 144 -e apple-touch-icon-144-precomposed.png 
inkscape favicon.svg -w 16 -h 16 -e favicon.png
convert favicon.png favicon.ico
rm favicon.png 
