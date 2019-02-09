
clear
ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
WorkingFolder = [ReplicationFolder '/results/SingleParcellation_Kong/WorkingFolder'];
Demogra_Info = csvread([ReplicationFolder '/data/pncSingleFuncParcel_n713_SubjectsIDs.csv'],1);
BBLID = Demogra_Info(:, 1);

mesh = 'fsaverage5';
num_sess = '2';
num_clusters = '17';
w = '200';
c = '30';

ResultantFolder = [WorkingFolder '/ind_parcellation_200_30'];
for i = 1:length(BBLID)
    subid = num2str(i);
    Job_Name = ['IndiParcel_' num2str(i)];
    pipeline.(Job_Name).command = 'CZ_IndividualParcellation(opt.para1, opt.para2, opt.para3, opt.para4, opt.para5, opt.para6, opt.para7, opt.para8, opt.para9)';
    pipeline.(Job_Name).opt.para1 = WorkingFolder;
    pipeline.(Job_Name).opt.para2 = BBLID(i);
    pipeline.(Job_Name).opt.para3 = mesh;
    pipeline.(Job_Name).opt.para4 = num_sess;
    pipeline.(Job_Name).opt.para5 = num_clusters;
    pipeline.(Job_Name).opt.para6 = subid;
    pipeline.(Job_Name).opt.para7 = w;
    pipeline.(Job_Name).opt.para8 = c;
    pipeline.(Job_Name).opt.para9 = ResultantFolder;
end

psom_gb_vars
Pipeline_opt.mode = 'qsub';
Pipeline_opt.qsub_options = '-q all.q,basic.q';
Pipeline_opt.mode_pipeline_manager = 'batch';
Pipeline_opt.max_queued = 200;
Pipeline_opt.flag_verbose = 1;
Pipeline_opt.flag_pause = 0;
Pipeline_opt.path_logs = [WorkingFolder '/logs_IndividualParcellation'];

psom_run_pipeline(pipeline, Pipeline_opt);

