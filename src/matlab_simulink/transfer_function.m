% Parameters
fs = 50;
p = 1;
Rs = 11;
Rr = 10.3654;
Ls = 0.0302409;
Lr = 0.0302409;
Msr = 0.9644789;
J = 0.011;
f = 0.0001;

% Equivalent inductance and resistance
Leq = Ls + (Msr^2 / Lr);
Req = Rs + (Rr * (Msr^2 / Lr^2));

% Torque constant
K = (3/2) * p * (Msr / Lr);

% Transfer function coefficients
a2 = J * Leq;
a1 = J * Req + f * Leq;
a0 = f * Req;

% Transfer function: Omega(s)/V(s)
num = [K];
den = [a2 a1 a0];
sys = tf(num, den);

% Display
disp('Transfer Function Omega(s)/V(s):');
sys