from testing import assert_true
from math import sqrt

from quantumojo.vector import Vector


fn test_add_scalar() raises:
    var v = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](1, 2, 3, 4))
    var v2 = v + 1

    for i in range(4):
        assert_true(v2[i] == v[i] + 1)


fn test_add_vector() raises:
    var v1 = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](1, 2, 3, 4))
    var v2 = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](5, 6, 7, 8))
    var v3 = v1 + v2

    for i in range(4):
        assert_true(v3[i] == v1[i] + v2[i])


fn test_sub_scalar() raises:
    var v = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](1, 2, 3, 4))
    var v2 = v - 1

    for i in range(4):
        assert_true(v2[i] == v[i] - 1)


fn test_sub_vector() raises:
    var v1 = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](1, 2, 3, 4))
    var v2 = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](5, 6, 7, 8))
    var v3 = v1 - v2

    for i in range(4):
        assert_true(v3[i] == v1[i] - v2[i])


fn test_mul_scalar() raises:
    var v = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](1, 2, 3, 4))
    var v2 = v * 2

    for i in range(4):
        assert_true(v2[i] == v[i] * 2)


fn test_mul_vector() raises:
    var v1 = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](1, 2, 3, 4))
    var v2 = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](5, 6, 7, 8))
    var v3 = v1 * v2

    for i in range(4):
        assert_true(v3[i] == v1[i] * v2[i])


fn test_div_scalar() raises:
    var v = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](1, 2, 3, 4))
    var v2 = v / 2

    for i in range(4):
        assert_true(v2[i] == v[i] / 2)


fn test_div_vector() raises:
    var v1 = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](1, 2, 3, 4))
    var v2 = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](5, 6, 7, 8))
    var v3 = v1 / v2

    for i in range(4):
        assert_true(v3[i] == v1[i] / v2[i])


fn test_dot() raises:
    var v1 = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](1, 2, 3, 4))
    var v2 = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](5, 6, 7, 8))
    var dot = v1.dot(v2)

    assert_true(dot == 1 * 5 + 2 * 6 + 3 * 7 + 4 * 8)
