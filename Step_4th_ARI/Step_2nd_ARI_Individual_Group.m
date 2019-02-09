
clear
ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
ResultsFolder = [ReplicationFolder '/results'];
Hongming_Folder = [ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/FinalAtlasLabel'];
Demogra_Info = csvread([ReplicationFolder '/data/pncSingleFuncParcel_n713_SubjectsIDs.csv'],1);
BBLID = Demogra_Info(:, 1);

Hongming_Group_Atlas = load([ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/Group_AtlasLabel.mat']);
Hongming_Group_Label = [Hongming_Group_Atlas.sbj_AtlasLabel_lh'; Hongming_Group_Atlas.sbj_AtlasLabel_rh'];

ResultantFolder = [ResultsFolder '/ARI'];
for i = 1:length(BBLID)
  i
  Hongming_Data_Mat = load([Hongming_Folder '/' num2str(BBLID(i))]);
  Hongming_Label = [Hongming_Data_Mat.sbj_AtlasLabel_lh'; Hongming_Data_Mat.sbj_AtlasLabel_rh'];
  NonZeroIndex = find(Hongming_Label ~= 0); % Removing medial wall
  ARI_Individual_Group(i) = rand_index(Hongming_Label(NonZeroIndex), Hongming_Group_Label(NonZeroIndex), 'adjusted');
end
mean(ARI_Individual_Group)
save([ResultantFolder '/ARI_Individual_Group_Hongming.mat'], 'ARI_Individual_Group', 'BBLID');

