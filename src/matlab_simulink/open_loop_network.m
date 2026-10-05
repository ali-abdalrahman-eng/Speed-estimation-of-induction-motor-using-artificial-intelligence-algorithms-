% Extract data and remove singleton dimensions before transpose
W_motor = squeeze(speed.Data)';    % From [250000,1,1] to [1,250000]
P = squeeze(P_real.Data)';         % From [250000,1,1] to [1,250000]
Q = squeeze(P_image.Data)';        % From [250000,1,1] to [1,250000]
V_mag = squeeze(V.Data)';          % From [250000,1,1] to [1,250000]
I_mag = squeeze(I.Data)';          % From [250000,1,1] to [1,250000]

% Combine inputs into one matrix (features x samples)
II = [V_mag; I_mag; P; Q];         % Size: (4 x number_of_samples)
T = W_motor;                       % Target vector (1 x number_of_samples)

% Create feedforward network with two hidden layers
net = feedforwardnet([10 5], 'trainbr');

% Set transfer functions for each layer
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'purelin';

% Data division for training, validation, testing
net.divideParam.trainRatio = 0.75;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.10;

% Adjust training parameters
net.trainParam.epochs = 1000;         % Increased epochs
net.trainParam.goal = 1e-6;            % Stricter goal
net.trainParam.mu_max = 1e10;          % Allow larger damping parameter
net.trainParam.max_fail = 30;           % More validation checks

% Train the network
[net, tr] = train(net, II, T);

% Calculate and display final Mean Squared Error (MSE)
y_pred = net(II);
mse_val = mean((T - y_pred).^2);
disp(['Final MSE: ', num2str(mse_val)]);

% Plot performance curves (Training, Validation, Test)
figure;
plot(tr.perf, 'b-', 'LineWidth', 1.5); hold on;
plot(tr.vperf, 'r-', 'LineWidth', 1.5);
plot(tr.tperf, 'g-', 'LineWidth', 1.5);
title('Performance Curves');
xlabel('Epochs');
ylabel('Mean Squared Error (MSE)');
legend('Training', 'Validation', 'Test');
grid on;
set(gca, 'YScale', 'log');  % Log scale for better visualization
figure;
% Plot Gradient vs Epochs
figure;
semilogy(tr.gradient, 'b-', 'LineWidth', 1.5);
title('Gradient Norm vs Training Epochs');
xlabel('Epoch Number');
ylabel('Gradient Norm (log scale)');
grid on;
hold on;
plot(length(tr.gradient), tr.gradient(end), 'ro', 'MarkerSize', 8, 'LineWidth', 2); % Mark final value
text(length(tr.gradient), tr.gradient(end), ...
    sprintf('  Final: %.2f', tr.gradient(end)), 'VerticalAlignment','bottom');
legend('Gradient', 'Final Value', 'Location', 'best');

% Plot Mu vs Epochs
figure;
semilogy(tr.mu, 'r-', 'LineWidth', 1.5);
title('Mu (Damping Parameter) vs Training Epochs');
xlabel('Epoch Number');
ylabel('Mu Value (log scale)');
grid on;
hold on;
plot(length(tr.mu), tr.mu(end), 'bo', 'MarkerSize', 8, 'LineWidth', 2); % Mark final value
text(length(tr.mu), tr.mu(end), ...
    sprintf('  Final: %.2e', tr.mu(end)), 'VerticalAlignment','bottom');
legend('Mu', 'Final Value', 'Location', 'best');

% Combined plot (Gradient and Mu together)
figure;
yyaxis left;
semilogy(tr.gradient, 'b-', 'LineWidth', 1.5);
ylabel('Gradient Norm (log scale)');
yyaxis right;
semilogy(tr.mu, 'r-', 'LineWidth', 1.5);
ylabel('Mu Value (log scale)');
title('Training Diagnostics');
xlabel('Epoch Number');
grid on;
legend('Gradient', 'Mu', 'Location', 'best');
% Generate Simulink block from trained network (optional)
simNet = gensim(net);

% Optionally save the trained network
% save('trained_network.mat', 'net');
