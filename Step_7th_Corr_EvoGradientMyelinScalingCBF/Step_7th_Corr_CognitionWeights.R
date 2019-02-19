
library(R.matlab)
library(ggplot2)

Folder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Corr_EvoGradientMyelinScalingCBF';
Data_Mat = readMat(paste0(Folder, '/AllData.mat'));

myPalette <- c("#9b2948", "#ff7251", "#ffca7b", "#ffcd74", "#ffedbf");
# Cognition weights vs. Evolutionary expansion
Data_tmp1 = data.frame(CognitionWeights_rh_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.rh.NoMedialWall));
Data_tmp1$Evo_rh = as.numeric(Data_Mat$Evo.rh);
cor.test(Data_tmp1$CognitionWeights_rh_NoMedialWall, Data_tmp1$Evo_rh, method = "spearman")
ggplot(data = Data_tmp1, aes(Evo_rh, CognitionWeights_rh_NoMedialWall)) +
    geom_hex() +
    scale_fill_gradientn(colours = myPalette) +
    theme_classic() + labs(x = "Evolutionary Expansion", y = "EF Prediction Weights") + 
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30))
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/EFPredictionWeights_Evo.tiff', width = 17, height = 15, dpi = 600, units = "cm");
# CognitionWeights vs. Principle gradient
Data_tmp2 = data.frame(CognitionWeights_All_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall));
Data_tmp2$PrincipleGradient_All_NoMedialWall = as.numeric(Data_Mat$PrincipleGradient.All.NoMedialWall);
cor.test(Data_tmp2$CognitionWeights_All_NoMedialWall, Data_tmp2$PrincipleGradient_All_NoMedialWall, method = "spearman");
ggplot(data = Data_tmp2, aes(PrincipleGradient_All_NoMedialWall, CognitionWeights_All_NoMedialWall)) + 
    geom_hex() +
    scale_fill_gradientn(colours = myPalette) +
    theme_classic() + labs(x = "Principle Gradient", y = "EF Prediction Weights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) 
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/EFPredictionWeights_Gradient.tiff', width = 17, height = 15, dpi = 600, units = "cm");
# CognitionWeights vs. Myelin
Data_tmp3 = data.frame(CognitionWeights_All_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall));
Data_tmp3$Myelin_All_NoMedialWall = as.numeric(Data_Mat$Myelin.All.NoMedialWall);
cor.test(Data_tmp3$CognitionWeights_All_NoMedialWall, Data_tmp3$Myelin_All_NoMedialWall, method = "spearman");
ggplot(data = Data_tmp3, aes(Myelin_All_NoMedialWall, CognitionWeights_All_NoMedialWall)) +
    geom_point() +
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Myelin", y = "CognitionWeights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");
# CognitionWeights vs. Myelin
Index = which(Data_Mat$Myelin.All.NoMedialWall >= 1);
Data_tmp4 = data.frame(CognitionWeights_All_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall[Index]));
Data_tmp4$Myelin_All_NoMedialWall = as.numeric(Data_Mat$Myelin.All.NoMedialWall[Index]);
cor.test(Data_tmp4$CognitionWeights_All_NoMedialWall, Data_tmp4$Myelin_All_NoMedialWall, method = "spearman");
ggplot(data = Data_tmp4, aes(Myelin_All_NoMedialWall, CognitionWeights_All_NoMedialWall)) +
    geom_hex() +
    scale_fill_gradientn(colours = myPalette) +
    theme_classic() + labs(x = "Myelin", y = "EF Prediction Weights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) + 
    scale_y_continuous(limits = c(-0.000001, 0.053), breaks = c(0, 0.01, 0.02, 0.03, 0.04, 0.05));
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/EFPredictionWeights_Myelin.tiff', width = 17, height = 15, dpi = 600, units = "cm");
# CognitionWeights vs. Allometric scaling
Data_tmp5 = data.frame(CognitionWeights_All_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall));
Data_tmp5$AllometricScaling_All_NoMedialWall = as.numeric(Data_Mat$AllometricScaling.All.NoMedialWall);
cor.test(Data_tmp5$CognitionWeights_All_NoMedialWall, Data_tmp5$AllometricScaling_All_NoMedialWall, method = "spearman");
ggplot(data = Data_tmp5, aes(AllometricScaling_All_NoMedialWall, CognitionWeights_All_NoMedialWall)) +
    geom_point() +
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Allometric Scaling", y = "CognitionWeights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");
# CognitionWeights vs. Allometric scaling
Index = which(Data_Mat$AllometricScaling.All.NoMedialWall >= 0.4);
Data_tmp5 = data.frame(CognitionWeights_All_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall[Index]));
Data_tmp5$AllometricScaling_All_NoMedialWall = as.numeric(Data_Mat$AllometricScaling.All.NoMedialWall[Index]);
cor.test(Data_tmp5$CognitionWeights_All_NoMedialWall, Data_tmp5$AllometricScaling_All_NoMedialWall, method = "spearman");
ggplot(data = Data_tmp5, aes(AllometricScaling_All_NoMedialWall, CognitionWeights_All_NoMedialWall)) +
    geom_hex() +
    scale_fill_gradientn(colours = myPalette) +
    theme_classic() + labs(x = "Allometric Scaling", y = "EF Prediction Weights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_y_continuous(limits = c(0, 0.053), breaks = c(0, 0.01, 0.02, 0.03, 0.04, 0.05));
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/EFPredictionWeights_Scaling.tiff', width = 17, height = 15, dpi = 600, units = "cm");
# CognitionWeights vs. Mean CBF
Data_tmp5 = data.frame(CognitionWeights_All_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall));
Data_tmp5$MeanCBF_All_NoMedialWall = as.numeric(Data_Mat$MeanCBF.All.NoMedialWall);
cor.test(Data_tmp5$CognitionWeights_All_NoMedialWall, Data_tmp5$MeanCBF_All_NoMedialWall, method = "spearman");
ggplot(data = Data_tmp5, aes(MeanCBF_All_NoMedialWall, CognitionWeights_All_NoMedialWall)) +
    geom_point() +
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Mean CBF", y = "CognitionWeights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");
# CognitionWeights vs. Mean CBF
Index = which(Data_Mat$MeanCBF.All.NoMedialWall >= 27);
Data_tmp5 = data.frame(CognitionWeights_All_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall[Index]));
Data_tmp5$MeanCBF_All_NoMedialWall = as.numeric(Data_Mat$MeanCBF.All.NoMedialWall[Index]);
cor.test(Data_tmp5$CognitionWeights_All_NoMedialWall, Data_tmp5$MeanCBF_All_NoMedialWall, method = "spearman");
ggplot(data = Data_tmp5, aes(MeanCBF_All_NoMedialWall, CognitionWeights_All_NoMedialWall)) +
    geom_hex() +
    scale_fill_gradientn(colours = myPalette) +
    theme_classic() + labs(x = "Mean CBF", y = "EF Prediction Weights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) + 
    scale_y_continuous(limits = c(0, 0.053), breaks = c(0, 0.01, 0.02, 0.03, 0.04, 0.05));
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/EFPredictionWeights_MeanCBF.tiff', width = 17, height = 15, dpi = 600, units = "cm");

# Significance
# CognitionWeights vs. evolutionary expansion
tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.rh.NoMedialWall),
                    as.numeric(Data_Mat$Evo.rh.NoMedialWall), method = "spearman");
Actual_Corr_Evo = tmp_data$estimate;
Perm_Corr_Evo = matrix(0, 1, 1000);
for (i in c(1:1000))
{ 
  print(i);
  tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.Perm.rh.NoMedialWall[i,]),
                      as.numeric(Data_Mat$Evo.rh.NoMedialWall), method = "spearman");
  Perm_Corr_Evo[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Evo >= Actual_Corr_Evo)) / 1000;
print(paste0('P value (variability vs. evo): ', as.character(P_Value)));
# CognitionWeights vs. principle gradients
tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall),
                    as.numeric(Data_Mat$PrincipleGradient.All.NoMedialWall), method = "spearman");
Actual_Corr_Gradient = tmp_data$estimate;
Perm_Corr_Gradient = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i)
  tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.Perm.All.NoMedialWall[i,]),
                      as.numeric(Data_Mat$PrincipleGradient.All.NoMedialWall), method = "spearman");
  Perm_Corr_Gradient[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Gradient >= Actual_Corr_Gradient)) / 1000;
print(paste0('P value (variability vs. principle gradient): ', as.character(P_Value)));
# CognitionWeights vs. myelin
Index = which(Data_Mat$Myelin.All.NoMedialWall >= 1);
tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall[Index]),
                    as.numeric(Data_Mat$Myelin.All.NoMedialWall[Index]), method = "spearman");
Actual_Corr_Myelin = tmp_data$estimate;
Perm_Corr_Myelin = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.Perm.All.NoMedialWall[i,Index]),
                      as.numeric(Data_Mat$Myelin.All.NoMedialWall[Index]), method = "spearman");
  Perm_Corr_Myelin[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Myelin <= Actual_Corr_Myelin)) / 1000;
print(paste0('P value (variability vs. myelin): ', as.character(P_Value)));
# CognitionWeights vs allometric scaling
Index = which(Data_Mat$AllometricScaling.All.NoMedialWall >= 0.4);
tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall[Index]),
                    as.numeric(Data_Mat$AllometricScaling.All.NoMedialWall[Index]), method = "spearman");
Actual_Corr_Scaling = tmp_data$estimate;
Perm_Corr_Scaling = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i)
  tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.Perm.All.NoMedialWall[i,Index]),
                      as.numeric(Data_Mat$AllometricScaling.All.NoMedialWall[Index]), method = "spearman");
  Perm_Corr_Scaling[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Scaling >= Actual_Corr_Scaling)) / 1000;
print(paste0('P value (variability vs. allometric scaling): ', as.character(P_Value)));
# CognitionWeights vs MeanCBF
Index = which(Data_Mat$MeanCBF.All.NoMedialWall >= 0.4);
tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall[Index]),
                    as.numeric(Data_Mat$MeanCBF.All.NoMedialWall[Index]), method = "spearman");
Actual_Corr_CBF = tmp_data$estimate;
Perm_Corr_CBF = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i)
  tmp_data = cor.test(as.numeric(Data_Mat$CognitionWeights.Perm.All.NoMedialWall[i,Index]),
                      as.numeric(Data_Mat$MeanCBF.All.NoMedialWall[Index]), method = "spearman");
  Perm_Corr_CBF[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_CBF >= Actual_Corr_CBF)) / 1000;
print(paste0('P value (variability vs. mean CBF): ', as.character(P_Value)));
