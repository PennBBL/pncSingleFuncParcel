
clear
ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
ResultsFolder = [ReplicationFolder '/results'];
Kong_Folder = [ResultsFolder '/SingleParcellation_Kong/WorkingFolder/ind_parcellation_200_30'];
Demogra_Info = csvread([ReplicationFolder '/data/pncSingleFuncParcel_n713_SubjectsIDs.csv'],1);
BBLID = Demogra_Info(:, 1);

Kong_Group_Atlas = load([ResultsFolder '/SingleParcellation_Kong/WorkingFolder/group/group.mat']);
Kong_Group_Label = [Kong_Group_Atlas.lh_labels; Kong_Group_Atlas.rh_labels];

ResultantFolder = [ResultsFolder '/ARI'];
for i = 1:length(BBLID)
  i
  Kong_Data_Mat = load([Kong_Folder '/' num2str(BBLID(i))]);
  Kong_Label = [Kong_Data_Mat.lh_labels; Kong_Data_Mat.rh_labels];
  NonZeroIndex = find(Kong_Label ~= 0); % Removing medial wall
  ARI_Individual_Group(i) = rand_index(Kong_Label(NonZeroIndex), Kong_Group_Label(NonZeroIndex), 'adjusted');
end
mean(ARI_Individual_Group)
save([ResultantFolder '/ARI_Individual_Group_Kong.mat'], 'ARI_Individual_Group', 'BBLID');

