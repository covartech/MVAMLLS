%%

clear all;
close all;
clc;

ds = prtDataGenUnimodal;

%%

plsda = prtClassPlsda;
logDisc = prtClassLogisticDiscriminant;
rvm = prtClassRvm;
knn = prtClassKnn;

plsda = plsda.train(ds);
logDisc = logDisc.train(ds);
rvm = rvm.train(ds);
knn = knn.train(ds);

subplot(2,2,1); plot(plsda); 
legend off; 
set(gca,'xtick',[]); 
set(gca,'ytick',[]);
title('PLSDA');

subplot(2,2,2); plot(logDisc);
legend off; 
set(gca,'xtick',[]); 
set(gca,'ytick',[]);
title('Logistic Disc');

subplot(2,2,3); plot(rvm);
legend off; 
set(gca,'xtick',[]); 
set(gca,'ytick',[]);
title('RVM');

subplot(2,2,4); plot(knn);
legend off; 
set(gca,'xtick',[]); 
set(gca,'ytick',[]);
title('KNN');

% s2({'png','fig'},'libsChapter_Fig12_Contours');