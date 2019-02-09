
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

ResultantFolder = AtlasLabel_17_Folder + '/Weight_Age';
Ridge_CZ_Sort_CategoricalFeatures.Ridge_Weight(SubjectsData, AgeYears, 1, 2, Alpha_Range, ResultantFolder, 1)



