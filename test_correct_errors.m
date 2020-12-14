%% This file is just for testing the error correction schemes
clc; close all; clear;

load code.mat;
load syndrome.mat;

%%
e1 = [0 0 1 0 0 0 0 0];
rec = galois2_add(c1(3,:), e1)
H1 = parity_check(G1);

correct_errors(SE_map1, H1, rec)

%%
e2 = [0 1 1 1 1 1 0 0 1 0 0 0;
      0 0 0 0 1 0 1 0 0 0 0 0;
      0 0 0 0 1 0 0 0 0 1 0 0];
c2(5,:)
rec2 = galois2_add(c2(5,:), e2)
H2 = parity_check(G2);

correct_errors(SE_map2, H2, rec2)