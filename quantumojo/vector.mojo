@value
struct Vector[N: Int, D: DType = DType.float64]:
    var data: DTypePointer[D]

    fn __init__(inout self):
        self.data = DTypePointer[D].alloc(N)
        for i in range(N):
            self[i] = 0

    @staticmethod
    fn zeros() -> Vector[N, D]:
        return Vector[N, D]()

    @staticmethod
    fn linspace(start: Scalar[D], stop: Scalar[D]) -> Vector[N, D]:
        var v = Vector[N, D]()
        for i in range(N):
            v[i] = start + (stop - start) * i / (N - 1)
        return v

    fn __del__(owned self):
        self.data.free()

    fn __getitem__(inout self, i: Int) -> SIMD[D, 1]:
        return self.data[i]

    fn __setitem__(inout self, i: Int, value: Scalar[D]) -> None:
        self.data[i] = value
