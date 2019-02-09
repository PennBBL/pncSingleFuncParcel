
clear
ResultsFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/results';
PredictionFolder = [ResultsFolder '/PredictionAnalysis'];
Behavior_Mat = load([PredictionFolder '/Behavior_713.mat']);
BBLID = Behavior_Mat.BBLID;

SubjectsFolder = '/share/apps/freesurfer/6.0.0/subjects/fsaverage5';
% for surface data
surfML = [SubjectsFolder '/label/lh.Medial_wall.label'];
mwIndVec_l = read_medial_wall_label(surfML);
Index_l = setdiff([1:10242], mwIndVec_l);
surfMR = [SubjectsFolder '/label/rh.Medial_wall.label'];
mwIndVec_r = read_medial_wall_label(surfMR);
Index_r = setdiff([1:10242], mwIndVec_r);

% Atlas 17
AtlasLabel_17 = [ResultsFolder '/Atlas_Surface_Kong/WorkingFolder/ind_parcellation_200_30'];
for i = 1:length(BBLID)
    i
    tmp = load([AtlasLabel_17 '/' num2str(BBLID(i)) '.mat']); 
    AtlasLabel_17_All(i, :) = [tmp.lh_labels(Index_l)' tmp.rh_labels(Index_r)'];
end
mkdir([PredictionFolder '/AtlasLabel_17_Kong']);
save([PredictionFolder '/AtlasLabel_17_Kong/AtlasLabel_17_All.mat'], 'AtlasLabel_17_All');
