function tests = test_disp_rel_ee2
tests = functiontests(localfunctions);
end

function testOutputSize(testCase)
T = 1.5;
h = 0.8;
g = 9.81;
N = 5;

k = disp_rel_ee2(T, h, g, N);
verifySize(testCase, k, [N+1, 1]);
verifyTrue(testCase, all(isfinite(k)));
end

function testPropagatingResidual(testCase)
T = 1.5;
h = 0.8;
g = 9.81;
N = 5;

k = disp_rel_ee2(T, h, g, N);
omega = 2*pi/T;
residual = omega^2 - g*k(1)*tanh(k(1)*h);

verifyLessThan(testCase, abs(residual), 1e-10);
end

function testEvanescentResiduals(testCase)
T = 1.5;
h = 0.8;
g = 9.81;
N = 5;

k = disp_rel_ee2(T, h, g, N);
omega = 2*pi/T;
residuals = omega^2 + g*k(2:end).*tan(k(2:end)*h);

verifyLessThan(testCase, max(abs(residuals)), 1e-9);
end
