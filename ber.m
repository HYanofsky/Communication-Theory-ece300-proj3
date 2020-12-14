% helper to calculate bit error rate (correctly counts NaNs as error bits)
function ber = ber(xhat, x)
    ber = nnz(xhat - x) / numel(x);
end