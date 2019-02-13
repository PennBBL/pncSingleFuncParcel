
clear
PredictionFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/PredictionAnalysis/AtlasLoading/';
VisualizeFolder = [PredictionFolder '/WeightVisualize_EFAccuracy'];
mkdir(VisualizeFolder);
w_Brain_Mat = load([PredictionFolder '/Weight_EFAccuracy/w_Brain.mat']);
load([PredictionFolder '/AtlasLoading_All_RemoveZero.mat']);
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
VertexQuantity = 18715;
w_Brain_EFAccuracy_All = zeros(1, 18715*17);
w_Brain_EFAccuracy_All(NonZeroIndex) = w_Brain_EFAccuracy;
for i = 1:17
    w_Brain_EFAccuracy_Matrix(i, :) = w_Brain_EFAccuracy_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
    % left hemi
    w_Brain_EFAccuracy_lh = zeros(1, 10242);
    w_Brain_EFAccuracy_lh(Index_l) = w_Brain_EFAccuracy_Matrix(i, 1:length(Index_l));
    V_lh = gifti;
    V_lh.cdata = w_Brain_EFAccuracy_lh';
    V_lh_File = [VisualizeFolder '/w_Brain_EFAccuracy_lh_Network_' num2str(i) '.func.gii'];
    save(V_lh, V_lh_File);
    % right hemi
    w_Brain_EFAccuracy_rh = zeros(1, 10242);
    w_Brain_EFAccuracy_rh(Index_r) = w_Brain_EFAccuracy_Matrix(i, length(Index_l) + 1:end);
    V_rh = gifti;
    V_rh.cdata = w_Brain_EFAccuracy_rh';
    V_rh_File = [VisualizeFolder '/w_Brain_EFAccuracy_rh_Network_' num2str(i) '.func.gii'];
    save(V_rh, V_rh_File);
    % convert into cifti file
    cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/w_Brain_EFAccuracy_Network_' ...
           num2str(i) '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
    system(cmd);
    pause(1);
    system(['rm -rf ' V_lh_File ' ' V_rh_File]);
end
%% Display sum absolute weight of the 17 maps
w_Brain_EFAccuracy_abs_sum = sum(abs(w_Brain_EFAccuracy_Matrix));
w_Brain_EFAccuracy_abs_sum_lh = zeros(1, 10242);
w_Brain_EFAccuracy_abs_sum_lh(Index_l) = w_Brain_EFAccuracy_abs_sum(1:length(Index_l));
V_lh = gifti;
V_lh.cdata = w_Brain_EFAccuracy_abs_sum_lh';
V_lh_File = [VisualizeFolder '/w_Brain_EFAccuracy_abs_sum_lh.func.gii'];
save(V_lh, V_lh_File);
% right hemi
w_Brain_EFAccuracy_abs_sum_rh = zeros(1, 10242);
w_Brain_EFAccuracy_abs_sum_rh(Index_r) = w_Brain_EFAccuracy_abs_sum(length(Index_l) + 1:end);
V_rh = gifti;
V_rh.cdata = w_Brain_EFAccuracy_abs_sum_rh';
V_rh_File = [VisualizeFolder '/w_Brain_EFAccuracy_abs_sum_rh.func.gii'];
save(V_rh, V_rh_File);
save([PredictionFolder '/Weight_EFAccuracy/w_Brain_EFAccuracy_abs_sum.mat'], 'w_Brain_EFAccuracy_abs_sum_lh', 'w_Brain_EFAccuracy_abs_sum_rh', 'w_Brain_EFAccuracy_abs_sum')
% convert into cifti file
cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/w_Brain_EFAccuracy_abs_sum' ...
       '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File]);

