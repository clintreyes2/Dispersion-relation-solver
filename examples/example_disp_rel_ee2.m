%% Example: propagating and evanescent wavenumbers
clear; clc;

T = 1.5;       % wave period [s]
h = 0.8;       % water depth [m]
g = 9.81;      % gravitational acceleration [m/s^2]
N = 5;         % number of evanescent modes

k = disp_rel_ee2(T, h, g, N);

fprintf('Propagating wavenumber k0 = %.10f 1/m\n', k(1));
fprintf('Evanescent-mode magnitudes [1/m]:\n');
disp(k(2:end));

omega = 2*pi/T;
propagatingResidual = omega^2 - g*k(1)*tanh(k(1)*h);
evanescentResiduals = omega^2 + g*k(2:end).*tan(k(2:end)*h);

fprintf('Propagating residual = %.3e\n', propagatingResidual);
fprintf('Maximum evanescent residual = %.3e\n', max(abs(evanescentResiduals)));
