
function Atlas_Homogeneity(AtlasLabel_File_Path, Image_lh_Path, Image_rh_Path, ResultantFile, Flag)
    
    tmp = load(AtlasLabel_File_Path);
    if strcmp(Flag, 'Hongming')
      sbj_AtlasLabel = [tmp.sbj_AtlasLabel_lh tmp.sbj_AtlasLabel_rh];
    elseif strcmp(Flag, 'Kong')
      sbj_AtlasLabel = [tmp.lh_labels' tmp.rh_labels'];
    end

    Data_lh = MRIread(Image_lh_Path);
    Data_lh = squeeze(Data_lh.vol);
    Data_rh = MRIread(Image_rh_Path);
    Data_rh = squeeze(Data_rh.vol);
    Data_All = [Data_lh; Data_rh];
    
    AtlasLabel_Unique = unique(sbj_AtlasLabel);
    AtlasLabel_Unique = setdiff(AtlasLabel_Unique, 0);
    AtlasLabel_Quantity = length(AtlasLabel_Unique);
    for j = 1:AtlasLabel_Quantity
        j
        System_Index{j} = find(sbj_AtlasLabel == AtlasLabel_Unique(j));
        Vertex_Quantity = length(System_Index{j});
        Conn_System = Data_All(System_Index{j}, :)';
        MeanTimeSeries = mean(Conn_System, 2);
        for k = 1:Vertex_Quantity
            Corr_WithinSystem(k) = corr(MeanTimeSeries, Conn_System(:, k));
        end
        Homogeneity_WithinNetwork(j) = sum(Corr_WithinSystem) / Vertex_Quantity; 
        clear Corr_WithinSystem;
    end
    Homogeneity_Overall = mean(Homogeneity_WithinNetwork);
    save(ResultantFile, 'Homogeneity_WithinNetwork', 'Homogeneity_Overall');


