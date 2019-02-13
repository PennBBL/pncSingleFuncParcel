
clear
SpinTest_Folder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Corr_EvoGradientMyelinScalingCBF/PermuteData_SpinTest';

% Variability, 17 systems mean
Variability_lh_CSV_Path = [SpinTest_Folder '/VariabilityLoading_17SystemMean_lh.csv'];
Variability_rh_CSV_Path = [SpinTest_Folder '/VariabilityLoading_17SystemMean_rh.csv'];
Variability_Perm_File = [SpinTest_Folder '/VariabilityLoading_17SystemMean_Perm.mat'];
SpinPermuFS(Variability_lh_CSV_Path, Variability_rh_CSV_Path, 1000, Variability_Perm_File);
% Age weights
AgeWeights_lh_CSV_Path = [SpinTest_Folder '/AgeWeights_lh.csv'];
AgeWeights_rh_CSV_Path = [SpinTest_Folder '/AgeWeights_rh.csv'];
AgeWeights_Perm_File = [SpinTest_Folder '/AgeWeights_Perm.mat'];
SpinPermuFS(AgeWeights_lh_CSV_Path, AgeWeights_rh_CSV_Path, 1000, AgeWeights_Perm_File);
% EF weights
EFWeights_lh_CSV_Path = [SpinTest_Folder '/EFWeights_lh.csv'];
EFWeights_rh_CSV_Path = [SpinTest_Folder '/EFWeights_rh.csv'];
EFWeights_Perm_File = [SpinTest_Folder '/EFWeights_Perm.mat'];
SpinPermuFS(EFWeights_lh_CSV_Path, EFWeights_rh_CSV_Path, 1000, EFWeights_Perm_File);
