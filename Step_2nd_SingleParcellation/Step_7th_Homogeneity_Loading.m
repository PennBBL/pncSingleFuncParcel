
%
% Calculating the homogeneity of time series based on the hard parcellation atlas
%

clear

ResultantFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/SingleParcellation/SingleAtlas_Analysis';
LoadingFolder = [ResultantFolder '/FinalAtlasLoading'];
Loading_File_Cell = g_ls([LoadingFolder '/*.mat']);
Combined_DataFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/data/CombinedData';
HomogeneityFolder = [ResultantFolder '/Homogeneity_Loading'];
mkdir(HomogeneityFolder);
for i = 1:length(Loading_File_Cell)
    i
    [~, ID_Str, ~] = fileparts(Loading_File_Cell{i});
    Image_lh_Path_Cell{i} = [Combined_DataFolder '/' ID_Str '/lh.fs5.sm6.residualised.mgh'];
    Image_rh_Path_Cell{i} = [Combined_DataFolder '/' ID_Str '/rh.fs5.sm6.residualised.mgh'];
    ResultantFile_Cell{i} = [HomogeneityFolder '/' ID_Str '.mat'];
end
Atlas_Homogeneity_Loading_Pipeline(Loading_File_Cell, Image_lh_Path_Cell, Image_rh_Path_Cell, ResultantFile_Cell);

ConnHomo_Combined_Cell = g_ls([HomogeneityFolder '/*.mat']);
for i = 1:length(ConnHomo_Combined_Cell)
    [~, ID_Str, ~] = fileparts(ConnHomo_Combined_Cell{i});
    tmp = load(ConnHomo_Combined_Cell{i});
    Combined_ConnHomogen(i) = tmp.Homogeneity_Overall;
    Combined_Corr_WithinSystem_Avg(i, :) = tmp.Homogeneity_WithinNetwork;
    ID(i) = str2num(ID_Str);
end
Combined_ConnHomogen_AllSubjectsAvg = mean(Combined_ConnHomogen);
save([ResultantFolder '/CombinedHomogeneity_Loading.mat'], 'Combined_ConnHomogen', 'Combined_Corr_WithinSystem_Avg', ...
     'Combined_ConnHomogen_AllSubjectsAvg', 'ID');
