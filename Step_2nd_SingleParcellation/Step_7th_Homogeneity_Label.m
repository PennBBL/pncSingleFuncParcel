
%
% Calculating the homogeneity of time series based on the hard parcellation atlas
%

clear

ResultantFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/SingleParcellation/SingleAtlas_Analysis';
LabelFolder = [ResultantFolder '/FinalAtlasLabel'];
Label_File_Cell = g_ls([LabelFolder '/*.mat']);
Combined_DataFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/data/CombinedData';
HomogeneityFolder_Label = [ResultantFolder '/Homogeneity_Label'];
mkdir(HomogeneityFolder_Label);
for i = 1:length(Label_File_Cell)
    i
    [~, ID_Str, ~] = fileparts(Label_File_Cell{i});
    Image_lh_Path_Cell{i} = [Combined_DataFolder '/' ID_Str '/lh.fs5.sm6.residualised.mgh'];
    Image_rh_Path_Cell{i} = [Combined_DataFolder '/' ID_Str '/rh.fs5.sm6.residualised.mgh'];
    ResultantFile_Cell{i} = [HomogeneityFolder_Label '/' ID_Str '.mat'];
end
Atlas_Homogeneity_Pipeline(Label_File_Cell, Image_lh_Path_Cell, Image_rh_Path_Cell, ResultantFile_Cell, 'Hongming');

ConnHomo_Label_Cell = g_ls([HomogeneityFolder_Label '/*.mat']);
for i = 1:length(ConnHomo_Label_Cell)
    [~, ID_Str, ~] = fileparts(ConnHomo_Label_Cell{i});
    tmp = load(ConnHomo_Label_Cell{i});
    Combined_ConnHomogen(i) = tmp.Homogeneity_Overall;
    Combined_Corr_WithinSystem_Avg(i, :) = tmp.Homogeneity_WithinNetwork;
    ID(i) = str2num(ID_Str);
end
Combined_ConnHomogen_AllSubjectsAvg = mean(Combined_ConnHomogen);
save([ResultantFolder '/CombinedHomogeneity_Label.mat'], 'Combined_ConnHomogen', 'Combined_Corr_WithinSystem_Avg', ...
     'Combined_ConnHomogen_AllSubjectsAvg', 'ID');

