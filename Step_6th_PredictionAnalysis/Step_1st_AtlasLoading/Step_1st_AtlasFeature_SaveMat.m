
clear
ResultsFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results';
PredictionFolder = [ResultsFolder '/PredictionAnalysis'];
Behavior_Mat = load([PredictionFolder '/Behavior_713.mat']);
BBLID = Behavior_Mat.BBLID;

AtlasLoading_Folder = [ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/FinalAtlasLoading'];
for i = 1:length(BBLID)
    i
    tmp = load([AtlasLoading_Folder '/' num2str(BBLID(i)) '.mat']); 
    [rowQuantity, colQuantity] = size(tmp.sbj_AtlasLoading_NoMedialWall);
    AtlasLoading_All(i, :) = reshape(tmp.sbj_AtlasLoading_NoMedialWall, 1, rowQuantity * colQuantity);
end
AtlasLoading_Sum = sum(AtlasLoading_All);
NonZeroIndex = find(AtlasLoading_Sum);
AtlasLoading_All_RemoveZero = AtlasLoading_All(:, NonZeroIndex);
mkdir([PredictionFolder '/AtlasLoading']);
save([PredictionFolder '/AtlasLoading/AtlasLoading_All.mat'], 'AtlasLoading_All');
save([PredictionFolder '/AtlasLoading/AtlasLoading_All_RemoveZero.mat'], 'AtlasLoading_All_RemoveZero', 'NonZeroIndex');
