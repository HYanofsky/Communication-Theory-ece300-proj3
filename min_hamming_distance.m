function min_dist = min_hamming_distance(code)
    min_dist = min(sum(code(2:end,:), 2));
end