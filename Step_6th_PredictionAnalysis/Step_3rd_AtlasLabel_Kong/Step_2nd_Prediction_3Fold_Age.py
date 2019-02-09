
import scipy.io as sio
import numpy as np
import os
import sys
sys.path.append('/data/jux/BBL/projects/pncSingleFuncParcel/scripts/Toolbox');
import Ridge_CZ_Sort_CategoricalFeatures

PredictionFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/results/PredictionAnalysis';
AtlasLabel_17_Folder = PredictionFolder + '/AtlasLabel_17_Kong';
# Import data
AtlasLabel_17_Mat = sio.loadmat(AtlasLabel_17_Folder + '/AtlasLabel_17_All.mat');
Behavior_Mat = sio.loadmat(PredictionFolder + '/Behavior_713.mat');
SubjectsData = AtlasLabel_17_Mat['AtlasLabel_17_All'];

AgeYears = Behavior_Mat['AgeYears'];
AgeYears = np.transpose(AgeYears);
# Range of parameters
Alpha_Range = np.exp2(np.arange(16) - 10);

FoldQuantity = 2;

ResultantFolder = AtlasLabel_17_Folder + '/2Fold_Sort_Age';
Ridge_CZ_Sort_CategoricalFeatures.Ridge_KFold_Sort(SubjectsData, AgeYears, FoldQuantity, Alpha_Range, ResultantFolder, 1, 0);

# Permutation test, 1,000 times
Times_IDRange = np.arange(1000);
ResultantFolder = AtlasLabel_17_Folder + '/2Fold_Sort_Permutation_Age';
Ridge_CZ_Sort_CategoricalFeatures.Ridge_KFold_Sort_Permutation(SubjectsData, AgeYears, Times_IDRange, FoldQuantity, Alpha_Range, ResultantFolder, 1, 1000, 'all.q,basic.q')
