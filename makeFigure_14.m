%% Make a figure with two ROC's that acheive simila min PE

clear all;
close all;

nSamples = 200;

%4-D
rvH1 = prtRvMvn('mu',[0 0 2 0],'sigma',eye(4));
rvH0 = prtRvMvn('mu',[0 0 0 0],'sigma',eye(4));

x = cat(1,rvH0.draw(nSamples),rvH1.draw(nSamples));
y = prtUtilY(nSamples,nSamples);
ds = prtDataSetClass(x,y);

glrt = prtClassGlrt;
yOutGlrt = glrt.kfolds(ds,3);

knn = prtClassKnn('k',3);
yOutKnn = knn.kfolds(ds,3);

[pfGlrt,pdGlrt] = prtScoreRoc(yOutGlrt);
[pfKnn,pdKnn] = prtScoreRoc(yOutKnn);
peGlrt = prtUtilPfPd2Pe(pfGlrt,pdGlrt);
peKnn = prtUtilPfPd2Pe(pfKnn,pdKnn);

[minPeGlrt,minPeGlrtInd] = min(peGlrt);
[minPeKnn,minPeKnnInd] = min(peKnn);
h = plot(pfGlrt,pdGlrt,pfKnn,pdKnn);
hold on;
h2 = plot(pfGlrt(minPeGlrtInd),pdGlrt(minPeGlrtInd),'*',pfKnn(minPeKnnInd),pdKnn(minPeKnnInd),'*');

legend(h,{'Classifier 1','Classifier 2'});
title(sprintf('Two Classifier ROC Curves; Min Prob(Error) = %.1f%% (Blue), %.1f%% (Green)',minPeGlrt*100,minPeKnn*100));
xlabel('Pfa'); ylabel('Pd');
set(h,'linewidth',3);
hold off
% s2({'png','fig'},'libsChapter_Fig14_ROC');