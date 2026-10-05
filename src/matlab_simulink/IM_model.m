% model parameters
fs=50;
p=1;
Rs=11;
Rr=10.3654;
Ls=0.0302409; 
Lr=0.0302409;
Msr=0.9644789;
J=0.011;
f=0.0001; %friction factor
Te=10^-4;%sample time

% simulink constant
sigma=1-(Msr^2/(Lr*Ls));
a=Rr/Lr;
b=Msr/(sigma*Ls*Lr);
c=f/J;
gamma=((Lr^2)*Rs+Msr^2)/(sigma*Ls*(Lr^2));
m=p*Msr/(J*Lr);
m1=1/(sigma*Ls);
ws=2*pi*fs;
