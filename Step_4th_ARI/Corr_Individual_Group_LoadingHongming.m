
clear
ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
ResultsFolder = [ReplicationFolder '/results'];
Hongming_Folder = [ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/FinalAtlasLoading'];
Demogra_Info = csvread([ReplicationFolder '/data/pncSingleFuncParcel_n713_SubjectsIDs.csv'],1);
BBLID = Demogra_Info(:, 1);

Hongming_Group_Atlas = load([ResultsFolder '/SingleParcellation/SingleAtlas_Analysis/Group_AtlasLoading.mat']);
Hongming_Group_Loading = reshape(Hongming_Group_Atlas.sbj_AtlasLoading_NoMedialWall, 18715*17, 1);

ResultantFolder = [ResultsFolder '/ARI'];
for i = 1:length(BBLID)
  i
  Hongming_Data_Mat = load([Hongming_Folder '/' num2str(BBLID(i))]);
  Hongming_Individual_Loading = reshape(Hongming_Data_Mat.sbj_AtlasLoading_NoMedialWall, 18715*17, 1);
  NonZeroIndex = find((Hongming_Individual_Loading + Hongming_Group_Loading) ~= 0); % Remove elements with 0 values in both
  Corr_Individual_Group(i) = corr(Hongming_Individual_Loading(NonZeroIndex), Hongming_Group_Loading(NonZeroIndex));
end
mean(Corr_Individual_Group)
save([ResultantFolder '/Corr_Individual_Group_LoadingHongming.mat'], 'Corr_Individual_Group', 'BBLID');

