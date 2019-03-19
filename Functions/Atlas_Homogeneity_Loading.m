
function Atlas_Homogeneity_Loading(AtlasLoading_File_Path, Image_lh_Path, Image_rh_Path, ResultantFile)
    
    tmp = load(AtlasLoading_File_Path);
    sbj_AtlasLoading = [tmp.sbj_AtlasLoading_lh tmp.sbj_AtlasLoading_rh];

    Data_lh = MRIread(Image_lh_Path);
    Data_lh = squeeze(Data_lh.vol);
    Data_rh = MRIread(Image_rh_Path);
    Data_rh = squeeze(Data_rh.vol);
    Data_All = [Data_lh; Data_rh];

    for i = 1:17
        LoadingNetwork_I = sbj_AtlasLoading(i, :);
        TimeSeries_WeightedMean = mean(Data_All' .* repmat(LoadingNetwork_I, 555, 1), 2);
        for j = 1:20484
            Corr_All(j) = corr(Data_All(j, :)', TimeSeries_WeightedMean);
        end
        Homogeneity_WithinNetwork(i) = sum(Corr_All .* LoadingNetwork_I) / sum(LoadingNetwork_I);
    end
    Homogeneity_Overall = mean(Homogeneity_WithinNetwork);
    save(ResultantFile, 'Homogeneity_WithinNetwork', 'Homogeneity_Overall');
    
    

