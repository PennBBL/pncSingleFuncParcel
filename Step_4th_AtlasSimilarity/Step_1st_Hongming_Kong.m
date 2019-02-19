
clear
ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
ResultsFolder = [ReplicationFolder '/results'];
Hongming_Folder = [ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/FinalAtlasLabel'];
Kong_Folder = [ResultsFolder '/SingleParcellation_Kong/WorkingFolder/ind_parcellation_200_30'];
Demogra_Info = csvread([ReplicationFolder '/data/pncSingleFuncParcel_n713_SubjectsIDs.csv'],1);
BBLID = Demogra_Info(:, 1);

ResultantFolder = [ResultsFolder '/AtlasSimilarity'];
mkdir(ResultantFolder);
for i = 1:length(BBLID)
  i
  Hongming_Data_Mat = load([Hongming_Folder '/' num2str(BBLID(i))]);
  Kong_Data_Mat = load([Kong_Folder '/' num2str(BBLID(i))]);
  Hongming_Label = [Hongming_Data_Mat.sbj_AtlasLabel_lh'; Hongming_Data_Mat.sbj_AtlasLabel_rh'];
  Kong_Label = [Kong_Data_Mat.lh_labels; Kong_Data_Mat.rh_labels];
  NonZeroIndex = find(Kong_Label ~= 0); % Removing medial wall
  ARI_Hongming_Kong(i) = rand_index(Hongming_Label(NonZeroIndex), Kong_Label(NonZeroIndex), 'adjusted');
end
ARI_Hongming_Kong_Mean = mean(ARI_Hongming_Kong);
ARI_Hongming_Kong_Std = std(ARI_Hongming_Kong);
save([ResultantFolder '/ARI_Hongming_Kong.mat'], 'ARI_Hongming_Kong', 'ARI_Hongming_Kong_Mean', 'ARI_Hongming_Kong_Std', 'BBLID');
