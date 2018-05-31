load AllenBrainDataForDong.mat

CorrMatrix = corr(AllenBrain_FreesurferROIs_meansubs_Z.');
CorrMatrix_size=size(CorrMatrix);

ADgenes={'MAPT', 'APOE', 'PICALM', 'BIN1', 'CLU', 'CR1', 'ABCA7', 'SORL1', ...
    'PLEKHC1', 'CD2AP', 'CD33', 'APP', 'PSEN1', 'PSEN2', 'CASS4', 'EPHA1', ...
    'PTK2B', 'INPP5D', 'MEF2C', 'CUGBP1', 'MADD'};
ADgenes_size=size(ADgenes);

ADgenes_AllenBrain_genesnames_location=zeros(ADgenes_size(1,2),1);
for gen=1:ADgenes_size(1,2);
    A=strmatch(ADgenes(gen), AllenBrain_genesnames, 'exact');
    if isempty(A)==1;
        ADgenes_AllenBrain_genesnames_location(gen,1)=nan;
    else
        ADgenes_AllenBrain_genesnames_location(gen,1)=A;
    end
end
% sorting the indices of the gene location in the data from smallest to
% larges
ADgenes_AllenBrain_genesnames_location=sort(ADgenes_AllenBrain_genesnames_location);
AllenBrain_FreesurferROIs_corr_ADGeneticRiskNetwork=CorrMatrix(ADgenes_AllenBrain_genesnames_location,:);
AllenBrain_FreesurferROIs_corr_ADGeneticRiskNetwork(AllenBrain_FreesurferROIs_corr_ADGeneticRiskNetwork<0.8)=0;
% figure
% histogram(AllenBrain_FreesurferROIs_corr_ADGeneticRiskNetwork(:));
save ADGeneticRiskNetwork_Allen_8.mat