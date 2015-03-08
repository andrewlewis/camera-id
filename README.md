# Digital camera identification tool

The implementation is based on [Digital Camera Identification from Sensor Pattern Noise](http://www.ws.binghamton.edu/fridrich/Research/double.pdf) (Lukáš, Fridrich and Goljan). My [multimedia forensics bibliography](https://micrological.appspot.com/static/cl/bibliography/index.html#camera-identification) lists more papers on this topic.

Prerequisites:
- pip install pillow cython pywavelets
- Run python setup.py build_ext in <code>accel</code>, then link the .so output into that directory.

## make_characteristic.py

Given a path containing PNG-format images, calculates the characteristic noise signal and outputs it to a file.

## test_characteristic.py

Outputs the correlation of a given characteristic noise signal and test image(s).
