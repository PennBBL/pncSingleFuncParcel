
clear
ResultsFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/results';
PredictionFolder = [ResultsFolder '/PredictionAnalysis'];
Behavior_Mat = load([PredictionFolder '/Behavior_713.mat']);
BBLID = Behavior_Mat.BBLID;

% Atlas 17
AtlasLabel_17 = [ResultsFolder '/Atlas_Surface/Parcel_3Modality_TaskRegress_17/SingleParcel_1by1_100/FinalLabel_NoMedialWall'];
for i = 1:length(BBLID)
    i
    tmp = load([AtlasLabel_17 '/' num2str(BBLID(i)) '.mat']); 
    AtlasLabel_17_All(i, :) = tmp.sbj_Label;
end
mkdir([PredictionFolder '/AtlasLabel_17_100']);
save([PredictionFolder '/AtlasLabel_17_100/AtlasLabel_17_All.mat'], 'AtlasLabel_17_All');
