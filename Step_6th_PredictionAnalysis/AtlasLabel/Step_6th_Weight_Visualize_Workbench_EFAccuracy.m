
clear
PredictionFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/PredictionAnalysis/AtlasLabel';
VisualizeFolder = [PredictionFolder '/WeightVisualize_EFAccuracy'];
mkdir(VisualizeFolder);
w_Brain_Mat = load([PredictionFolder '/Weight_EFAccuracy/w_Brain.mat']);
w_Brain_EFAccuracy = w_Brain_Mat.w_Brain;

SubjectsFolder = '/share/apps/freesurfer/6.0.0/subjects/fsaverage5';
% for surface data
surfML = [SubjectsFolder '/label/lh.Medial_wall.label'];
mwIndVec_l = read_medial_wall_label(surfML);
Index_l = setdiff([1:10242], mwIndVec_l);
surfMR = [SubjectsFolder '/label/rh.Medial_wall.label'];
mwIndVec_r = read_medial_wall_label(surfMR);
Index_r = setdiff([1:10242], mwIndVec_r);

%%%%%%%%%%%%%%%%%%
% EFAccuracy Prediction %
%%%%%%%%%%%%%%%%%%
%% Display weight of all regions
% left hemi
w_Brain_EFAccuracy_lh = zeros(1, 10242);
w_Brain_EFAccuracy_lh(Index_l) = w_Brain_EFAccuracy(1:length(Index_l));
V_lh = gifti;
V_lh.cdata = w_Brain_EFAccuracy_lh';
V_lh_File = [VisualizeFolder '/w_Brain_EFAccuracy_lh.func.gii'];
save(V_lh, V_lh_File);
% right hemi
w_Brain_EFAccuracy_rh = zeros(1, 10242);
w_Brain_EFAccuracy_rh(Index_r) = w_Brain_EFAccuracy(length(Index_l) + 1:end);
V_rh = gifti;
V_rh.cdata = w_Brain_EFAccuracy_rh';
V_rh_File = [VisualizeFolder '/w_Brain_EFAccuracy_rh.func.gii'];
save(V_rh, V_rh_File);
% convert into cifti file
cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/w_Brain_EFAccuracy_AllFeatures' ...
       '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File]);

