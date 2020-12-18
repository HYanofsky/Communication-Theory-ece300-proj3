% correct_errors: returns corrected codeword if correctable,
% otherwise NaN
%
% params:
% SE_map= container.Map instance mapping syndromes to errors
% H     = parity check matrix for the code
% X     = received word ((# words) x N)
% returns:
% Xhat  = estimated codeword if correctable, else NaN
function Xhat = correct_errors(SE_map, H, X)
    % hashmap can only be accessed linearly (not vectorizable),
    % so this has to be implemented in a loop
    Xhat = zeros(size(X));
    for i = 1:size(X, 1)
        x = X(i, :);
        try
            Xhat(i,:) = galois2_add(x, ...
                de2bi(SE_map(bi2de(...
                    galois2_multiply(x, H.'))), length(x)));
        catch
            % if not found in SE_map
            Xhat(i,:) = NaN * ones(size(x));
        end
    end
end