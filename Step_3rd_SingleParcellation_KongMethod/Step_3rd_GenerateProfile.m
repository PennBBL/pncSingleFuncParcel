
clear
seed_mesh = 'fsaverage3';
targ_mesh = 'fsaverage5';
out_dir = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/SingleParcellation_Kong/WorkingFolder';

DataFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/data';
Demogra_Info = csvread([DataFolder '/pncSingleFuncParcel_n713_SubjectsIDs.csv'],1);
BBLID = Demogra_Info(:, 1);

for i = 1:length(BBLID)
    i
    sub = num2str(BBLID(i));
    for sess = 1:3
        Job_Name = ['GenerateProfile_' num2str(i) '_' num2str(sess)];
        pipeline.(Job_Name).command = 'CBIG_MSHBM_generate_profiles(opt.para1, opt.para2, opt.para3, opt.para4, opt.para5, ''0'')';
        pipeline.(Job_Name).opt.para1 = seed_mesh;
        pipeline.(Job_Name).opt.para2 = targ_mesh;
        pipeline.(Job_Name).opt.para3 = out_dir;
        pipeline.(Job_Name).opt.para4 = sub;
        pipeline.(Job_Name).opt.para5 = num2str(sess);
    end
end

psom_gb_vars
Pipeline_opt.mode = 'qsub';
Pipeline_opt.qsub_options = '-q all.q,basic.q';
Pipeline_opt.mode_pipeline_manager = 'batch';
Pipeline_opt.max_queued = 200;
Pipeline_opt.flag_verbose = 1;
Pipeline_opt.flag_pause = 0;
Pipeline_opt.path_logs = [out_dir '/logs_GenerateProfiles'];

psom_run_pipeline(pipeline, Pipeline_opt);
