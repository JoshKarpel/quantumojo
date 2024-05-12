from testing import assert_true
from math import sqrt

from quantumojo.vector import Vector


fn test_copyinit() raises:
    var v = Vector[DType.float64, 1].zeros()
    var w = v

    assert_true(v == w)

    print(v)
    print(w)

    w[0] = 1

    assert_true(v[0] == 0, str(v))
    assert_true(w[0] == 1, str(w))
    assert_true(v != w)
