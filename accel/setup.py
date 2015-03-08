# Compile with python setup.py build_ext

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy

ext_modules = [Extension("filter_accel",
                         ["filter_accel.pyx"],
                         extra_compile_args = ['-I%s' %
                           (numpy.get_include(),)])]

setup(name = 'Filtering accelerator',
      cmdclass = {'build_ext' : build_ext},
      ext_modules = ext_modules)
