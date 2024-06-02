from python import Python

from quantumojo.vector import Vector


def plot[D: DType, N: Int](x: Vector[D, N], y: Vector[D, N], path: String) -> None:
    np = Python.import_module("numpy")
    plt = Python.import_module("matplotlib.pyplot")

    var x_arr = np.zeros(N, np.float64)
    var y_arr = np.zeros(N, np.float64)

    for idx in range(N):
        x_arr.itemset(idx, x[idx])
        y_arr.itemset(idx, y[idx])

    var fig = plt.figure(figsize=(8, 6), layout="constrained")
    var ax = fig.add_subplot()
    ax.plot(x_arr, y_arr)

    fig.savefig(path)
