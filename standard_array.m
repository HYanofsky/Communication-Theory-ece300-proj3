%% This file generates the syndrome arrays S1 and S2 (corresponding to
% codes c1, c2)
clc; clear; close all;

% sac = standard array correctable
load('code.mat');

%% code 1
corr1 = 1;
k1 = 4;
n1 = 8;
sac_1 = zeros(8+1, 2^k1, n1);

% first row of standard array is no errors
sac_1(1, :, :) = c1;

I = eye(n1);

for i = 1:n1
    sac_1(i+1, :, :) = galois2_add(c1, I(i, :));
end

% create 
E1 = reshape(sac_1(:, 1, :), [], n1);
S1 = galois2_multiply(E1, parity_check(G1).');
SE_map1 = containers.Map(bi2de(S1), bi2de(E1));

%% code 2
corr2 = 2;
k2 = 4;
n2 = 12;
sac_2 = zeros(1+12+12*11/2, 2^k2, n2);

% 12
I = eye(n2);

% first row of standard array is no errors
sac_2(1, :, :) = c2;

counter = 2;

for i = 1:n2
    sac_2(counter, :, :) = galois2_add(c2, I(i, :));
    counter = counter + 1;
end

for i = 2:n2
    mat = I(i, :);
    for j = 1:i-1
        sac_2(counter, :, :) = galois2_add(c2, mat + I(j, :));
        counter = counter + 1;
    end
end

E2 = reshape(sac_2(:, 1, :), [], n2);
S2 = galois2_multiply(E2, parity_check(G2).');
SE_map2 = containers.Map(bi2de(S2), bi2de(E2));

%% save to .mat file
save('syndrome.mat', 'E1', 'S1', 'SE_map1', 'E2', 'S2', 'SE_map2');