
library(R.matlab)
library(ggplot2)

Folder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Corr_EvoGradientMyelinScalingCBF';
Data_Mat = readMat(paste0(Folder, '/AllData.mat'));

# plot the highest correlation
myPalette <- c("#9b2948", "#ff7251", "#ffca7b", "#ffcd74", "#ffedbf");
# Correlation between age prediction weights and atlas variability
data_Age = data.frame(Variability_Data = as.numeric(t(Data_Mat$VariabilityLoading.17SystemMean.All.NoMedialWall)));
data_Age$AgeWeights_Mean = as.numeric(Data_Mat$AgeWeights.All.NoMedialWall);
cor.test(data_Age$AgeWeights_Mean, data_Age$Variability_Data, method = "spearman");
ggplot(data = data_Age, aes(Variability_Data, AgeWeights_Mean)) +
         geom_hex() + 
         scale_fill_gradientn(colours = myPalette) +
         theme_classic() + labs(x = "Atlas variability", y = "Prediction weights") +
         theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30), aspect.ratio = 1) +
         scale_x_continuous(limits = c(0, 0.053), breaks = c(0, 0.01, 0.02, 0.03, 0.04, 0.05)) + 
         scale_y_continuous(limits = c(0, 0.053), breaks = c(0, 0.01, 0.02, 0.03, 0.04, 0.05));
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/AgeWeights_Variability.tiff', width = 17, height = 15, dpi = 600, units = "cm");
# Cognition prediction weights vs. atlas variability
data_Cognition = data.frame(Variability_Data = as.numeric(t(Data_Mat$VariabilityLoading.17SystemMean.All.NoMedialWall)));
data_Cognition$CognitionWeights_Mean = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall);
cor.test(data_Cognition$CognitionWeights_Mean, data_Cognition$Variability_Data, method = "spearman");
ggplot(data = data_Cognition, aes(Variability_Data, CognitionWeights_Mean)) +
        geom_hex() + 
        scale_fill_gradientn(colours = myPalette) +
        theme_classic() + labs(x = "Atlas variability", y = "Prediction weights") +
        theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30), aspect.ratio = 1) +
        scale_x_continuous(limits = c(0, 0.053), breaks = c(0, 0.01, 0.02, 0.03, 0.04, 0.05)) +
        scale_y_continuous(limits = c(0, 0.053), breaks = c(0, 0.01, 0.02, 0.03, 0.04, 0.05));
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/EFWeights_Variability.tiff', width = 17, height = 15, dpi = 600, units = "cm");

# Significance
# AgeWeights vs. variability
tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.All.NoMedialWall),
                    as.numeric(Data_Mat$VariabilityLoading.17SystemMean.All.NoMedialWall), method = "spearman");
Actual_Corr_Variability_AgeWeights = tmp_data$estimate;
Perm_Corr_Variability_AgeWeights = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.Perm.All.NoMedialWall[i,]),
                      as.numeric(Data_Mat$VariabilityLoading.17SystemMean.All.NoMedialWall), method = "spearman");
  Perm_Corr_Variability_AgeWeights[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Variability_AgeWeights >= Actual_Corr_Variability_AgeWeights)) / 1000;
print(paste0('P value (variability vs. age prediction weights): ', as.character(P_Value)));
# CognitionWeights vs. variability
tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall),
                    as.numeric(Data_Mat$VariabilityLoading.17SystemMean.All.NoMedialWall), method = "spearman");
Actual_Corr_Variability_CognitionWeights = tmp_data$estimate;
Perm_Corr_Variability_CognitionWeights = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.Perm.All.NoMedialWall[i,]),
                      as.numeric(Data_Mat$VariabilityLoading.17SystemMean.All.NoMedialWall), method = "spearman");
  Perm_Corr_Variability_CognitionWeights[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Variability_CognitionWeights >= Actual_Corr_Variability_CognitionWeights)) / 1000;
print(paste0('P value (variability vs. cognition prediction weights): ', as.character(P_Value)));
