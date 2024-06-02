from quantumojo.constants import *
from quantumojo.potential import HarmonicOscillator
from quantumojo.vector import Vector


fn main() -> None:
    alias N = 2**2 + 1
    alias D = DType.float64

    alias mass = 1.0 * electron_mass
    alias energy_spacing = 1.0 * electron_volt

    var potential = HarmonicOscillator[D].from_energy_spacing_and_mass(
        energy_spacing=energy_spacing,
        mass=mass,
        center=0,
    )

    var length_scale = potential.length_scale(mass)

    print("energy spacing (eV)", potential.energy_spacing(mass) / (electron_volt))
    print("E(n=0) (eV)", potential.state_energy(mass, 0) / (electron_volt))
    print("E(n=1) (eV)", potential.state_energy(mass, 1) / (electron_volt))
    print("E(n=2) (eV)", potential.state_energy(mass, 2) / (electron_volt))
    print("length scale (pm)", length_scale / (pico * meter))

    var z = Vector[D, N].linspace(-5 * length_scale, 5 * length_scale)

    print("z (pm)", z / (pico * meter))
    print("z (scale)", z / length_scale)
