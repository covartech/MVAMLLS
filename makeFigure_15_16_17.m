%%

clear all;
close all;
clc

%note, this matters.  Overtraining is more severe for larger numbers of
%components; at around 4 components, Grid and Random become pretty similar
%(74% correct or so).
nComponents = 10; 

load libsCoinData.mat ds
obsInfo = ds.observationInfo;

gridKeys = cat(1,obsInfo.gridNumber);
batchKeys = cat(1,obsInfo.batch);

algo = prtClassPlsda('nComponents',nComponents) + prtDecisionMap;

yOutRandom = algo.kfolds(ds,2);
yOutGrid = algo.crossValidate(ds,gridKeys);
yOutBatch = algo.crossValidate(ds,batchKeys);

cmRandom = prtScoreConfusionMatrix(yOutRandom);
pcRandom = prtScorePercentCorrect(yOutRandom);

cmGrid = prtScoreConfusionMatrix(yOutGrid);
pcGrid = prtScorePercentCorrect(yOutGrid);

cmBatch = prtScoreConfusionMatrix(yOutBatch);
pcBatch = prtScorePercentCorrect(yOutBatch);

figure(1); 
[h1,h2,h3] = prtUtilPlotConfusionMatrix(cmRandom,yOutRandom.classNames);
title(sprintf('10 Component PLSDA - Random Cross-Validation, %.0f%% Correct',pcRandom*100));
delete(h3);
% s2({'png','fig'},'libsChapter_Fig15_RandomConfMat');

figure(2); 
[h1,h2,h3] = prtUtilPlotConfusionMatrix(cmGrid,yOutGrid.classNames);
title(sprintf('10 Component PLSDA - Grid Cross-Validation, %.0f%% Correct',pcGrid*100));
delete(h3);
% s2({'png','fig'},'libsChapter_Fig16_GridConfMat');

figure(3); 
[h1,h2,h3] = prtUtilPlotConfusionMatrix(cmBatch,yOutBatch.classNames);
title(sprintf('10 Component PLSDA - Batch Cross-Validation, %.0f%% Correct',pcBatch*100));
delete(h3);
% s2({'png','fig'},'libsChapter_Fig17_BatchConfMat');
