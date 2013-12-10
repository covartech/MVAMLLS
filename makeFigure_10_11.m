%%

clear all;
close all;
clc;

load libsCoinData.mat ds

%%
preProc = prtPreProcPca('nComponents',2);
preProcEnergy = prtPreProcEnergyNormalizeRows + prtPreProcPca('nComponents',2);
preProcAbs = prtPreProcAbsSumNormalizeRows + prtPreProcPca('nComponents',2);
preProcMinMax = prtPreProcMinMaxRows + prtPreProcPca('nComponents',2);

dsBoot = bootstrapByClass(ds,20);
dsBoot = dsBoot.retainFeatures(1:3:dsBoot.nFeatures);
dsBoot = dsBoot.retainFeatures(600:1000);
w = dsBoot.userData.wavelengths(1:3:end);
w = w(600:1000);

subplot(3,1,1); plotAsTimeSeries(dsBoot,[],w); axis tight; title('Raw LIBS Data'); legend off;
subplot(3,1,2); plotAsTimeSeries(rt(prtPreProcEnergyNormalizeRows,dsBoot),[],w); axis tight; title('Energy Normalized LIBS Data'); legend off;
subplot(3,1,3); plotAsTimeSeries(rt(prtPreProcMinMaxRows,dsBoot),[],w); axis tight; title('Min/Max Normalized LIBS Data');
subplot_ylabel('(Normalized) Spectrometer Outputs'); 
xlabel('Wavelength (nm)');

% s2({'png','fig'},'libsChapter_Fig10_LibsTimeSeries');
%%
close all;

preProc = prtPreProcPca('nComponents',2);
preProcEnergy = prtPreProcEnergyNormalizeRows + prtPreProcPca('nComponents',2);
preProcAbs = prtPreProcAbsSumNormalizeRows + prtPreProcPca('nComponents',2);
preProcMinMax = prtPreProcMinMaxRows + prtPreProcPca('nComponents',2);

subplot(2,2,1);  
plot(rt(preProc,ds)); 
legend off; 
set(gca,'xtick',[]);  
set(gca,'ytick',[]); 
title('Raw Data (2D PCA)');

subplot(2,2,2); 
plot(rt(preProcEnergy,ds));
legend off; 
set(gca,'xtick',[]);  
set(gca,'ytick',[]); 
title('Energy Norm (2D PCA)');

subplot(2,2,3);  
plot(rt(preProcAbs,ds));
legend off; 
set(gca,'xtick',[]);  
set(gca,'ytick',[]); 
title('Abs Magnitude (2D PCA)');

subplot(2,2,4);  
plot(rt(preProcMinMax,ds));
set(gca,'xtick',[]);  
set(gca,'ytick',[]); 
title('Min/Max (2D PCA)');

% s2({'png','fig'},'libsChapter_Fig11_LibsScatter');