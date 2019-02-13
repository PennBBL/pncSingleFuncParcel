
%
% Calculating the homogeneity of time series based on the hard parcellation atlas
%

clear

ResultantFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/SingleParcellation/SingleAtlas_Analysis';
LabelFolder = [ResultantFolder '/FinalAtlasLabel'];
Label_File_Cell = g_ls([LabelFolder '/*.mat']);
Combined_DataFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/data/CombinedData';
HomogeneityFolder = [ResultantFolder '/Homogeneity'];
mkdir(HomogeneityFolder);
for i = 1:length(Label_File_Cell)
    i
    [~, ID_Str, ~] = fileparts(Label_File_Cell{i});
    Image_lh_Path_Cell{i} = [Combined_DataFolder '/' ID_Str '/lh.fs5.sm6.residualised.mgh'];
    Image_rh_Path_Cell{i} = [Combined_DataFolder '/' ID_Str '/rh.fs5.sm6.residualised.mgh'];
    ResultantFile_Cell{i} = [HomogeneityFolder '/' ID_Str '.mat'];
end
Atlas_Homogeneity_Pipeline(Label_File_Cell, Image_lh_Path_Cell, Image_rh_Path_Cell, ResultantFile_Cell, 'Hongming');

