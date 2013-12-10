%%Make expert feature selection scatter and expert / full spectral
%%processing confusion plots

%Load the data:
clear all;
close all;

load libsCoinData.mat ds
dsBinary = ds.setY(ds.getY == 2); %Set the penny class to be non-zero
dsBinary.classNames = {'Non-Penny','Penny'};
%%
% wavelengthRange1 = [323.1 323.5];
% wavelengthRange2 = [674 675];
% wavelengthRange3 = [793.1 793.5];
wavelengthRange1 = [324.1 324.9];
wavelengthRange2 = [341.2 341.8];
wavelengthRange3 = [793.1 793.5];

fn = @(x)real(log(max(abs(x),[],2)));
featExt1 = prtFeatExtWavelengthRange('wavelengthRange',wavelengthRange1,'fn',fn);
featExt2 = prtFeatExtWavelengthRange('wavelengthRange',wavelengthRange2,'fn',fn);
featExt3 = prtFeatExtWavelengthRange('wavelengthRange',wavelengthRange3,'fn',fn);

dsExpert = catFeatures(featExt1.run(dsBinary),featExt2.run(dsBinary),featExt3.run(dsBinary));
dsExpert.featureNames = {'324 nm','341 nm','793 nm'};
close all;
plot(dsExpert);
title('3 Expert/Visually Selected Wavelengths');
%s2({'png','fig'},'libsChapter_Fig02_ExpertSelected');

%% Classify
plsda = prtClassPlsda + prtDecisionBinaryMinPe;
yOutExpert = plsda.kfolds(dsExpert,3);
yOutRaw = plsda.kfolds(dsBinary,3);

figure(1);
pcExpert = prtScorePercentCorrect(yOutExpert);
cm = prtScoreConfusionMatrix(yOutExpert);
[h1,h2,h3] = prtUtilPlotConfusionMatrix(cm,yOutExpert.classNames);
delete(h3);
title(sprintf('Expert Defined Feature Classification; %d%% Correct',round(pcExpert*100)));
%s2({'png','fig'},'libsChapter_Fig03_ExpertSelectedConfMat');

figure(2);
pcRaw = prtScorePercentCorrect(yOutRaw);
cm = prtScoreConfusionMatrix(yOutRaw);
[h1,h2,h3] = prtUtilPlotConfusionMatrix(cm,yOutExpert.classNames);
delete(h3);
title(sprintf('Full Spectra Classification; %d%% Correct',round(pcRaw*100)));
%s2({'png','fig'},'libsChapter_Fig04_FullSpectraConfMat');

%% SFS

featSel = prtFeatSelSfs;
featSel.evaluationMetric = @(ds)prtEvalAuc(prtClassPlsda('showProgressBar',false),ds,3);
featSel = featSel.train(dsBinary);

algo = prtClassPlsda + prtDecisionBinaryMinPe;
yOutFeatSel = algo.kfolds(featSel.run(dsBinary),3);

figure(3);
pcFeatSel = prtScorePercentCorrect(yOutFeatSel);
cm = prtScoreConfusionMatrix(pcFeatSel);
[h1,h2,h3] = prtUtilPlotConfusionMatrix(cm,yOutExpert.classNames);
delete(h3);
title(sprintf('SFS Feat Sel Classification; %d%% Correct',round(pcRaw*100)));
%s2({'png','fig'},'libsChapter_Fig06_FeatSelConfMat');