function corrupted = corrupt_bitstring(str, p_err)
    corrupted = galois2_add(str, rand(size(str)) < p_err);
end