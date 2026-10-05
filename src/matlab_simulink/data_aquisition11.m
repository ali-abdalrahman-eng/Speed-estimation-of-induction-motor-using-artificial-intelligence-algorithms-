% Initialize empty vectors
O = [];
V1 = [];
V2 = [];
I1 = [];
I2 = [];
Te=0.001;
%channel zeros 
O_zero = 0;
V1_zero = 1850;
V2_zero = 1850;
I1_zero = 1930;
I2_zero = 2020;

%channel scaling
scale_V1 = 0.32468;
scale_V2 = 0.32468;
scale_I1 = 0.00519;
scale_I2 = 0.00519;
scale_O = (3.3*2000)/(6*4095);

% Open the file for reading
fid = fopen('C:\Users\ali\Desktop\Training_dat\new.txt', 'r');
if fid == -1
    error('Cannot open the file');
end

% Read line by line until the end of the file
while ~feof(fid)
    tline = fgetl(fid);
    if ischar(tline)
        % Use regular expressions to extract numbers after each channel label
        % The pattern finds 'label : number'
        tokens = regexp(tline, 'O\s*:\s*(\d+)\s*,\s*V1\s*:\s*(\d+)\s*,\s*V2\s*:\s*(\d+)\s*,\s*I1\s*:\s*(\d+)\s*,\s*I2\s*:\s*(\d+)', 'tokens');
        if ~isempty(tokens)
            vals = str2double(tokens{1});
            O(end+1) = vals(1);
            V1(end+1) = vals(2);
            V2(end+1) = vals(3);
            I1(end+1) = vals(4);
            I2(end+1) = vals(5);
        end
    end
end

fclose(fid);
%channel scaling 
V1_adj = (V1 - V1_zero) * scale_V1;
%V2_adj = (V2 - V2_zero) * scale_V2;

Va_hilbert = hilbert(V1_adj);  % Analytic signal: Va + j*quadrature
V2_adj = real(Va_hilbert * exp(-1j*2*pi/3));  % 120° lag
Vc = real(Va_hilbert * exp(1j*2*pi/3));   % 120° lead




I1_adj = (I1 - I1_zero) * scale_I1;
I2_adj = (I2 - I2_zero) * scale_I2;
O_adj = (O - O_zero) * scale_O;
%ploting curves
% Number of samples

numSamples = length(I1);


Ts = 0.001;                  % Sampling time
t = (0:length(V1_adj)-1) * Ts;  % Time vector
% Create a sample index vector from 1 to numSamples
% Plotting each channel in a subplot with labels and grid
figure;

subplot(3,2,1);
plot(t, I1_adj, '-b');
title('Current I1 vs Sample Number');
xlabel('Sample Number');
ylabel('I1 Value');
grid on;

subplot(3,2,2);

plot(t, I2_adj, '-r');
title('Current I2 vs Sample Number');
xlabel('Sample Number');
ylabel('I2 Value');
grid on;

subplot(3,2,3);
plot(t, V1_adj, '-g');
title('Voltage V1 vs Sample Number');
xlabel('Sample Number');
ylabel('V1 Value');
grid on;

subplot(3,2,4);
plot(t, V2_adj, '-m');
title('Voltage V2 vs Sample Number');
xlabel('Sample Number');
ylabel('V2 Value');
grid on;
 
subplot(3,2,5);
plot(t, O_adj, '-m');
title('Speed vs Sample Number');
xlabel('Sample Number');
ylabel('Speed value');
grid on;
