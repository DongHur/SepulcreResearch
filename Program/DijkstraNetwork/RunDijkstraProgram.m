%%
load("AllenBrainDataForDong.mat")
CorrMatrix = corr(AllenBrain_FreesurferROIs_meansubs_Z.');
CorrMatrix(CorrMatrix < 0.25) =  0;
nv = 20737;
mind = dijkstra_fun( nv, CorrMatrix, 2814 );
