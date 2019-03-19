
function Atlas_Homogeneity_Pipeline(Loading_File_Cell, Image_lh_Path_Cell, Image_rh_Path_Cell, ResultantFile_Cell)

for i = 1:length(Loading_File_Cell)
    JobName = ['Homogeneity_' num2str(i)];
    pipeline.(JobName).command = 'Atlas_Homogeneity_Loading(opt.Loading_File_Path, opt.Image_lh_Path, opt.Image_rh_Path, opt.ResultantFile)';
    pipeline.(JobName).opt.Loading_File_Path = Loading_File_Cell{i};
    pipeline.(JobName).opt.Image_lh_Path = Image_lh_Path_Cell{i};
    pipeline.(JobName).opt.Image_rh_Path = Image_rh_Path_Cell{i};
    pipeline.(JobName).opt.ResultantFile = ResultantFile_Cell{i};
end

psom_gb_vars

Pipeline_opt.mode = 'qsub';
Pipeline_opt.qsub_options = '-q all.q,basic.q -l h_vmem=5G,s_vmem=5G';
Pipeline_opt.mode_pipeline_manager = 'batch';
Pipeline_opt.max_queued = 200;
Pipeline_opt.flag_verbose = 1;
Pipeline_opt.flag_pause = 0;
[ParentFolder, ~, ~] = fileparts(ResultantFile_Cell{1});
Pipeline_opt.path_logs = [ParentFolder filesep 'Homogeneity_logs'];

psom_run_pipeline(pipeline,Pipeline_opt);

