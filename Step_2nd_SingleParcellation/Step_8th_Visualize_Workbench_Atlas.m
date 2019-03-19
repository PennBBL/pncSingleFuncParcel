
%
%% Group probability atlas and hard label atlas
%

clear
Folder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/SingleParcellation/SingleAtlas_Analysis';
VisualizeFolder = [Folder '/Atlas_Visualize'];
mkdir(VisualizeFolder);

%% Group probability atlas
GroupAtlasLoading_Mat = load([Folder '/Group_AtlasLoading.mat']);
for i = 1:17
  % left hemi
  V_lh = gifti;
  V_lh.cdata = GroupAtlasLoading_Mat.sbj_AtlasLoading_lh(i, :)';
  V_lh_File = [VisualizeFolder '/Group_lh_Network_' num2str(i) '.func.gii'];
  save(V_lh, V_lh_File);
  % right hemi
  V_rh = gifti;
  V_rh.cdata = GroupAtlasLoading_Mat.sbj_AtlasLoading_rh(i, :)';
  V_rh_File = [VisualizeFolder '/Group_rh_Network_' num2str(i) '.func.gii'];
  save(V_rh, V_rh_File);
  % convert into cifti file
  cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/Group_AtlasLoading_Network_' num2str(i) ...
         '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
  system(cmd);
  pause(1);
  system(['rm -rf ' V_lh_File ' ' V_rh_File]);
end

%% Group hard label atlas
GroupAtlasLabel_Mat = load([Folder '/Group_AtlasLabel.mat']);
ColorInfo_Atlas = [VisualizeFolder '/name_Atlas.txt'];
system(['rm -rf ' ColorInfo_Atlas]);
SystemName = {'Default mode 1', 'Motor 1', 'Default mode 2', 'Limbic', 'Frontoparietal 1', ...
              'Visual 1', 'Visual 2', 'Ventral attention 1', 'Motor 2', 'Frontoparietal 2', ...
              'Ventral attention 2', 'Default mode 3', 'Dorsal attention 1', 'Frontoparietal 3', ...
              'Dorsal attention 2', 'Motor 3', 'Frontoparietal 4'};
ColorPlate = {'12 48 255', '42 204 164', '0 0 170', '220 248 164', '205 62 78', ...
              '200 0 0', '120 18 134', '255 152 213', '122 135 50', '135 50 74', ...
              '196 58 250', '255 255 0', '0 118 14', '230 148 34', '74 155 60', ...
              '70 130 180', '119 140 176'};
for i = 1:17
  system(['echo ' SystemName{i} ' >> ' ColorInfo_Atlas]);
  system(['echo ' num2str(i) ' ' ColorPlate{i} ' 1 >> ' ColorInfo_Atlas]); 
end

% left hemi
V_lh = gifti;
V_lh.cdata = GroupAtlasLabel_Mat.sbj_AtlasLabel_lh';
V_lh_File = [VisualizeFolder '/Group_lh.func.gii'];
save(V_lh, V_lh_File);
pause(1);
V_lh_Label_File = [VisualizeFolder '/Group_lh_AtlasLabel.label.gii'];
cmd = ['wb_command -metric-label-import ' V_lh_File ' ' ColorInfo_Atlas ' ' V_lh_Label_File];
system(cmd);
% right hemi
V_rh = gifti;
V_rh.cdata = GroupAtlasLabel_Mat.sbj_AtlasLabel_rh';
V_rh_File = [VisualizeFolder '/Group_rh.func.gii'];
save(V_rh, V_rh_File);
pause(1);
V_rh_Label_File = [VisualizeFolder '/Group_rh_AtlasLabel.label.gii'];
cmd = ['wb_command -metric-label-import ' V_rh_File ' ' ColorInfo_Atlas ' ' V_rh_Label_File];
system(cmd);
% convert into cifti file
cmd = ['wb_command -cifti-create-label ' VisualizeFolder '/Group_AtlasLabel' ...
       '.dlabel.nii -left-label ' V_lh_Label_File ' -right-label ' V_rh_Label_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File ' ' V_lh_Label_File ' ' V_rh_Label_File]);

% Create one cifti file for each network in group atlas
SystemName = {'Default mode 1', 'Motor 1', 'Default mode 2', 'Limbic', 'Frontoparietal 1', ...
              'Visual 1', 'Visual 2', 'Ventral attention 1', 'Motor 2', 'Frontoparietal 2', ...
              'Ventral attention 2', 'Default mode 3', 'Dorsal attention 1', 'Frontoparietal 3', ...
              'Dorsal attention 2', 'Motor 3', 'Frontoparietal 4'};
ColorPlate_17Colors = {'12 48 255', '42 204 164', '0 0 170', '220 248 164', '205 62 78', ...
              '200 0 0', '120 18 134', '255 152 213', '122 135 50', '135 50 74', ...
              '196 58 250', '255 255 0', '0 118 14', '230 148 34', '74 155 60', ...
              '70 130 180', '119 140 176'};
ColorPlate_7Colors = {'231 97 120', '116 153 194', '231 97 120', '235 226 151', '245 186 46', ...
               '175 51 173', '175 51 173', '228 67 255', '116 153 194', '245 186 46', ...
               '228 67 255', '231 97 120', '0 161 49', '245 186 46', '0 161 49', ...
               '116 153 194', '245 186 46'};
for i = 1:17
  ColorInfo_Atlas_Network = [VisualizeFolder '/name_Atlas_Network.txt'];
  system(['rm -rf ' ColorInfo_Atlas_Network]);
  system(['echo ' SystemName{i} ' >> ' ColorInfo_Atlas_Network]);
  system(['echo 1 ' ColorPlate_7Colors{i} ' 1 >> ' ColorInfo_Atlas_Network]);

  AtlasLabel_lh = GroupAtlasLabel_Mat.sbj_AtlasLabel_lh';
  AtlasLabel_lh(find(AtlasLabel_lh ~= i)) = 0;
  AtlasLabel_lh(find(AtlasLabel_lh == i)) = 1;
  AtlasLabel_rh = GroupAtlasLabel_Mat.sbj_AtlasLabel_rh';
  AtlasLabel_rh(find(AtlasLabel_rh ~= i)) = 0;
  AtlasLabel_rh(find(AtlasLabel_rh == i)) = 1;

  % left hemi
  V_lh = gifti;
  V_lh.cdata = AtlasLabel_lh;
  V_lh_File = [VisualizeFolder '/Group_lh.func.gii'];
  save(V_lh, V_lh_File);
  pause(1);
  V_lh_Label_File = [VisualizeFolder '/Group_lh_AtlasLabel.label.gii'];
  cmd = ['wb_command -metric-label-import ' V_lh_File ' ' ColorInfo_Atlas_Network ' ' V_lh_Label_File];
  system(cmd);
  % right hemi
  V_rh = gifti;
  V_rh.cdata = AtlasLabel_rh;
  V_rh_File = [VisualizeFolder '/Group_rh.func.gii'];
  save(V_rh, V_rh_File);
  pause(1);
  V_rh_Label_File = [VisualizeFolder '/Group_rh_AtlasLabel.label.gii'];
  cmd = ['wb_command -metric-label-import ' V_rh_File ' ' ColorInfo_Atlas_Network ' ' V_rh_Label_File];
  system(cmd);
  % convert into cifti file
  cmd = ['wb_command -cifti-create-label ' VisualizeFolder '/Group_AtlasLabel_7Colors_Network_' num2str(i) ...
         '.dlabel.nii -left-label ' V_lh_Label_File ' -right-label ' V_rh_Label_File];
  system(cmd);
  pause(1);
  system(['rm -rf ' V_lh_File ' ' V_rh_File ' ' V_lh_Label_File ' ' V_rh_Label_File]);
end

% Create workbench file for four individual subjects
% BBLID: 130411 (age = 98), 91310 (age = 176), 102958 (age = 179), 115969 (age = 697)
AllSubjectsLoadingFolder = [Folder '/FinalAtlasLoading'];
AllSubjectsLabelFolder = [Folder '/FinalAtlasLabel'];
BBLID = [130411 91310 102958 115969];
for i = 1:length(BBLID)
  i
  SubFolder = [VisualizeFolder '/' num2str(BBLID(i))];
  mkdir(SubFolder);
  % display loadings
  SubAtlasLoading_Mat = load([AllSubjectsLoadingFolder '/' num2str(BBLID(i)) '.mat']);
  for j = 1:17
    % left hemi
    V_lh = gifti;
    V_lh.cdata = SubAtlasLoading_Mat.sbj_AtlasLoading_lh(j, :)';
    V_lh_File = [SubFolder '/' num2str(BBLID(i)) '_lh_Network_' num2str(j) '.func.gii'];
    save(V_lh, V_lh_File);
    % right hemi
    V_rh = gifti;
    V_rh.cdata = SubAtlasLoading_Mat.sbj_AtlasLoading_rh(j, :)';
    V_rh_File = [SubFolder '/' num2str(BBLID(i)) '_rh_Network_' num2str(j) '.func.gii'];
    save(V_rh, V_rh_File);
    % convert into cifti file
    cmd = ['wb_command -cifti-create-dense-scalar ' SubFolder '/' num2str(BBLID(i)) ...
           '_AtlasLoading_Network_' num2str(j) '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
    system(cmd);
    pause(1);
    system(['rm -rf ' V_lh_File ' ' V_rh_File]);
  end
  % display labels
  SubAtlasLabel_Mat = load([AllSubjectsLabelFolder '/' num2str(BBLID(i)) '.mat']);
  V_lh = gifti;
  V_lh.cdata = SubAtlasLabel_Mat.sbj_AtlasLabel_lh';
  V_lh_File = [SubFolder '/' num2str(BBLID(i)) '_lh.func.gii'];
  save(V_lh, V_lh_File);
  pause(1);
  V_lh_Label_File = [SubFolder '/' num2str(BBLID(i)) '_lh_AtlasLabel.label.gii'];
  cmd = ['wb_command -metric-label-import ' V_lh_File ' ' ColorInfo_Atlas ' ' V_lh_Label_File];
  system(cmd);
  % right hemi
  V_rh = gifti;
  V_rh.cdata = SubAtlasLabel_Mat.sbj_AtlasLabel_rh';
  V_rh_File = [SubFolder '/' num2str(BBLID(i)) '_rh.func.gii'];
  save(V_rh, V_rh_File);
  pause(1);
  V_rh_Label_File = [SubFolder '/' num2str(BBLID(i)) '_rh_AtlasLabel.label.gii'];
  cmd = ['wb_command -metric-label-import ' V_rh_File ' ' ColorInfo_Atlas ' ' V_rh_Label_File];
  system(cmd);
  % convert into cifti file
  cmd = ['wb_command -cifti-create-label ' SubFolder '/' num2str(BBLID(i)) '_AtlasLabel' ...
         '.dlabel.nii -left-label ' V_lh_Label_File ' -right-label ' V_rh_Label_File];
  system(cmd);
  pause(1);
  system(['rm -rf ' V_lh_File ' ' V_rh_File ' ' V_lh_Label_File ' ' V_rh_Label_File]);

  %%%%%% Create one cifti file for each specific ROI, using 7 colors scheme
  for j = 1:17
    ColorInfo_Atlas_Network = [VisualizeFolder '/name_Atlas_Network.txt'];
    system(['rm -rf ' ColorInfo_Atlas_Network]);
    system(['echo ' SystemName{j} ' >> ' ColorInfo_Atlas_Network]);
    system(['echo 1 ' ColorPlate_7Colors{j} ' 1 >> ' ColorInfo_Atlas_Network]);

    AtlasLabel_lh = SubAtlasLabel_Mat.sbj_AtlasLabel_lh';
    AtlasLabel_lh(find(AtlasLabel_lh ~= j)) = 0;
    AtlasLabel_lh(find(AtlasLabel_lh == j)) = 1;
    AtlasLabel_rh = SubAtlasLabel_Mat.sbj_AtlasLabel_rh';
    AtlasLabel_rh(find(AtlasLabel_rh ~= j)) = 0;
    AtlasLabel_rh(find(AtlasLabel_rh == j)) = 1;

    % left hemi
    V_lh = gifti;
    V_lh.cdata = AtlasLabel_lh;
    V_lh_File = [SubFolder '/' num2str(BBLID(i)) '_lh.func.gii'];
    save(V_lh, V_lh_File);
    pause(1);
    V_lh_Label_File = [SubFolder '/' num2str(BBLID(i)) '_lh_AtlasLabel.label.gii'];
    cmd = ['wb_command -metric-label-import ' V_lh_File ' ' ColorInfo_Atlas_Network ' ' V_lh_Label_File];
    system(cmd);
    % right hemi
    V_rh = gifti;
    V_rh.cdata = AtlasLabel_rh;
    V_rh_File = [SubFolder '/' num2str(BBLID(i)) '_rh.func.gii'];
    save(V_rh, V_rh_File);
    pause(1);
    V_rh_Label_File = [SubFolder '/' num2str(BBLID(i)) '_rh_AtlasLabel.label.gii'];
    cmd = ['wb_command -metric-label-import ' V_rh_File ' ' ColorInfo_Atlas_Network ' ' V_rh_Label_File];
    system(cmd);
    % convert into cifti file
    cmd = ['wb_command -cifti-create-label ' SubFolder '/' num2str(BBLID(i)) '_AtlasLabel_7Colors_Network_' num2str(j) ...
           '.dlabel.nii -left-label ' V_lh_Label_File ' -right-label ' V_rh_Label_File];
    system(cmd);
    pause(1);
    system(['rm -rf ' V_lh_File ' ' V_rh_File ' ' V_lh_Label_File ' ' V_rh_Label_File]);
  end

  %%%%%% Create one cifti file for each specific ROI, using 17 colors scheme
  for j = 1:17
    ColorInfo_Atlas_Network = [VisualizeFolder '/name_Atlas_Network.txt'];
    system(['rm -rf ' ColorInfo_Atlas_Network]);
    system(['echo ' SystemName{j} ' >> ' ColorInfo_Atlas_Network]);
    system(['echo 1 ' ColorPlate_17Colors{j} ' 1 >> ' ColorInfo_Atlas_Network]);

    AtlasLabel_lh = SubAtlasLabel_Mat.sbj_AtlasLabel_lh';
    AtlasLabel_lh(find(AtlasLabel_lh ~= j)) = 0;
    AtlasLabel_lh(find(AtlasLabel_lh == j)) = 1;
    AtlasLabel_rh = SubAtlasLabel_Mat.sbj_AtlasLabel_rh';
    AtlasLabel_rh(find(AtlasLabel_rh ~= j)) = 0;
    AtlasLabel_rh(find(AtlasLabel_rh == j)) = 1;

    % left hemi
    V_lh = gifti;
    V_lh.cdata = AtlasLabel_lh;
    V_lh_File = [SubFolder '/' num2str(BBLID(i)) '_lh.func.gii'];
    save(V_lh, V_lh_File);
    pause(1);
    V_lh_Label_File = [SubFolder '/' num2str(BBLID(i)) '_lh_AtlasLabel.label.gii'];
    cmd = ['wb_command -metric-label-import ' V_lh_File ' ' ColorInfo_Atlas_Network ' ' V_lh_Label_File];
    system(cmd);
    % right hemi
    V_rh = gifti;
    V_rh.cdata = AtlasLabel_rh;
    V_rh_File = [SubFolder '/' num2str(BBLID(i)) '_rh.func.gii'];
    save(V_rh, V_rh_File);
    pause(1);
    V_rh_Label_File = [SubFolder '/' num2str(BBLID(i)) '_rh_AtlasLabel.label.gii'];
    cmd = ['wb_command -metric-label-import ' V_rh_File ' ' ColorInfo_Atlas_Network ' ' V_rh_Label_File];
    system(cmd);
    % convert into cifti file
    cmd = ['wb_command -cifti-create-label ' SubFolder '/' num2str(BBLID(i)) '_AtlasLabel_17Colors_Network_' num2str(j) ...
           '.dlabel.nii -left-label ' V_lh_Label_File ' -right-label ' V_rh_Label_File];
    system(cmd);
    pause(1);
    system(['rm -rf ' V_lh_File ' ' V_rh_File ' ' V_lh_Label_File ' ' V_rh_Label_File]);
  end
end
