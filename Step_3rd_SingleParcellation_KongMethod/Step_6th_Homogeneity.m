
clear
ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
DataFolder = [ReplicationFolder '/data'];
RestingFolder = [DataFolder '/RestingState'];
nbackFolder = [DataFolder '/NBack'];
EmoIdenFolder = [DataFolder '/EmotionIden'];
CombinedFolder = [DataFolder '/CombinedData'];

ResultFolder = [ReplicationFolder '/results'];
WorkingFolder = [ResultFolder '/SingleParcellation_Kong/WorkingFolder'];
Label_Folder = [WorkingFolder '/ind_parcellation_200_30'];
HomogeneityFolder_RS = [WorkingFolder '/RS_ConnHomogeneity'];
HomogeneityFolder_NBack = [WorkingFolder '/NBack_ConnHomogeneity'];
HomogeneityFolder_EmoIden = [WorkingFolder '/EmoIden_ConnHomogeneity'];
HomogeneityFolder_Combined = [WorkingFolder '/Combined_ConnHomogeneity'];
Demogra_Info = csvread([DataFolder '/pncSingleFuncParcel_n713_SubjectsIDs.csv'],1);
BBLID = Demogra_Info(:, 1);

% Resting state
for i = 1:length(BBLID)
    i
    ID_Str = num2str(BBLID(i));
    Label_File_Cell{i} = [Label_Folder '/' ID_Str '.mat'];
    Image_lh_Path_Cell{i} = [RestingFolder '/' ID_Str '/surf/lh.fs5.sm6.residualised.mgh'];
    Image_rh_Path_Cell{i} = [RestingFolder '/' ID_Str '/surf/rh.fs5.sm6.residualised.mgh'];
    ResultantFile_Cell{i} = [HomogeneityFolder_RS '/' ID_Str '.mat'];
end
Atlas_Homogeneity_Pipeline(Label_File_Cell, Image_lh_Path_Cell, Image_rh_Path_Cell, ResultantFile_Cell, 'Kong');

% NBack
for i = 1:length(BBLID)
    i
    ID_Str = num2str(BBLID(i));
    Label_File_Cell{i} = [Label_Folder '/' ID_Str '.mat'];
    Image_lh_Path_Cell{i} = [nbackFolder '/' ID_Str '/surf/lh.fs5.sm6.residualised.mgh'];
    Image_rh_Path_Cell{i} = [nbackFolder '/' ID_Str '/surf/rh.fs5.sm6.residualised.mgh'];
    ResultantFile_Cell{i} = [HomogeneityFolder_NBack '/' ID_Str '.mat'];
end
Atlas_Homogeneity_Pipeline(Label_File_Cell, Image_lh_Path_Cell, Image_rh_Path_Cell, ResultantFile_Cell, 'Kong');

% Emotion
for i = 1:length(BBLID)
    i
    ID_Str = num2str(BBLID(i));
    Label_File_Cell{i} = [Label_Folder '/' ID_Str '.mat'];
    Image_lh_Path_Cell{i} = [EmoIdenFolder '/' ID_Str '/surf/lh.fs5.sm6.residualised.mgh'];
    Image_rh_Path_Cell{i} = [EmoIdenFolder '/' ID_Str '/surf/rh.fs5.sm6.residualised.mgh'];
    ResultantFile_Cell{i} = [HomogeneityFolder_EmoIden '/' ID_Str '.mat'];
end
Atlas_Homogeneity_Pipeline(Label_File_Cell, Image_lh_Path_Cell, Image_rh_Path_Cell, ResultantFile_Cell, 'Kong');

% Combined
% Emotion
for i = 1:length(BBLID)
    i
    ID_Str = num2str(BBLID(i));
    Label_File_Cell{i} = [Label_Folder '/' ID_Str '.mat'];
    Image_lh_Path_Cell{i} = [CombinedFolder '/' ID_Str '/lh.fs5.sm6.residualised.mgh'];
    Image_rh_Path_Cell{i} = [CombinedFolder '/' ID_Str '/rh.fs5.sm6.residualised.mgh'];
    ResultantFile_Cell{i} = [HomogeneityFolder_Combined '/' ID_Str '.mat'];
end
Atlas_Homogeneity_Pipeline(Label_File_Cell, Image_lh_Path_Cell, Image_rh_Path_Cell, ResultantFile_Cell, 'Kong');

pause(5);
ConnHomo_RS_Cell = g_ls([HomogeneityFolder_RS '/*.mat']);
for i = 1:length(ConnHomo_RS_Cell)
    [~, ID_Str, ~] = fileparts(ConnHomo_RS_Cell{i});
    tmp = load(ConnHomo_RS_Cell{i});
    Resting_ConnHomogen(i) = tmp.Homogeneity_Overall;
    Resting_Corr_WithinSystem_Avg(i, :) = tmp.Homogeneity_WithinNetwork;
    ID(i) = str2num(ID_Str);
end
Resting_ConnHomogen_AllSubjectsAvg = mean(Resting_ConnHomogen);
save([WorkingFolder '/RSHomogeneity.mat'], 'Resting_ConnHomogen', 'Resting_Corr_WithinSystem_Avg', ...
     'Resting_ConnHomogen_AllSubjectsAvg', 'ID');

ConnHomo_NBack_Cell = g_ls([HomogeneityFolder_NBack '/*.mat']);
for i = 1:length(ConnHomo_NBack_Cell)
    [~, ID_Str, ~] = fileparts(ConnHomo_NBack_Cell{i});
    tmp = load(ConnHomo_NBack_Cell{i});
    NBack_ConnHomogen(i) = tmp.Homogeneity_Overall;
    NBack_Corr_WithinSystem_Avg(i, :) = tmp.Homogeneity_WithinNetwork;
    ID(i) = str2num(ID_Str);
end
NBack_ConnHomogen_AllSubjectsAvg = mean(NBack_ConnHomogen);
save([WorkingFolder '/NBackHomogeneity.mat'], 'NBack_ConnHomogen', 'NBack_Corr_WithinSystem_Avg', ...
     'NBack_ConnHomogen_AllSubjectsAvg', 'ID');

ConnHomo_EmoIden_Cell = g_ls([HomogeneityFolder_EmoIden '/*.mat']);
for i = 1:length(ConnHomo_EmoIden_Cell)
    [~, ID_Str, ~] = fileparts(ConnHomo_EmoIden_Cell{i});
    tmp = load(ConnHomo_EmoIden_Cell{i});
    EmoIden_ConnHomogen(i) = tmp.Homogeneity_Overall;
    EmoIden_Corr_WithinSystem_Avg(i, :) = tmp.Homogeneity_WithinNetwork;
    ID(i) = str2num(ID_Str);
end
EmoIden_ConnHomogen_AllSubjectsAvg = mean(EmoIden_ConnHomogen);
save([WorkingFolder '/EmoIdenHomogeneity.mat'], 'EmoIden_ConnHomogen', 'EmoIden_Corr_WithinSystem_Avg', ...
     'EmoIden_ConnHomogen_AllSubjectsAvg', 'ID');

ConnHomo_Combined_Cell = g_ls([HomogeneityFolder_Combined '/*.mat']);
for i = 1:length(ConnHomo_Combined_Cell)
    [~, ID_Str, ~] = fileparts(ConnHomo_Combined_Cell{i});
    tmp = load(ConnHomo_Combined_Cell{i});
    Combined_ConnHomogen(i) = tmp.Homogeneity_Overall;
    Combined_Corr_WithinSystem_Avg(i, :) = tmp.Homogeneity_WithinNetwork;
    ID(i) = str2num(ID_Str);
end
Combined_ConnHomogen_AllSubjectsAvg = mean(Combined_ConnHomogen);
save([WorkingFolder '/CombinedHomogeneity.mat'], 'Combined_ConnHomogen', 'Combined_Corr_WithinSystem_Avg', ...
     'Combined_ConnHomogen_AllSubjectsAvg', 'ID');
