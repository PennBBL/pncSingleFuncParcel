
clear
ResultsFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results';
Hongming_Folder = [ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/FinalAtlasLabel'];
Demogra_Info = csvread('/data/jux/BBL/projects/pncSingleFuncParcel/data/pncSingleFuncParcel_n713_SubjectsIDs.csv',1);
BBLID = Demogra_Info(:, 1);

Hongming_Group_Atlas = load([ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/Group_AtlasLabel.mat']);
Hongming_Group_Label = [Hongming_Group_Atlas.sbj_AtlasLabel_lh'; Hongming_Group_Atlas.sbj_AtlasLabel_rh'];
NonZeroIndex = find(Hongming_Group_Label ~= 0); % Removing medial wall
Hongming_Group_Label = Hongming_Group_Label(NonZeroIndex);

ResultantFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/AtlasSimilarity';
for i = 1:length(BBLID)
  i
  Hongming_Data_Mat = load([Hongming_Folder '/' num2str(BBLID(i))]);
  Hongming_Label = [Hongming_Data_Mat.sbj_AtlasLabel_lh'; Hongming_Data_Mat.sbj_AtlasLabel_rh'];
  Hongming_Label = Hongming_Label(NonZeroIndex);
  for j = 1:17
    Hongming_Label_J = Hongming_Label;
    Hongming_Label_J(find(Hongming_Label_J ~= j)) = 0;
    Hongming_Label_J(find(Hongming_Label_J == j)) = 1;
    Hongming_Group_Label_J = Hongming_Group_Label;
    Hongming_Group_Label_J(find(Hongming_Group_Label_J ~= j)) = 0;
    Hongming_Group_Label_J(find(Hongming_Group_Label_J == j)) = 1;
    ARI_Individual_Group_System(i, j) = rand_index(Hongming_Label_J, Hongming_Group_Label_J, 'adjusted');
  end
end
ARI_Individual_Group_System_MeanAcrossSubjects = mean(ARI_Individual_Group_System)
save([ResultantFolder '/ARI_Individual_Group_Hongming_System.mat'], 'ARI_Individual_Group_System', 'BBLID', 'ARI_Individual_Group_System_MeanAcrossSubjects');

