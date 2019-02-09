
clear
SubjectsFolder = '/share/apps/freesurfer/6.0.0/subjects/fsaverage5';
% for surface data
surfML = [SubjectsFolder '/label/lh.Medial_wall.label'];
mwIndVec_l = read_medial_wall_label(surfML);
Index_l = setdiff([1:10242], mwIndVec_l);
surfMR = [SubjectsFolder '/label/rh.Medial_wall.label'];
mwIndVec_r = read_medial_wall_label(surfMR);
Index_r = setdiff([1:10242], mwIndVec_r);

ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
ResultsFolder = [ReplicationFolder '/results'];
EvoGradientEtc_ResultsFolder = [ReplicationFolder '/results/Corr_EvoGradientsMyelinCBF'];
% load variability
VariabilityLabel_Mat = load([ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/Variability_Visualize/VariabilityLabel.mat']);
VariabilityLabel_All_NoMedialWall = VariabilityLabel_Mat.VariabilityLabel_NoMedialWall;
VariabilityLabel_rh_NoMedialWall = VariabilityLabel_Mat.VariabilityLabel_rh(Index_r);
% load variability permutaion data
VariabilityLabel_Perm = load([EvoGradientEtc_ResultsFolder '/PermuteData_SpinTest/VariabilityLabel_Perm.mat']);
VariabilityLabel_Perm_All_NoMedialWall = [VariabilityLabel_Perm.bigrotl(:, Index_l) VariabilityLabel_Perm.bigrotr(:, Index_r)];
VariabilityLabel_Perm_rh_NoMedialWall = VariabilityLabel_Perm.bigrotr(:, Index_r);
% load variability (17 systems mean)
VariabilityLoading_Mat = load([ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/Variability_Visualize/VariabilityLoading_Median_17SystemMean.mat']);
VariabilityLoading_17SystemMean_All_NoMedialWall = VariabilityLoading_Mat.VariabilityLoading_Median_17SystemMean_NoMedialWall;
VariabilityLoading_17SystemMean_rh_NoMedialWall = VariabilityLoading_Mat.VariabilityLoading_Median_17SystemMean_rh(Index_r);
% load variability permutation data (17 systems mean)
VariabilityLoading_Perm = load([EvoGradientEtc_ResultsFolder '/PermuteData_SpinTest/VariabilityLoading_17SystemMean_Perm.mat']);
VariabilityLoading_17SystemMean_Perm_All_NoMedialWall = [VariabilityLoading_Perm.bigrotl(:, Index_l) VariabilityLoading_Perm.bigrotr(:, Index_r)];
VariabilityLoading_17SystemMean_Perm_rh_NoMedialWall = VariabilityLoading_Perm.bigrotr(:, Index_r);
% load age weights
AgeWeights = load([ResultsFolder '/PredictionAnalysis/AtlasLoading/Weight_Age/w_Brain_Age_abs_sum.mat']);
AgeWeights_All_NoMedialWall = AgeWeights.w_Brain_Age_abs_sum;
AgeWeights_rh_NoMedialWall = AgeWeights.w_Brain_Age_abs_sum_rh(Index_r);
% load age weights permutation data
AgeWeights_Perm = load([EvoGradientEtc_ResultsFolder '/PermuteData_SpinTest/AgeWeights_Perm.mat']);
AgeWeights_Perm_All_NoMedialWall = [AgeWeights_Perm.bigrotl(:, Index_l) AgeWeights_Perm.bigrotr(:, Index_r)];
AgeWeights_Perm_rh_NoMedialWall = AgeWeights_Perm.bigrotr(:, Index_r);
% load cognition weights
CognitionWeights = load([ResultsFolder '/PredictionAnalysis/AtlasLoading/Weight_EFAccuracy/w_Brain_EFAccuracy_abs_sum.mat']);
CognitionWeights_All_NoMedialWall = CognitionWeights.w_Brain_EFAccuracy_abs_sum;
CognitionWeights_rh_NoMedialWall = CognitionWeights.w_Brain_EFAccuracy_abs_sum_rh(Index_r);
% load cognition weights permutation data
CognitionWeights_Perm = load([EvoGradientEtc_ResultsFolder '/PermuteData_SpinTest/EFWeights_Perm.mat']);
CognitionWeights_Perm_All_NoMedialWall = [CognitionWeights_Perm.bigrotl(:, Index_l) CognitionWeights_Perm.bigrotr(:, Index_r)];
CognitionWeights_Perm_rh_NoMedialWall = CognitionWeights_Perm.bigrotr(:, Index_r);

EvoGradientEtc_DataFolder = [ReplicationFolder '/data/EvoGradientsMyelinCBF'];
% load evolutionary expansion
Evo_rh_gifti = gifti([EvoGradientEtc_DataFolder '/EvolutionaryExpansion/rh.Hill2010_evo_fsaverage5.func.gii']);
Evo_rh = Evo_rh_gifti.cdata;
Evo_rh_NoMedialWall = Evo_rh(Index_r);
% loading principle gradient
PrincipleGradient_lh_gifti = gifti([EvoGradientEtc_DataFolder '/PrincipleGradient/Gradients.lh.fsaverage5.func.gii']);
PrincipleGradient_lh = PrincipleGradient_lh_gifti.cdata(:, 1);
PrincipleGradient_rh_gifti = gifti([EvoGradientEtc_DataFolder '/PrincipleGradient/Gradients.rh.fsaverage5.func.gii']);
PrincipleGradient_rh = PrincipleGradient_rh_gifti.cdata(:, 1);
PrincipleGradient_All_NoMedialWall = [PrincipleGradient_lh(Index_l)' PrincipleGradient_rh(Index_r)'];
% loading myelin
Myelin_lh_gifti = gifti([EvoGradientEtc_DataFolder '/Myelin/MyelinMap.lh.fsaverage5.func.gii']);
Myelin_lh = Myelin_lh_gifti.cdata;
Myelin_rh_gifti = gifti([EvoGradientEtc_DataFolder '/Myelin/MyelinMap.rh.fsaverage5.func.gii']);
Myelin_rh = Myelin_rh_gifti.cdata;
Myelin_All_NoMedialWall = [Myelin_lh(Index_l)' Myelin_rh(Index_r)'];
% loading allometric scaling
AllometricScaling_lh_gifti = gifti([EvoGradientEtc_DataFolder '/AllometricScaling/lh.AllometricScaling_fsaverage5.func.gii']);
AllometricScaling_lh = AllometricScaling_lh_gifti.cdata;
AllometricScaling_rh_gifti = gifti([EvoGradientEtc_DataFolder '/AllometricScaling/rh.AllometricScaling_fsaverage5.func.gii']);
AllometricScaling_rh = AllometricScaling_rh_gifti.cdata;
AllometricScaling_All_NoMedialWall = [AllometricScaling_lh(Index_l)' AllometricScaling_rh(Index_r)'];
% loading mean CBF
MeanCBF_lh_gifti = gifti([EvoGradientEtc_DataFolder '/MeanCBF/lh.MeanCBF.fsaverage5.func.gii']);
MeanCBF_lh = MeanCBF_lh_gifti.cdata;
MeanCBF_rh_gifti = gifti([EvoGradientEtc_DataFolder '/MeanCBF/rh.MeanCBF.fsaverage5.func.gii']);
MeanCBF_rh = MeanCBF_rh_gifti.cdata;
MeanCBF_All_NoMedialWall = [MeanCBF_lh(Index_l)' MeanCBF_rh(Index_r)'];
% loading human macaque entropy
HumanMacaqueEntropy_lh_gifti = gifti([EvoGradientEtc_DataFolder '/HumanMacaque_Entropy/entropy.lh.fsaverage5.func.gii']);
HumanMacaqueEntropy_lh = HumanMacaqueEntropy_lh_gifti.cdata;
HumanMacaqueEntropy_rh_gifti = gifti([EvoGradientEtc_DataFolder '/HumanMacaque_Entropy/entropy.rh.fsaverage5.func.gii']);
HumanMacaqueEntropy_rh = HumanMacaqueEntropy_rh_gifti.cdata;
HumanMacaqueEntropy_All_NoMedialWall = [HumanMacaqueEntropy_lh(Index_l)' HumanMacaqueEntropy_rh(Index_r)'];

save([EvoGradientEtc_ResultsFolder '/AllData.mat'], 'VariabilityLabel_All_NoMedialWall', 'VariabilityLabel_rh_NoMedialWall', ...
    'VariabilityLabel_Perm_All_NoMedialWall', 'VariabilityLabel_Perm_rh_NoMedialWall', ...
    'VariabilityLoading_17SystemMean_All_NoMedialWall', 'VariabilityLoading_17SystemMean_rh_NoMedialWall', ...
    'VariabilityLoading_17SystemMean_Perm_All_NoMedialWall', 'VariabilityLoading_17SystemMean_Perm_rh_NoMedialWall', ...
    'AgeWeights_All_NoMedialWall', 'AgeWeights_rh_NoMedialWall', ...
    'AgeWeights_Perm_All_NoMedialWall', 'AgeWeights_Perm_rh_NoMedialWall', ...
    'CognitionWeights_All_NoMedialWall', 'CognitionWeights_rh_NoMedialWall', ...
    'CognitionWeights_Perm_All_NoMedialWall', 'CognitionWeights_Perm_rh_NoMedialWall', ...
    'Evo_rh_NoMedialWall', 'PrincipleGradient_All_NoMedialWall', ...
    'Myelin_All_NoMedialWall', 'AllometricScaling_All_NoMedialWall', ...
    'MeanCBF_All_NoMedialWall', 'AgeWeights_lhrhAvg_NoMedialWall', 'AgeWeights_Perm_lhrhAvg_NoMedialWall');

