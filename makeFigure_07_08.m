%% Make PCA and PLS figure

%Load the data:
clear all;
close all;

load libsCoinData.mat ds
prtPath('beta')
%ZMUV data so PCA and PLS can look different; otherwise both dominated by
%large spectral peaks
preProc = prtPreProcEnergyNormalizeRows + prtPreProcZmuv;
preProc = preProc.train(ds);
ds = preProc.run(ds);
%% 

pca = prtPreProcPca('nComponents',2);
pls = prtPreProcPls('nComponents',2);

pca = pca.train(ds);
pls = pls.train(ds);

dsPca = pca.run(ds);
dsPls = pls.run(ds);

figure(1); plot(dsPca); title('LIBS Coin Data; Energy Norm, ZMUV, and PCA Projected');
% s2({'png','fig'},'libsChapter_Fig07_PCA');
figure(2); plot(dsPls); title('LIBS Coin Data; Energy Norm, ZMUV, and PLS Projected');
% s2({'png','fig'},'libsChapter_Fig08_PLS');