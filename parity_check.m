function H=parity_check(G)
    [k,n]=size(G);
    P=G(:, [k+1: end]);
    I=eye(n-k);
    H=[transpose(P) I];
end