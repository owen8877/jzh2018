clc; clear
'douhu';

load data/param_h.mat

x = 0.5;
alpha = 1.5;

index = findBestCore(x, posts_h, alpha);
index