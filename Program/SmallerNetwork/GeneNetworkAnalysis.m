%% Loads interested 21 genes Corr Matrix
clc; clear all;
load ADGeneticRiskNetwork_Allen_8.mat;

%% Deletes nodes with only one degree (only one edge)
% VARIABLES
degree_threshold = 2;
C_Matrix=AllenBrain_FreesurferROIs_corr_ADGeneticRiskNetwork;

% ANALYSIS
C_Matrix_bin=C_Matrix~=0; 
% finds the number of degrees for each node
sum_BinMatrix=sum(C_Matrix_bin);
% filter out nodes with only one degree
idx_InterestedNode = find(sum_BinMatrix>=degree_threshold);
% include only interested 
C_Matrix=C_Matrix(:,idx_InterestedNode);
%% Convert Corr Matrix ==> .gexf
WriteCorrToGEXF(C_Matrix, AllenBrain_genesnames, ADgenes_AllenBrain_genesnames_location, 'Network_2Deg')