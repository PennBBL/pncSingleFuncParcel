
import scipy.io as sio
import numpy as np
import os
import sys
sys.path.append('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/scripts/Functions');
import Ridge_CZ_Random

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

ResultantFolder = AtlasLoading_Folder + '/2Fold_Age_RandomCV';
Ridge_CZ_Random.Ridge_KFold_RandomCV_MultiTimes(SubjectsData, AgeYears, FoldQuantity, Alpha_Range, 20, ResultantFolder, 1, 0);

