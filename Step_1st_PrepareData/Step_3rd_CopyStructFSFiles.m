
clear
%
% This step is to copy the freesurfer processing results of T1-weighted images
% Running this step is time-costly and also needs a lot of space
% Could skip this step and in the following just use the freesurfer processing data in the path:
%         /data/jux/BBL/projects/pncSingleFuncParcel/data/Structural
%
DataFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/data';
Demogra_Info = csvread([DataFolder '/pncSingleFuncParcel_n713_SubjectsIDs.csv'],1);
BBLID = Demogra_Info(:, 1);
ScanID = Demogra_Info(:, 2);

StrucFolder = '/data/joy/BBL/studies/pnc/processedData/structural/freesurfer53';
ResultantFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/data/Structural';
mkdir(ResultantFolder);
for i = 1:length(BBLID)
    i
    Sub_Folder = [ResultantFolder '/' num2str(BBLID(i))];
    cmd = ['cp -r ' StrucFolder '/' num2str(BBLID(i)) '/*x' num2str(ScanID(i)) '/ ' Sub_Folder];
    system(cmd);
end

