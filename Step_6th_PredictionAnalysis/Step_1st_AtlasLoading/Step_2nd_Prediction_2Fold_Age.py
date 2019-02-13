
import scipy.io as sio
import numpy as np
import os
import sys
sys.path.append('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/scripts/Functions');
import Ridge_CZ_Sort

PredictionFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/PredictionAnalysis';
AtlasLoading_Folder = PredictionFolder + '/AtlasLoading';
# Import data
AtlasLoading_Mat = sio.loadmat(AtlasLoading_Folder + '/AtlasLoading_All_RemoveZero.mat');
Behavior_Mat = sio.loadmat(PredictionFolder + '/Behavior_713.mat');
SubjectsData = AtlasLoading_Mat['AtlasLoading_All_RemoveZero'];
AgeYears = Behavior_Mat['AgeYears'];
AgeYears = np.transpose(AgeYears);
# Range of parameters
Alpha_Range = np.exp2(np.arange(16) - 10);

FoldQuantity = 2;

ResultantFolder = AtlasLoading_Folder + '/2Fold_Sort_Age';
Ridge_CZ_Sort.Ridge_KFold_Sort(SubjectsData, AgeYears, FoldQuantity, Alpha_Range, ResultantFolder, 1, 0);

# Permutation test, 1,000 times
Times_IDRange = np.arange(1000);
ResultantFolder = AtlasLoading_Folder + '/2Fold_Sort_Permutation_Age';
Ridge_CZ_Sort.Ridge_KFold_Sort_Permutation(SubjectsData, AgeYears, Times_IDRange, FoldQuantity, Alpha_Range, ResultantFolder, 1, 1000, 'all.q,basic.q')
