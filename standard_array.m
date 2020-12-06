% sac = standard array correctable

%% code 1
corr1 = 1;
k1 = 4;
n1 = 8;
sac_1 = zeros(8, 2^k1, n1);

I = eye(n1);

for i = 1:n1
    sac_1(i, :, :) = galois2_add(c1, I(i, :));
end

trunc_sac_1 = sac_1(:, 1, :);

fprintf('Size of correctable standard array 1: %d\n', numel(sac_1)/n1);
fprintf('Size of truncated correctable standard array 1: %d\n', ...
    numel(trunc_sac_1)/n1);

%% code 2
corr2 = 2;
k2 = 4;
n2 = 12;
sac_2 = zeros(12+12*11/2, 2^k2, n2);

% 12
I = eye(n2);

counter = 1;

for i = 1:n2
    sac_2(counter, :, :) = galois2_add(c2, I(i, :));
    counter = counter + 1;
end

% something like 12x11 codewords = 132
for i = 2:n2
    mat = I(i, :);
    for j = 1:i-1
        sac_2(counter, :, :) = galois2_add(c2, mat + I(j, :));
        counter = counter + 1;
    end
end

trunc_sac_2 = sac_2(:, 1, :);

fprintf('Size of correctable standard array 2: %d\n', numel(sac_2)/n2);
fprintf('Size of truncated correctable standard array 2: %d\n', ...
    numel(trunc_sac_2)/n2);