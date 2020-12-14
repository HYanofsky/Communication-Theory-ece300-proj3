%% Q8: Evaluate the performance of the error correction
clc; clear; close all;

load('code.mat');       % c1, c2, G1, G2
load('syndrome.mat');   % S1, S2, E1, E2, SE_map1, SE_map2

[K1, N1] = size(G1);
[K2, N2] = size(G2);

H1 = parity_check(G1);
H2 = parity_check(G2);

%% randomly generate 10^5 words for each scheme, encode using generators
word_count = 1e5;

uncoded1 = de2bi(randi(2^K1-1, word_count, 1), K1);
uncoded2 = de2bi(randi(2^K2-1, word_count, 1), K2);

encoded1 = galois2_multiply(uncoded1, G1);
encoded2 = galois2_multiply(uncoded2, G2);

%% randomly corrupt bits with variable error probability
p_errs = linspace(1e-3, 1e-1, 20);

% results matrix; first dim is uncoded/coded, second is coding scheme 1/2
bers = zeros(2, 2, length(p_errs));

tic();
for i = 1:length(p_errs)
    % note: this takes a while.....
    p_err = p_errs(i);
    fprintf('(%fs) Simulating p_err=%f\n', toc(), p_err);
    bers(:, :, i) = [
        ber(corrupt_bitstring(uncoded1, p_err), uncoded1), ...
        ber(corrupt_bitstring(uncoded2, p_err), uncoded2); ...
        ber(correct_errors(SE_map1, H1, ...
            corrupt_bitstring(encoded1, p_err)), encoded1), ...
        ber(correct_errors(SE_map2, H2, ...
        corrupt_bitstring(encoded2, p_err)), encoded2)
    ];
end

%% plot results

uncoded1_bers = bers(1, 1, :);
uncoded2_bers = bers(1, 2, :);
encoded1_bers = bers(2, 1, :);
encoded2_bers = bers(2, 2, :);

hold on;
plot(p_errs, uncoded1_bers(:));
plot(p_errs, uncoded2_bers(:));
plot(p_errs, encoded1_bers(:));
plot(p_errs, encoded2_bers(:));
hold off;
grid on;
title('Bit error rate vs. bit corruption rate');
xlabel('P_{err}');
ylabel('BER');
legend([
    "Uncoded 1 (n=k=4)", "Uncoded 2 (n=k=4)", ...
    "Encoded 1 (n=8;k=4)", "Encoded 2 (n=12;k=4)"
]);