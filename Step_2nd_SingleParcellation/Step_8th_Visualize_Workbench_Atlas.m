
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
ColorInfo_Atlas17 = [VisualizeFolder '/name_Atlas17.txt'];
system(['rm -rf ' ColorInfo_Atlas17]);
system(['echo Default mode 1 >> ' ColorInfo_Atlas17]);
system(['echo 1 12 48 255 1 >> ' ColorInfo_Atlas17]);
system(['echo Motor 1 >> ' ColorInfo_Atlas17]);
system(['echo 2 42 204 164 1 >> ' ColorInfo_Atlas17]);
system(['echo Default mode 2 >> ' ColorInfo_Atlas17]);
system(['echo 3 0 0 170 1 >> ' ColorInfo_Atlas17]);
system(['echo Limbic >> ' ColorInfo_Atlas17]);
system(['echo 4 220 248 164 1 >> ' ColorInfo_Atlas17]);
system(['echo Frontoparietal 1 >> ' ColorInfo_Atlas17]);
system(['echo 5 205 62 78 1 >> ' ColorInfo_Atlas17]);
system(['echo Visual 1 >> ' ColorInfo_Atlas17]);
system(['echo 6 200 0 0 1 >> ' ColorInfo_Atlas17]);
system(['echo Visual 2 >> ' ColorInfo_Atlas17]);
system(['echo 7 120 18 134 1 >> ' ColorInfo_Atlas17]);
system(['echo Dorsal attention 1 >> ' ColorInfo_Atlas17]);
system(['echo 8 255 152 213 1 >> ' ColorInfo_Atlas17]);
system(['echo Motor 2 >> ' ColorInfo_Atlas17]);
system(['echo 9 122 135 50 1 >> ' ColorInfo_Atlas17]);
system(['echo Frontoparietal 2 >> ' ColorInfo_Atlas17]);
system(['echo 10 135 50 74 1 >> ' ColorInfo_Atlas17]);
system(['echo Ventral attention 1 >> ' ColorInfo_Atlas17]);
system(['echo 11 196 58 250 1 >> ' ColorInfo_Atlas17]);
system(['echo Default mode 3 >> ' ColorInfo_Atlas17]);
system(['echo 12 255 255 0 1 >> ' ColorInfo_Atlas17]);
system(['echo Dorsal attention 2 >> ' ColorInfo_Atlas17]);
system(['echo 13 0 118 14 1 >> ' ColorInfo_Atlas17]);
system(['echo Frontopareital 3 >> ' ColorInfo_Atlas17]);
system(['echo 14 230 148 34 1 >> ' ColorInfo_Atlas17]);
system(['echo Dorsal attention 3 >> ' ColorInfo_Atlas17]);
system(['echo 15 74 155 60 1 >> ' ColorInfo_Atlas17]);
system(['echo Motor 3 >> ' ColorInfo_Atlas17]);
system(['echo 16 70 130 180 1 >> ' ColorInfo_Atlas17]);
system(['echo Frontoparietal 4 >> ' ColorInfo_Atlas17]);
system(['echo 17 119 140 176 1 >> ' ColorInfo_Atlas17]);

% left hemi
V_lh = gifti;
V_lh.cdata = GroupAtlasLabel_Mat.sbj_AtlasLabel_lh';
V_lh_File = [VisualizeFolder '/Group_lh.func.gii'];
save(V_lh, V_lh_File);
pause(1);
V_lh_Label_File = [VisualizeFolder '/Group_lh_AtlasLabel.label.gii'];
cmd = ['wb_command -metric-label-import ' V_lh_File ' ' ColorInfo_Atlas17 ' ' V_lh_Label_File];
system(cmd);
% right hemi
V_rh = gifti;
V_rh.cdata = GroupAtlasLabel_Mat.sbj_AtlasLabel_rh';
V_rh_File = [VisualizeFolder '/Group_rh.func.gii'];
save(V_rh, V_rh_File);
pause(1);
V_rh_Label_File = [VisualizeFolder '/Group_rh_AtlasLabel.label.gii'];
cmd = ['wb_command -metric-label-import ' V_rh_File ' ' ColorInfo_Atlas17 ' ' V_rh_Label_File];
system(cmd);
% convert into cifti file
cmd = ['wb_command -cifti-create-label ' VisualizeFolder '/Group_AtlasLabel' num2str(i) ...
       '.dlabel.nii -left-label ' V_lh_Label_File ' -right-label ' V_rh_Label_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File ' ' V_lh_Label_File ' ' V_rh_Label_File]);

% 100031
% left hemi
AllSubjectsLabelFolder = [Folder '/FinalAtlasLabel'];
Sub1AtlasLabel_Mat = load([AllSubjectsLabelFolder '/100031.mat']);
V_lh = gifti;
V_lh.cdata = Sub1AtlasLabel_Mat.sbj_AtlasLabel_lh';
V_lh_File = [VisualizeFolder '/100031_lh.func.gii'];
save(V_lh, V_lh_File);
pause(1);
V_lh_Label_File = [VisualizeFolder '/100031_lh_AtlasLabel.label.gii'];
cmd = ['wb_command -metric-label-import ' V_lh_File ' ' ColorInfo_Atlas17 ' ' V_lh_Label_File];
system(cmd);
% right hemi
V_rh = gifti;
V_rh.cdata = Sub1AtlasLabel_Mat.sbj_AtlasLabel_rh';
V_rh_File = [VisualizeFolder '/100031_rh.func.gii'];
save(V_rh, V_rh_File);
pause(1);
V_rh_Label_File = [VisualizeFolder '/100031_rh_AtlasLabel.label.gii'];
cmd = ['wb_command -metric-label-import ' V_rh_File ' ' ColorInfo_Atlas17 ' ' V_rh_Label_File];
system(cmd);
% convert into cifti file
cmd = ['wb_command -cifti-create-label ' VisualizeFolder '/100031_AtlasLabel' ...
       '.dlabel.nii -left-label ' V_lh_Label_File ' -right-label ' V_rh_Label_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File ' ' V_lh_Label_File ' ' V_rh_Label_File]);

% 100050
% left hemi
AllSubjectsLabelFolder = [Folder '/FinalAtlasLabel'];
Sub2AtlasLabel_Mat = load([AllSubjectsLabelFolder '/100050.mat']);
V_lh = gifti;
V_lh.cdata = Sub2AtlasLabel_Mat.sbj_AtlasLabel_lh';
V_lh_File = [VisualizeFolder '/100050_lh.func.gii'];
save(V_lh, V_lh_File);
pause(1);
V_lh_Label_File = [VisualizeFolder '/100050_lh_AtlasLabel.label.gii'];
cmd = ['wb_command -metric-label-import ' V_lh_File ' ' ColorInfo_Atlas17 ' ' V_lh_Label_File];
system(cmd);
% right hemi
V_rh = gifti;
V_rh.cdata = Sub2AtlasLabel_Mat.sbj_AtlasLabel_rh';
V_rh_File = [VisualizeFolder '/100050_rh.func.gii'];
save(V_rh, V_rh_File);
pause(1);
V_rh_Label_File = [VisualizeFolder '/100050_rh_AtlasLabel.label.gii'];
cmd = ['wb_command -metric-label-import ' V_rh_File ' ' ColorInfo_Atlas17 ' ' V_rh_Label_File];
system(cmd);
% convert into cifti file
cmd = ['wb_command -cifti-create-label ' VisualizeFolder '/100050_AtlasLabel' ...
       '.dlabel.nii -left-label ' V_lh_Label_File ' -right-label ' V_rh_Label_File];
system(cmd);
pause(1);
system(['rm -rf ' V_lh_File ' ' V_rh_File ' ' V_lh_Label_File ' ' V_rh_Label_File]);
