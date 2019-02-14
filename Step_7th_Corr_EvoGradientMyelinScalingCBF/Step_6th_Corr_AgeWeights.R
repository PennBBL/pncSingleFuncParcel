
library(R.matlab)
library(ggplot2)

Folder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Corr_EvoGradientMyelinScalingCBF/';
Data_Mat = readMat(paste0(Folder, '/AllData.mat'));

# Age weights vs. Evolutionary expansion
Data_tmp1 = data.frame(AgeWeights_rh_NoMedialWall = as.numeric(Data_Mat$AgeWeights.rh.NoMedialWall));
Data_tmp1$Evo_rh = as.numeric(Data_Mat$Evo.rh);
cor.test(Data_tmp1$AgeWeights_rh_NoMedialWall, Data_tmp1$Evo_rh)
ggplot(data = Data_tmp1, aes(Evo_rh, AgeWeights_rh_NoMedialWall)) +
    geom_point() + 
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Evolutionary expansion", y = "AgeWeights") + 
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");
# AgeWeights vs. Principle gradient
Data_tmp2 = data.frame(AgeWeights_All_NoMedialWall = as.numeric(Data_Mat$AgeWeights.All.NoMedialWall));
Data_tmp2$PrincipleGradient_All_NoMedialWall = as.numeric(Data_Mat$PrincipleGradient.All.NoMedialWall);
cor.test(Data_tmp2$AgeWeights_All_NoMedialWall, Data_tmp2$PrincipleGradient_All_NoMedialWall);
ggplot(data = Data_tmp2, aes(PrincipleGradient_All_NoMedialWall, AgeWeights_All_NoMedialWall)) + 
    geom_point() +
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Principle gradient", y = "AgeWeights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");
# AgeWeights vs. Myelin
Data_tmp3 = data.frame(AgeWeights_All_NoMedialWall = as.numeric(Data_Mat$AgeWeights.All.NoMedialWall));
Data_tmp3$Myelin_All_NoMedialWall = as.numeric(Data_Mat$Myelin.All.NoMedialWall);
cor.test(Data_tmp3$AgeWeights_All_NoMedialWall, Data_tmp3$Myelin_All_NoMedialWall);
ggplot(data = Data_tmp3, aes(Myelin_All_NoMedialWall, AgeWeights_All_NoMedialWall)) +
    geom_point() +
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Myelin", y = "AgeWeights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");
# AgeWeights vs. Myelin
Index = which(Data_Mat$Myelin.All.NoMedialWall >= 1);
Data_tmp4 = data.frame(AgeWeights_All_NoMedialWall = as.numeric(Data_Mat$AgeWeights.All.NoMedialWall[Index]));
Data_tmp4$Myelin_All_NoMedialWall = as.numeric(Data_Mat$Myelin.All.NoMedialWall[Index]);
cor.test(Data_tmp4$AgeWeights_All_NoMedialWall, Data_tmp4$Myelin_All_NoMedialWall);
ggplot(data = Data_tmp4, aes(Myelin_All_NoMedialWall, AgeWeights_All_NoMedialWall)) +
    geom_point() +
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Myelin", y = "AgeWeights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");
# AgeWeights vs. Allometric scaling
Data_tmp5 = data.frame(AgeWeights_All_NoMedialWall = as.numeric(Data_Mat$AgeWeights.All.NoMedialWall));
Data_tmp5$AllometricScaling_All_NoMedialWall = as.numeric(Data_Mat$AllometricScaling.All.NoMedialWall);
cor.test(Data_tmp5$AgeWeights_All_NoMedialWall, Data_tmp5$AllometricScaling_All_NoMedialWall);
ggplot(data = Data_tmp5, aes(AllometricScaling_All_NoMedialWall, AgeWeights_All_NoMedialWall)) +
    geom_point() +
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Allometric scaling", y = "AgeWeights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");
# AgeWeights vs. Allometric scaling
Index = which(Data_Mat$AllometricScaling.All.NoMedialWall >= 0.4);
Data_tmp5 = data.frame(AgeWeights_All_NoMedialWall = as.numeric(Data_Mat$AgeWeights.All.NoMedialWall[Index]));
Data_tmp5$AllometricScaling_All_NoMedialWall = as.numeric(Data_Mat$AllometricScaling.All.NoMedialWall[Index]);
cor.test(Data_tmp5$AgeWeights_All_NoMedialWall, Data_tmp5$AllometricScaling_All_NoMedialWall);
ggplot(data = Data_tmp5, aes(AllometricScaling_All_NoMedialWall, AgeWeights_All_NoMedialWall)) +
    geom_point() +
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Allometric scaling", y = "AgeWeights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");
# AgeWeights vs. Mean CBF
Data_tmp5 = data.frame(AgeWeights_All_NoMedialWall = as.numeric(Data_Mat$AgeWeights.All.NoMedialWall));
Data_tmp5$MeanCBF_All_NoMedialWall = as.numeric(Data_Mat$MeanCBF.All.NoMedialWall);
cor.test(Data_tmp5$AgeWeights_All_NoMedialWall, Data_tmp5$MeanCBF_All_NoMedialWall);
ggplot(data = Data_tmp5, aes(MeanCBF_All_NoMedialWall, AgeWeights_All_NoMedialWall)) +
    geom_point() +
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Mean CBF", y = "AgeWeights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");
# AgeWeights vs. Mean CBF
Index = which(Data_Mat$MeanCBF.All.NoMedialWall >= 27);
Data_tmp5 = data.frame(AgeWeights_All_NoMedialWall = as.numeric(Data_Mat$AgeWeights.All.NoMedialWall[Index]));
Data_tmp5$MeanCBF_All_NoMedialWall = as.numeric(Data_Mat$MeanCBF.All.NoMedialWall[Index]);
cor.test(Data_tmp5$AgeWeights_All_NoMedialWall, Data_tmp5$MeanCBF_All_NoMedialWall);
ggplot(data = Data_tmp5, aes(MeanCBF_All_NoMedialWall, AgeWeights_All_NoMedialWall)) +
    geom_point() +
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Mean CBF", y = "AgeWeights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");

# Significance
# AgeWeights vs. evolutionary expansion
tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.rh.NoMedialWall),
                    as.numeric(Data_Mat$Evo.rh.NoMedialWall));
Actual_Corr_Evo = tmp_data$estimate;
Perm_Corr_Evo = matrix(0, 1, 1000);
for (i in c(1:1000))
{ 
  print(i);
  tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.Perm.rh.NoMedialWall[i,]),
                      as.numeric(Data_Mat$Evo.rh.NoMedialWall));
  Perm_Corr_Evo[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Evo >= Actual_Corr_Evo)) / 1000;
print(paste0('P value (variability vs. evo): ', as.character(P_Value)));
# AgeWeights vs. principle gradients
tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.All.NoMedialWall),
                    as.numeric(Data_Mat$PrincipleGradient.All.NoMedialWall));
Actual_Corr_Gradient = tmp_data$estimate;
Perm_Corr_Gradient = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i)
  tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.Perm.All.NoMedialWall[i,]),
                      as.numeric(Data_Mat$PrincipleGradient.All.NoMedialWall));
  Perm_Corr_Gradient[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Gradient >= Actual_Corr_Gradient)) / 1000;
print(paste0('P value (variability vs. principle gradient): ', as.character(P_Value)));
# AgeWeights vs. myelin
Index = which(Data_Mat$Myelin.All.NoMedialWall >= 1);
tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.All.NoMedialWall[Index]),
                    as.numeric(Data_Mat$Myelin.All.NoMedialWall[Index]));
Actual_Corr_Myelin = tmp_data$estimate;
Perm_Corr_Myelin = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i);
  tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.Perm.All.NoMedialWall[i,Index]),
                      as.numeric(Data_Mat$Myelin.All.NoMedialWall[Index]));
  Perm_Corr_Myelin[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Myelin <= Actual_Corr_Myelin)) / 1000;
print(paste0('P value (variability vs. myelin): ', as.character(P_Value)));
# AgeWeights vs allometric scaling
Index = which(Data_Mat$AllometricScaling.All.NoMedialWall >= 0.4);
tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.All.NoMedialWall[Index]),
                    as.numeric(Data_Mat$AllometricScaling.All.NoMedialWall[Index]));
Actual_Corr_Scaling = tmp_data$estimate;
Perm_Corr_Scaling = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i)
  tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.Perm.All.NoMedialWall[i,Index]),
                      as.numeric(Data_Mat$AllometricScaling.All.NoMedialWall[Index]));
  Perm_Corr_Scaling[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Scaling >= Actual_Corr_Scaling)) / 1000;
print(paste0('P value (variability vs. allometric scaling): ', as.character(P_Value)));
# AgeWeights vs MeanCBF
Index = which(Data_Mat$MeanCBF.All.NoMedialWall >= 0.4);
tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.All.NoMedialWall[Index]),
                    as.numeric(Data_Mat$MeanCBF.All.NoMedialWall[Index]));
Actual_Corr_Scaling = tmp_data$estimate;
Perm_Corr_Scaling = matrix(0, 1, 1000);
for (i in c(1:1000))
{
  print(i)
  tmp_data = cor.test(as.numeric(Data_Mat$AgeWeights.Perm.All.NoMedialWall[i,Index]),
                      as.numeric(Data_Mat$MeanCBF.All.NoMedialWall[Index]));
  Perm_Corr_Scaling[i] = tmp_data$estimate;
}
P_Value = length(which(Perm_Corr_Scaling >= Actual_Corr_Scaling)) / 1000;
print(paste0('P value (variability vs. mean CBF): ', as.character(P_Value)));
