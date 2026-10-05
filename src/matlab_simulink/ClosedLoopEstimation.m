% Extract data
W_motor = speed.Data';   % 1 x N
I_a = I_alpha.Data';     % 1 x N
I_b = I_beta.Data';      % 1 x N
V_a = V_alpha.Data';     % 1 x N
V_b = V_beta.Data';      % 1 x N

% Input matrix: 4 features x N samples
P = [I_a; I_b; V_a; V_b];  

% Target output: 1 x N samples
T = W_motor; 

% Create feedforward network
net = feedforwardnet([10 5],'trainbr');

% Set transfer functions
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'purelin';
 
% Configure data division
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.1;
net.divideParam.testRatio = 0.1;

% Training parameters
net.trainFcn = 'trainlm';
net.trainParam.epochs = 2000;
net.trainParam.goal = 1e-6;
net.trainParam.show = 25;

% Train network
net = train(net, P, T);

simNet = gensim(net);