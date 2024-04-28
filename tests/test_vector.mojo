from testing import assert_true

from quantumojo.vector import Vector


fn test_zeros() raises:
    var v = Vector[10].zeros()

    for i in range(10):
        assert_true(v[i] == 0)


fn test_linspace() raises:
    var v = Vector[11].linspace(0, 1)

    for i in range(len(v)):
        assert_true(v[i] == i / 10)  # 0, 0.1, 0.2, ..., 1


fn test_build_from_simd() raises:
    var l = SIMD[DType.float64, 4](1, 2, 3, 4)
    var v = Vector[4].build(l)

    for i in range(4):
        assert_true(v[i] == l[i])


fn test_add() raises:
    var v1 = Vector[4].build(SIMD[DType.float64, 4](1, 2, 3, 4))
    var v2 = Vector[4].build(SIMD[DType.float64, 4](5, 6, 7, 8))
    var v3 = v1 + v2

    for i in range(4):
        assert_true(v3[i] == v1[i] + v2[i])


fn test_sub() raises:
    var v1 = Vector[4].build(SIMD[DType.float64, 4](1, 2, 3, 4))
    var v2 = Vector[4].build(SIMD[DType.float64, 4](5, 6, 7, 8))
    var v3 = v1 - v2

    for i in range(4):
        assert_true(v3[i] == v1[i] - v2[i])
