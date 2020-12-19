%% Q8: Evaluate the performance of the error correction
clc; clear; close all;
set(0, 'defaultTextInterpreter', 'latex');

load('code.mat');       % c1, c2, G1, G2
load('syndrome.mat');   % S1, S2, E1, E2, SE_map1, SE_map2

[K1, N1] = size(G1);
[K2, N2] = size(G2);

H1 = parity_check(G1);
H2 = parity_check(G2);

%% randomly generate 10^5 words for each scheme & encode
word_count = 1e5;

uncoded1 = de2bi(randi(2^K1-1, word_count, 1), K1);
uncoded2 = de2bi(randi(2^K2-1, word_count, 1), K2);

encoded1 = galois2_multiply(uncoded1, G1);
encoded2 = galois2_multiply(uncoded2, G2);

%% randomly corrupt bits with variable error probability
p_errs = linspace(1e-3, 1e-1, 20);

% results matrix
bers = zeros(3, length(p_errs));

tic();
for i = 1:length(p_errs)
    % note: this takes a while.....
    p_err = p_errs(i);
    fprintf('(%fs) Simulating p_err=%f\n', toc(), p_err);
    bers(:, i) = [
        ber(corrupt_bitstring(uncoded1, p_err), uncoded1); ...
        ber(correct_errors(SE_map1, H1, ...
            corrupt_bitstring(encoded1, p_err)), encoded1); ...
        ber(correct_errors(SE_map2, H2, ...
            corrupt_bitstring(encoded2, p_err)), encoded2)
    ];
end

%% plot results

uncoded_bers = bers(1, :);
encoded1_bers = bers(2, :);
encoded2_bers = bers(3, :);

figure('visible', 'off', 'Position', [0 0 1000 750]);
plot(p_errs, uncoded_bers(:), ...
    p_errs, encoded1_bers(:), ...
    p_errs, encoded2_bers(:));
grid on;
title('Bit error rate vs. bit corruption rate');
xlabel('$P_{err}$');
ylabel('BER');
legend(["Uncoded", "Encoded 1 (n=8;k=4)", "Encoded 2 (n=12;k=4)"], ...
    'Location', 'northwest');
exportgraphics(gca(), 'ber_vs_bcr.pdf');