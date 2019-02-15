
clear
ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
ResultsFolder = [ReplicationFolder '/results'];
Hongming_Folder = [ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/FinalAtlasLoading'];
Demogra_Info = csvread([ReplicationFolder '/data/pncSingleFuncParcel_n713_SubjectsIDs.csv'],1);
BBLID = Demogra_Info(:, 1);

Hongming_Group_Atlas = load([ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/Group_AtlasLoading.mat']);
Hongming_Group_Loading = Hongming_Group_Atlas.sbj_AtlasLoading_NoMedialWall;

ResultantFolder = [ResultsFolder '/AtlasSimilarity'];
for i = 1:length(BBLID)
  i
  Hongming_Data_Mat = load([Hongming_Folder '/' num2str(BBLID(i))]);
  Hongming_Individual_Loading = Hongming_Data_Mat.sbj_AtlasLoading_NoMedialWall;
  for j = 1:17
    Hongming_Individual_Loading_J = Hongming_Individual_Loading(:, j);
    Hongming_Group_Loading_J = Hongming_Group_Loading(:, j);
    NonZeroIndex = find((Hongming_Individual_Loading_J + Hongming_Group_Loading_J) ~= 0); % Remove elements with 0 values in both
    Corr_Individual_Group_System(i, j) = corr(Hongming_Individual_Loading_J(NonZeroIndex), Hongming_Group_Loading_J(NonZeroIndex));
  end
end
Corr_Individual_Group_System_MeanAcrossSubjects = mean(Corr_Individual_Group_System);
save([ResultantFolder '/Corr_Individual_Group_LoadingHongming_System.mat'], 'Corr_Individual_Group_System', 'BBLID', 'Corr_Individual_Group_System_MeanAcrossSubjects');

