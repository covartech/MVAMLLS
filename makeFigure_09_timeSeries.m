close all;
clear all;

% ds = prtDataGenUnimodal;
% dsUni2 = prtDataGenUnimodal;
% ds = catFeatures(ds,dsUni2.retainFeatures(1));
nSamples = 200;

%4-D
rvH1 = prtRvMvn('mu',[0 0 2 0],'sigma',eye(4));
rvH0 = prtRvMvn('mu',[0 0 0 0],'sigma',eye(4));

%3-D
%rvH1 = prtRvMvn('mu',[0 0 2],'sigma',eye(3));
%rvH0 = prtRvMvn('mu',[0 0 0],'sigma',eye(3));

x = cat(1,rvH0.draw(nSamples),rvH1.draw(nSamples));
y = prtUtilY(nSamples,nSamples);
ds = prtDataSetClass(x,y);

subplot(2,2,1); 
%plot(ds.retainFeatures(1:3)); 
plotAsTimeSeries(ds); 
title('Original Data'); 
legend off;
grid on;
xlabel('');
ylabel(''); 
zlabel(''); 
set(gca,'xticklabel',[],'yticklabel',[],'zticklabel',[]);

subplot(2,2,2); 
%plot(retainFeatures(rt(prtPreProcEnergyNormalizeRows,ds),1:3)); 
plotAsTimeSeries(rt(prtPreProcEnergyNormalizeRows,ds)); 
title('Energy Norm'); 
legend off;
grid on;
xlabel('');
ylabel(''); 
zlabel(''); 
set(gca,'xticklabel',[],'yticklabel',[],'zticklabel',[]);

subplot(2,2,3); 
%plot(retainFeatures(rt(prtPreProcAbsSumNormalizeRows,ds),1:3)); 
plotAsTimeSeries(rt(prtPreProcAbsSumNormalizeRows,ds)); 
title('Absolute-Value Norm'); 
legend off;
grid on;
xlabel('');
ylabel(''); 
zlabel(''); 
set(gca,'xticklabel',[],'yticklabel',[],'zticklabel',[]);
axis tight;

subplot(2,2,4); 
%plot(retainFeatures(rt(prtPreProcMinMaxRows,ds),1:3)); 
plotAsTimeSeries(rt(prtPreProcMinMaxRows,ds)); 
title('Min/Max Norm'); 
grid on;
xlabel('');
ylabel(''); 
zlabel(''); 
set(gca,'xticklabel',[],'yticklabel',[],'zticklabel',[]);

% s2({'png','fig'},'libsChapter_Fig09_PreProc_TimeSeries');