%% Make the figure showing ACME glass data and LIBS spectral data

%Load the data:
clear all;
close all;

load libsCoinData.mat ds
dsAcme = prtDataGenUnimodal;
dsAcme.classNames = {'Defective','Satisfactory'};

%% Make figure
subplot(2,1,1);
dsAcme.plot;
xlabel('Transparency'); ylabel('Weight');
set(gca,'xtick',[]);
set(gca,'ytick',[]);
title('Sample (Synthetic) ACME Data'); 

subplot(2,1,2);
dsBoot = ds.bootstrapByClass(20);
dsBoot.plotAsTimeSeries([],dsBoot.userData.wavelengths);

axis tight;
ylim([0 1000]);
title('Sample LIBS Coin Data');
xlabel('Wavelength (nm)');
ylabel('Magnitude');

%Print the figure:
%s2({'png','fig'},fullfile('figs','libsChapter_Fig01_ACME_LibsCoins'));