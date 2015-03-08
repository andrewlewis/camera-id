cimport numpy
import numpy
DTYPE = numpy.float
ctypedef numpy.float_t DTYPE_t
cdef inline int int_max(int a, int b): return a if a >= b else b
cdef inline int int_min(int a, int b): return a if a <= b else b
def wiener_filter(numpy.ndarray[DTYPE_t, ndim=2]
                    subband_coefficients not None,
                  int sigma):
  cdef int \
    y, x, w, l, k, xmin, xmax, ymin, ymax
  assert subband_coefficients.dtype == DTYPE
  cdef numpy.ndarray[DTYPE_t, ndim=2] \
    result_coefficients = numpy.zeros_like(subband_coefficients)
  (xmin, xmax, ymin, ymax) = (0,
                              0,
                              subband_coefficients.shape[0] - 1,
                              subband_coefficients.shape[1] - 1)
  sigma_squared = float(sigma * sigma)
  for y in range(0, subband_coefficients.shape[1]):
    for x in range(0, subband_coefficients.shape[0]):
      variances = []
      for w in [3, 5, 7, 9]:
        accumulator = 0.0
        # The sub-band is padded by repetition.
        for l in range(-(w + 1) / 2, (w + 1) / 2 + 1):
          for k in range(-(w + 1) / 2, (w + 1) / 2 + 1):
            ki = int_min(int_max(x + k, xmin), xmax)
            li = int_min(int_max(y + l, ymin), ymax)
            accumulator += subband_coefficients[ki, li] * \
                               subband_coefficients[ki, li] \
                           - sigma_squared
        accumulator /= float(w * w)
        variances.append(max(0.0, accumulator))
      minimum_local_variance = min(variances)
      result_coefficients[x, y] = subband_coefficients[x, y] * \
                                  (minimum_local_variance / \
                                    (minimum_local_variance + sigma_squared))
  return result_coefficients
