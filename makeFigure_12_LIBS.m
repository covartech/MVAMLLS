%%

clear all;
close all;
clc;

load libsCoinData.mat ds

ds = rt( prtPreProcEnergyNormalizeRows + prtPreProcPca('nComponents',2), ds);
%%

plsda = prtClassPlsda;
logDisc = prtClassBinaryToMaryOneVsAll('baseClassifier',prtClassLogisticDiscriminant);
rvm = prtClassBinaryToMaryOneVsAll('baseClassifier',prtClassRvm);
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

% s2({'png','fig'},'libsChapter_Fig12_ContoursLibs');

%%
yOutPlsda = rt(prtDecisionMap,plsda.kfolds(ds,3));
yOutLogDisc = rt(prtDecisionMap,logDisc.kfolds(ds,3));
yOutRvm = rt(prtDecisionMap,rvm.kfolds(ds,3));
yOutKnn = rt(prtDecisionMap,knn.kfolds(ds,3));

prtScorePercentCorrect(yOutPlsda)
prtScorePercentCorrect(yOutLogDisc)
prtScorePercentCorrect(yOutRvm)
prtScorePercentCorrect(yOutKnn)