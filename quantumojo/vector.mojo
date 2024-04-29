from complex import ComplexFloat32, ComplexFloat64


@value
struct Vector[D: DType, N: Int](Sized):
    var data: DTypePointer[D]

    fn __init__(inout self):
        self.data = DTypePointer[D].alloc(N)
        memset_zero[D](self.data, N)

    fn __del__(owned self):
        self.data.free()

    @staticmethod
    fn zeros() -> Vector[D, N]:
        # Constructor implicitly sets all elements to zero
        return Vector[D, N]()

    @staticmethod
    fn linspace(start: Scalar[D], stop: Scalar[D]) -> Vector[D, N]:
        var v = Vector[D, N]()
        for i in range(N):
            v[i] = start + (stop - start) * i / (N - 1)
        return v

    @staticmethod
    fn build(values: SIMD[D, N]) -> Vector[D, N]:
        var v = Vector[D, N]()
        for i in range(len(values)):
            v[i] = values[i]
        return v

    fn __add__(inout self, other: Scalar[D]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] + other
        return result

    fn __add__(inout self, inout other: Vector[D, N]) -> Vector[D, N]:
        # TODO: Why does other need to be inout?
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] + other[i]
        return result

    fn __sub__(inout self, other: Scalar[D]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] - other
        return result

    fn __sub__(inout self, inout other: Vector[D, N]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] - other[i]
        return result

    fn __mul__(inout self, other: Scalar[D]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] * other
        return result

    fn __mul__(inout self, inout other: Vector[D]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] * other[i]
        return result

    fn __truediv__(inout self, other: Scalar[D]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] / other
        return result

    fn __truediv__(inout self, inout other: Vector[D, N]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] / other[i]
        return result

    fn dot(inout self, inout other: Vector[D, N]) -> Scalar[D]:
        var result = Scalar[D](0)
        for i in range(N):
            result += self[i] * other[i]
        return result

    # Because you can't impl for a specific type, you can't implement conjugate only on complex-valued vectors...
    # You can do that in Rust! https://docs.rs/ndarray/0.15.6/src/ndarray/impl_views/splitting.rs.html#171-207
    # The key is that in Rust you can `impl` a trait on a *partially-concrete* type.
    # (Maybe you can do the same with C# extension methods?)
    # In numpy they just check before calling: https://github.com/numpy/numpy/blob/main/numpy/_core/src/multiarray/multiarraymodule.c#L1328-L1330
    # But that's a runtime check!
    # Also it seems like there's no complex DType, because DTypes need to be single values?
    # So do you need to implement a separate complex-valued vector type that holds two vectors if you want this to be type-safe?

    fn __getitem__(inout self, i: Int) -> SIMD[D, 1]:
        return self.data[i]

    fn __setitem__(inout self, i: Int, value: Scalar[D]) -> None:
        self.data[i] = value

    fn __len__(self) -> Int:
        return N
