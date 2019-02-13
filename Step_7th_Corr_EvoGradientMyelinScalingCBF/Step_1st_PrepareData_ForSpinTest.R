
library(R.matlab)

ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
ResultsFolder = paste0(ReplicationFolder, '/results');
VariabilityLabel_Mat = readMat(paste0(ResultsFolder, '/SingleParcellation/SingleAtlas_Analysis/Variability_Visualize/VariabilityLabel.mat'));
VariabilityLoading_17SystemMean_Mat = readMat(paste0(ResultsFolder, '/SingleParcellation/SingleAtlas_Analysis/Variability_Visualize/VariabilityLoading_Median_17SystemMean.mat'));
AgeWeights_Mat = readMat(paste0(ResultsFolder, '/PredictionAnalysis/AtlasLoading/Weight_Age/w_Brain_Age_abs_sum.mat'));
EFWeights_Mat = readMat(paste0(ResultsFolder, '/PredictionAnalysis/AtlasLoading/Weight_EFAccuracy/w_Brain_EFAccuracy_abs_sum.mat'));

WorkingFolder = paste0(ResultsFolder, '/Corr_EvoGradientMyelinScalingCBF');
SpinTest_Folder = paste0(WorkingFolder, '/PermuteData_SpinTest');
dir.create(SpinTest_Folder, recursive = TRUE);

VariabilityLoading_17SystemMean_lh_CSV = data.frame(VariabilityLoading_lh = 
                                  t(VariabilityLoading_17SystemMean_Mat$VariabilityLoading.Median.17SystemMean.lh));
write.table(VariabilityLoading_17SystemMean_lh_CSV, paste0(SpinTest_Folder, '/VariabilityLoading_17SystemMean_lh.csv'), row.names = FALSE, col.names = FALSE);
VariabilityLoading_17SystemMean_rh_CSV = data.frame(VariabilityLoading_rh = 
                                  t(VariabilityLoading_17SystemMean_Mat$VariabilityLoading.Median.17SystemMean.rh));
write.table(VariabilityLoading_17SystemMean_rh_CSV, paste0(SpinTest_Folder, '/VariabilityLoading_17SystemMean_rh.csv'), row.names = FALSE, col.names = FALSE);

AgeWeights_lh_CSV = data.frame(AgeWeights_lh = t(AgeWeights_Mat$w.Brain.Age.abs.sum.lh));
write.table(AgeWeights_lh_CSV, paste0(SpinTest_Folder, '/AgeWeights_lh.csv'), row.names = FALSE, col.names = FALSE);
AgeWeights_rh_CSV = data.frame(AgeWeights_rh = t(AgeWeights_Mat$w.Brain.Age.abs.sum.rh));
write.table(AgeWeights_rh_CSV, paste0(SpinTest_Folder, '/AgeWeights_rh.csv'), row.names = FALSE, col.names = FALSE);

EFWeights_lh_CSV = data.frame(EFWeights_lh = t(EFWeights_Mat$w.Brain.EFAccuracy.abs.sum.lh));
write.table(EFWeights_lh_CSV, paste0(SpinTest_Folder, '/EFWeights_lh.csv'), row.names = FALSE, col.names = FALSE);
EFWeights_rh_CSV = data.frame(w.Brain.EFAccuracy.rh = t(EFWeights_Mat$w.Brain.EFAccuracy.abs.sum.rh));
write.table(EFWeights_rh_CSV, paste0(SpinTest_Folder, '/EFWeights_rh.csv'), row.names = FALSE, col.names = FALSE); 


