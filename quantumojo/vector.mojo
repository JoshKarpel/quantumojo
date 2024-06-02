from math import sqrt
from memory import memset, memset_zero, memcpy


@value
struct Vector[D: DType, N: Int](Sized, Stringable):
    var data: DTypePointer[D]

    fn __init__(inout self):
        self.data = DTypePointer[D].alloc(N)
        memset_zero[D](self.data, N)

    fn __copyinit__(inout self, existing: Vector[D, N]):
        self.data = DTypePointer[D].alloc(N)
        memcpy[N](self.data, existing.data)

    fn __del__(owned self):
        self.data.free()

    fn __str__(self) -> String:
        var s = String()

        for i in range(N):
            s += str(self[i])
            if i < N - 1:
                s += " "

        return "〈 " + s + " 〉"

    @staticmethod
    fn zeros() -> Vector[D, N]:
        # Constructor implicitly sets all elements to zero
        return Vector[D, N]()

    @staticmethod
    fn build(values: SIMD[D, N]) -> Vector[D, N]:
        var v = Vector[D, N]()
        # TODO: should be able to set the whole width at once?
        for i in range(N):
            v[i] = values[i]
        return v

    @staticmethod
    fn linspace(start: Scalar[D], stop: Scalar[D]) -> Vector[D, N]:
        var v = Vector[D, N]()
        for i in range(N):
            v[i] = start + (stop - start) * i / (N - 1)
        return v

    fn __eq__(self, other: Vector[D, N]) -> Bool:
        for i in range(N):
            if self[i] != other[i]:
                return False
        return True

    fn __ne__(self, other: Vector[D, N]) -> Bool:
        for i in range(N):
            if self[i] != other[i]:
                return True
        return False

    fn __getitem__(self, i: Int) -> SIMD[D, 1]:
        return self.data[i]

    fn __setitem__(inout self, i: Int, value: Scalar[D]) -> None:
        self.data[i] = value

    fn __len__(self) -> Int:
        return N

    fn __add__(self, other: Scalar[D]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] + other
        return result

    fn __add__(self, inout other: Vector[D, N]) -> Vector[D, N]:
        # TODO: Why does other need to be inout?
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] + other[i]
        return result

    fn __sub__(self, other: Scalar[D]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] - other
        return result

    fn __sub__(self, other: Vector[D, N]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] - other[i]
        return result

    fn __mul__(self, other: Scalar[D]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] * other
        return result

    fn __mul__(self, other: Vector[D]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] * other[i]
        return result

    fn __rmul__(self, other: Scalar[D]) -> Vector[D, N]:
        return self * other

    fn __pow__(self, other: Scalar[D]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] ** other
        return result

    fn __truediv__(self, other: Scalar[D]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] / other
        return result

    fn __truediv__(self, other: Vector[D, N]) -> Vector[D, N]:
        var result = Vector[D, N]()
        for i in range(N):
            result[i] = self[i] / other[i]
        return result

    fn dot(self, other: Vector[D, N]) -> Scalar[D]:
        var result = Scalar[D](0)
        for i in range(N):
            result += self[i] * other[i]
        return result
