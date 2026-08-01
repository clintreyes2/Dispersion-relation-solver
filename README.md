# Dispersion-relation-solver

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21732033.svg)](https://doi.org/10.5281/zenodo.21732033)

MATLAB solver for the linear water-wave dispersion relation, including the propagating wavenumber and a user-specified number of evanescent-mode wavenumbers.
Solves the linear dispersion relation to obtain the real and imaginary wave numbers. 
Note that initial guess for the solution must be close to the right hand asymptote (closer to the positive x) and not the left hand. 

This function was separated from the repository accompanying:

> Reyes, C. C. M. and Huang, Z. (2026). *An analytical study of a dual-function oscillating water column with nonlinear power take-off and a slotted supporting wall*. Ocean Engineering. https://doi.org/10.1016/j.oceaneng.2026.127222

## Function

```matlab
k_ar = disp_rel_ee2(T, h, g, N)
```

### Inputs

- `T` — wave period, s
- `h` — water depth, m
- `g` — gravitational acceleration, m/s^2
- `N` — number of evanescent modes

### Output

- `k_ar` — `(N+1) x 1` vector in 1/m
  - `k_ar(1)` is the real propagating wavenumber
  - `k_ar(2:end)` are real-valued magnitudes representing the imaginary evanescent wavenumbers

The corresponding complex evanescent wavenumbers may be written as:

```matlab
k_evanescent = 1i * k_ar(2:end);
```

## Governing equations

For angular frequency `omega = 2*pi/T`, the propagating mode satisfies

```text
omega^2 = g k tanh(k h)
```

The evanescent roots are obtained from

```text
omega^2 = -g k_n tan(k_n h)
```

where the returned `k_n` values are stored as real positive root magnitudes.

## Example

```matlab
T = 1.5;
h = 0.8;
g = 9.81;
N = 5;

k = disp_rel_ee2(T, h, g, N);

disp('Propagating wavenumber:')
disp(k(1))

disp('Evanescent-mode magnitudes:')
disp(k(2:end))
```

A runnable version is provided in `examples/example_disp_rel_ee2.m`.

## Installation

Clone the repository and add it to the MATLAB path:

```matlab
addpath('/path/to/disp_rel_ee2')
```

No MATLAB toolboxes are required.

## Testing

Run:

```matlab
results = runtests('tests');
table(results)
```

The tests check the propagating and evanescent dispersion-relation residuals and output dimensions.

## Numerical note

The function uses Newton-Raphson iteration. For evanescent modes, the initial guess must remain on the intended tangent branch and close to the right-hand side of the relevant asymptote. The original initialization is retained to preserve compatibility with the parent model.

## Source

Originally distributed in:

`clintreyes2/Eigenfunction-expansion-of-an-Oscillating-water-column-slotted-breakwater`

## Citation

Please cite the software repository and the accompanying Ocean Engineering paper. 

## License

MIT License. See `LICENSE`.
