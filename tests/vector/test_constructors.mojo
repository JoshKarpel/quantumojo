from testing import assert_true
from math import sqrt

from quantumojo.vector import Vector


fn test_init() raises:
    var v = Vector[DType.float64, 10]()

    for i in range(10):
        assert_true(v[i] == 0)


fn test_zeros() raises:
    var v = Vector[DType.float64, 10].zeros()

    for i in range(10):
        assert_true(v[i] == 0)


fn test_linspace() raises:
    var v = Vector[DType.float64, 11].linspace(0, 1)

    for i in range(len(v)):
        assert_true(v[i] == i / 10)  # 0, 0.1, 0.2, ..., 1


fn test_build_from_simd() raises:
    var v = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](1, 2, 3, 4))

    for i in range(4):
        assert_true(v[i] == i + 1)


fn test_build_from_scalar() raises:
    var v = Vector[DType.float64, 4].build(1)

    for i in range(4):
        assert_true(v[i] == 1)
