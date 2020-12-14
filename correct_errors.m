% correct_errors: returns corrected codeword if correctable, otherwise NaN
% params:
% SE_map= container.Map instance mapping syndromes to errors
% H     = parity check matrix for the code
% x     = received word (1 x N)
% returns:
% est   = estimated codeword if correctable, else NaN
function est = correct_errors(SE_map, H, x)
    try
        est = galois2_add(x, ...
            de2bi(SE_map(bi2de(galois2_multiply(x, H.'))), length(x)));
    catch
        % if not found in SE_map
        est = NaN * ones(size(x));
    end
end