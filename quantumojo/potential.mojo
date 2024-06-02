from math import sqrt
from memory import memset, memset_zero, memcpy

from quantumojo.constants import pi, hbar
from quantumojo.vector import Vector


@value
struct HarmonicOscillator[D: DType]:
    var spring_constant: Scalar[D]
    var center: Scalar[D]

    @staticmethod
    fn from_omega_and_mass(
        omega: Scalar[D],
        mass: Scalar[D],
        center: Scalar[D],
    ) -> HarmonicOscillator[D]:
        return HarmonicOscillator(
            spring_constant=mass * (omega**2),
            center=center,
        )

    @staticmethod
    fn from_ground_state_energy_and_mass(
        ground_state_energy: Scalar[D],
        mass: Scalar[D],
        center: Scalar[D],
    ) -> HarmonicOscillator[D]:
        return HarmonicOscillator.from_omega_and_mass(
            omega=2 * ground_state_energy / hbar,
            mass=mass,
            center=center,
        )

    @staticmethod
    fn from_energy_spacing_and_mass(
        energy_spacing: Scalar[D],
        mass: Scalar[D],
        center: Scalar[D],
    ) -> HarmonicOscillator[D]:
        return HarmonicOscillator.from_omega_and_mass(
            omega=energy_spacing / hbar,
            mass=mass,
            center=center,
        )

    fn potential_energy[N: Int](self, z: Vector[D, N], t: Scalar[D]) -> Vector[D, N]:
        return 0.5 * self.spring_constant * ((z - self.center) ** 2)

    fn omega(self, mass: Scalar[D]) -> Scalar[D]:
        return sqrt(self.spring_constant / mass)

    fn frequency(self, mass: Scalar[D]) -> Scalar[D]:
        return self.omega(mass) / (2 * pi)

    fn period(self, mass: Scalar[D]) -> Scalar[D]:
        return 1 / self.frequency(mass)

    fn energy_spacing(self, mass: Scalar[D]) -> Scalar[D]:
        return hbar * self.omega(mass)

    fn state_energy(self, mass: Scalar[D], n: Int) -> Scalar[D]:
        return (0.5 + n) * self.energy_spacing(mass)

    fn length_scale(self, mass: Scalar[D]) -> Scalar[D]:
        return sqrt(hbar / (mass * self.omega(mass)))
