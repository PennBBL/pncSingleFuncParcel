
clear
PredictionFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/results/PredictionAnalysis/AtlasLabel_17_100/';
VisualizeFolder = [PredictionFolder '/WeightVisualize_Age'];
mkdir(VisualizeFolder);
w_Brain_Mat = load([PredictionFolder '/Weight_Age/w_Brain.mat']);
w_Brain_Age = w_Brain_Mat.w_Brain;

SubjectsFolder = '/share/apps/freesurfer/6.0.0/subjects/fsaverage5';
% for surface data
surfML = [SubjectsFolder '/label/lh.Medial_wall.label'];
mwIndVec_l = read_medial_wall_label(surfML);
Index_l = setdiff([1:10242], mwIndVec_l);
surfMR = [SubjectsFolder '/label/rh.Medial_wall.label'];
mwIndVec_r = read_medial_wall_label(surfMR);
Index_r = setdiff([1:10242], mwIndVec_r);

%%%%%%%%%%%%%%%%%%
% Age Prediction %
%%%%%%%%%%%%%%%%%%
%% Display weight of all regions
% left hemi
w_Brain_Age_lh = zeros(1, 10242);
w_Brain_Age_lh(Index_l) = w_Brain_Age(1:length(Index_l));
V_lh = gifti;
V_lh.cdata = w_Brain_Age_lh';
V_lh_File = [VisualizeFolder '/w_Brain_Age_lh.func.gii'];
save(V_lh, V_lh_File);
% right hemi
w_Brain_Age_rh = zeros(1, 10242);
w_Brain_Age_rh(Index_r) = w_Brain_Age(length(Index_l) + 1:end);
V_rh = gifti;
V_rh.cdata = w_Brain_Age_rh';
V_rh_File = [VisualizeFolder '/w_Brain_Age_rh.func.gii'];
save(V_rh, V_rh_File);
% convert into cifti file
cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/w_Brain_Age_AllFeatures' ...
       '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File]);
w_Brain_Age_NoMedialWall = [w_Brain_Age_lh(Index_l) w_Brain_Age_rh(Index_r)];
save([PredictionFolder '/Weight_Age/w_Brain_Age_AllFeatures.mat'], 'w_Brain_Age_lh', 'w_Brain_Age_rh', 'w_Brain_Age_NoMedialWall');

%% Display the weight of the first 30% regions with the highest absolute weight
[~, Sorted_IDs] = sort(abs(w_Brain_Age)); % increasing order
w_Brain_Age_First30Percent = w_Brain_Age;
w_Brain_Age_First30Percent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.7))) = 0;
% left hemi
w_Brain_Age_First30Percent_lh = zeros(1, 10242);
w_Brain_Age_First30Percent_lh(Index_l) = w_Brain_Age_First30Percent(1:length(Index_l));
V_lh = gifti;
V_lh.cdata = w_Brain_Age_First30Percent_lh';
V_lh_File = [VisualizeFolder '/w_Brain_Age_First30Percent_lh.func.gii'];
save(V_lh, V_lh_File);
% right hemi
w_Brain_Age_First30Percent_rh = zeros(1, 10242);
w_Brain_Age_First30Percent_rh(Index_r) = w_Brain_Age_First30Percent(length(Index_l) + 1:end);
V_rh = gifti;
V_rh.cdata = w_Brain_Age_First30Percent_rh';
V_rh_File = [VisualizeFolder '/w_Brain_Age_First30Percent_rh_Network.func.gii'];
save(V_rh, V_rh_File);
% convert into cifti file
cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/w_Brain_Age_First30Percent' ...
       '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File]);

%% Display the weight of the first 20% regions with the highest absolute weight
[~, Sorted_IDs] = sort(abs(w_Brain_Age)); % increasing order
w_Brain_Age_First20Percent = w_Brain_Age;
w_Brain_Age_First20Percent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.8))) = 0;
% left hemi
w_Brain_Age_First20Percent_lh = zeros(1, 10242);
w_Brain_Age_First20Percent_lh(Index_l) = w_Brain_Age_First20Percent(1:length(Index_l));
V_lh = gifti;
V_lh.cdata = w_Brain_Age_First20Percent_lh';
V_lh_File = [VisualizeFolder '/w_Brain_Age_First20Percent_lh.func.gii'];
save(V_lh, V_lh_File);
% right hemi
w_Brain_Age_First20Percent_rh = zeros(1, 10242);
w_Brain_Age_First20Percent_rh(Index_r) = w_Brain_Age_First20Percent(length(Index_l) + 1:end);
V_rh = gifti;
V_rh.cdata = w_Brain_Age_First20Percent_rh';
V_rh_File = [VisualizeFolder '/w_Brain_Age_First20Percent_rh.func.gii'];
save(V_rh, V_rh_File);
% convert into cifti file
cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/w_Brain_Age_First20Percent' ...
       '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File]);

%% Display the weight of the first 10% regions with the highest absolute weight
[~, Sorted_IDs] = sort(abs(w_Brain_Age)); % increasing order
w_Brain_Age_First10Percent = w_Brain_Age;
w_Brain_Age_First10Percent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.9))) = 0;
% left hemi
w_Brain_Age_First10Percent_lh = zeros(1, 10242);
w_Brain_Age_First10Percent_lh(Index_l) = w_Brain_Age_First10Percent(1:length(Index_l));
V_lh = gifti;
V_lh.cdata = w_Brain_Age_First10Percent_lh';
V_lh_File = [VisualizeFolder '/w_Brain_Age_First10Percent_lh.func.gii'];
save(V_lh, V_lh_File);
% right hemi
w_Brain_Age_First10Percent_rh = zeros(1, 10242);
w_Brain_Age_First10Percent_rh(Index_r) = w_Brain_Age_First10Percent(length(Index_l) + 1:end);
V_rh = gifti;
V_rh.cdata = w_Brain_Age_First10Percent_rh';
V_rh_File = [VisualizeFolder '/w_Brain_Age_First10Percent_rh.func.gii'];
save(V_rh, V_rh_File);
% convert into cifti file
cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/w_Brain_Age_First10Percent' ...
       '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File]);
