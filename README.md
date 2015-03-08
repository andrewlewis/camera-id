# Digital camera identification tool

The implementation is based on [Digital Camera Identification from Sensor Pattern Noise](http://www.ws.binghamton.edu/fridrich/Research/double.pdf).

Prerequisites:
- pip install pillow cython pywavelets
- Run python setup.py build_ext in <code>accel</code>, then link the .so output into that directory.

## make_characteristic.py

Given a path containing PNG-format images, calculates the characteristic noise signal and outputs it to a file.

## test_characteristic.py

Outputs the correlation of a given characteristic noise signal and test image(s).
