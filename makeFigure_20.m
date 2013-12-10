%%

clear all;
close all;

nSamples = 200;

rv1 = prtRvMvn('mu',[2 2],'sigma',eye(2));
rv0 = prtRvMvn('mu',[0 0],'sigma',eye(2));

x = cat(1,rv0.draw(nSamples),rv1.draw(nSamples));
y = prtUtilY(nSamples,nSamples);

dsOrig = prtDataSetClass(x,y);

sensorSigma = eye(2)/40;
xLocal = [];
yLocal = [];
for h = 0:1
    for iter = 1:2;
        if h == 0
            exampleMean = rv0.draw(1);
        else
            exampleMean = rv1.draw(1);
        end
        localRv = prtRvMvn('mu',exampleMean,'sigma',sensorSigma);
        localSamples = localRv.draw(nSamples);
        
        xLocal = cat(1,xLocal,localSamples);
        yLocal = cat(1,yLocal,repmat(h,nSamples,1));
    end
end

dsLocal = prtDataSetClass(xLocal,yLocal);

%%
subplot(2,2,1); plot(dsOrig); title('Data from 400 Objects');
set(gca,'xtick',[]);
set(gca,'ytick',[]);
subplot(2,2,2); plot(dsLocal); title('Data from 4 Objects, 100 Times');
set(gca,'xtick',[]);
set(gca,'ytick',[]);

plsda = prtClassPlsda;
plsdaOrig = plsda.train(dsOrig);
plsdaLocal = plsda.train(dsLocal);

subplot(2,2,3); plot(plsdaOrig); title('PLSDA Using 400 Objects'); Vorig = axis; 
set(gca,'xtick',[]);
set(gca,'ytick',[]);
subplot(2,2,4); plot(plsdaLocal); title('PLSDA Using 4 Objects, 100 Times'); VLocal = axis;
set(gca,'xtick',[]);
set(gca,'ytick',[]);

subplot(2,2,1); axis(Vorig);
subplot(2,2,2); axis(VLocal);
% s2({'png','fig'},'libsChapter_Fig20_LocalVsGlobalData');