from testing import assert_true

from quantumojo.vector import Vector


fn test_string() raises:
    var v = Vector[DType.float64, 4].build(SIMD[DType.float64, 4](1, 2, 3, 4))

    assert_true(str(v) == "¿1.0, 2.0, 3.0, 4.0?", str(v))
