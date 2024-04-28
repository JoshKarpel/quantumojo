from testing import assert_true

from quantumojo.vector import Vector


fn test_zeros() raises:
    var v = Vector[10, DType.float64].zeros()

    for i in range(10):
        assert_true(v[i] == 0)


fn test_linspace() raises:
    var v = Vector[11, DType.float64].linspace(0, 1)

    for i in range(len(v)):
        assert_true(v[i] == i / 10)  # 0, 0.1, 0.2, ..., 1
