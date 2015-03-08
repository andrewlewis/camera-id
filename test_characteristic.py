#!/usr/bin/env python

from make_characteristic import get_noise_from_file

import cPickle
import glob
import numpy
import sys

from PIL import Image, ImageOps

TILE_OVERLAP = 8

if len(sys.argv) != 3:
  print "Usage:\n\t%s noise_data.dat path_with_png_files" % (sys.argv[0],)
  sys.exit(0)

noise_file_name = sys.argv[1]
image_path_name = sys.argv[2]

# Load the camera noise.
camera_noise = numpy.loadtxt(noise_file_name, dtype=numpy.float)
camera_noise_average = numpy.average(camera_noise)
camera_noise -= camera_noise_average
camera_noise_norm = numpy.sqrt(numpy.sum(camera_noise * camera_noise))

file_list = glob.glob(image_path_name + '/*.png')
print "Processing %d images" % (len(file_list),)
for f in file_list:
  # Get this image's noise.
  image_noise = get_noise_from_file(f)
  image_noise_average = numpy.average(image_noise)
  image_noise -= image_noise_average
  image_noise_norm = numpy.sqrt(numpy.sum(image_noise * image_noise))

  # Calculate the correlation between the two signals.
  print "Dot product %s is: %s" % (f,
                                   numpy.sum(camera_noise * image_noise) /
                                     (camera_noise_norm * image_noise_norm))
