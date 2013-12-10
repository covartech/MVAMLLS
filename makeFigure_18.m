%% make figures showing KNN performance in resubstitution

clear all;
close all;

rvH1 = prtRvMvn('mu',[2 2],'sigma',eye(2));
rvH0 = prtRvMvn('mu',[0 0],'sigma',eye(2));

nSamples = 200;
x = cat(1,rvH0.draw(nSamples),rvH1.draw(nSamples));
y = prtUtilY(nSamples,nSamples);
ds = prtDataSetClass(x,y);


xTest = cat(1,rvH0.draw(nSamples),rvH1.draw(nSamples));
yTest = prtUtilY(nSamples,nSamples);
dsTest = prtDataSetClass(xTest,yTest);

%%
k = prtClassKnn('k',1);
k = k.train(ds);

subplot(2,2,1);
plot(ds);
title('Training Data');
subplot(2,2,2); 
plot(k); V = axis;

subplot(2,2,1); axis(V);

subplot(2,2,3); 
plot(dsTest); title('Testing Data'); 
 axis(V);

yOutTrain = k.run(ds);
yOutTest = k.run(dsTest);

subplot(2,2,4);
[pfTrain,pdTrain] = prtScoreRoc(yOutTrain);
[pfTest,pdTest] = prtScoreRoc(yOutTest);
h = plot(pfTrain,pdTrain,pfTest,pdTest);
set(h,'linewidth',3); legend(h,{'Resubstitution ROC','Testing Data ROC'},4);
title('ROCs for Training (Blue) and Testing (Green)');
% %s2({'png','fig'},'libsChapter_Fig18_ROCs');