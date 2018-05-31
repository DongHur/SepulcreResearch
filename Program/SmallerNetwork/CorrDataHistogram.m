%%
Corr=AllenBrain_FreesurferROIs_corr_ADGeneticRiskNetwork(:);
Interested_Corr=Corr(Corr~=0)
figure
    hist(Interested_Corr);
    xlabel('Corr Values');
    title('Correlation Value Histogram');
%% Finds a good threshold for corr values
prct= prctile(Interested_Corr,97.5)
    