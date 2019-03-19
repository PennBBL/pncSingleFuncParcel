
library(R.matlab)
library(ggplot2)
library(hexbin)

Folder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Corr_EvoGradientMyelinScalingCBF';
Data_Mat = readMat(paste0(Folder, '/AllData.mat'));

myPalette <- c("#333333", "#4C4C4C", "#666666", "#7F7F7F", "#999999", "#B2B2B2", "#CCCCCC");
# Cognition weights vs. Evolutionary expansion
Data_tmp1 = data.frame(CognitionWeights_rh_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.rh.NoMedialWall));
Data_tmp1$Evo_rh_NoMedialWall = as.numeric(Data_Mat$Evo.rh.NoMedialWall);
cor.test(Data_tmp1$CognitionWeights_rh_NoMedialWall, Data_tmp1$Evo_rh_NoMedialWall, method = "spearman")

hexinfo <- hexbin(Data_tmp1$Evo_rh_NoMedialWall, Data_tmp1$CognitionWeights_rh_NoMedialWall, xbins = 30);
data_hex <- data.frame(hcell2xy(hexinfo), count = hexinfo@count);
ggplot() +
    #geom_hex(data = data_hex, aes(x, y, fill = count), stat = "identity") +
    geom_hex(data = subset(data_hex, count > 10), aes(x, y, fill = count), stat = "identity") +
    scale_fill_gradientn(colours = myPalette, breaks = c(20, 40, 60)) +
    geom_smooth(data = Data_tmp1, aes(x = Evo_rh_NoMedialWall, y = CognitionWeights_rh_NoMedialWall), method = lm, color = "#FFFFFF", linetype = "dashed") +
    theme_classic() + labs(x = "Evolutionary Expansion", y = "EF Prediction Weights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30), aspect.ratio = 1) +
    theme(legend.text = element_text(size = 18), legend.title = element_text(size = 18)) +
    theme(legend.justification = c(1, 1), legend.position = c(1, 1)) +
    scale_x_continuous(limits = c(-2.2, 3.0), breaks = c(-2, -1, 0, 1, 2, 3)) +
    scale_y_continuous(limits = c(-0.000001, 0.042), breaks = c(0, 0.01, 0.02, 0.04));
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/EFPredictionWeights_Evo.pdf', width = 17, height = 15, dpi = 600, units = "cm");

# CognitionWeights vs. Principle gradient
Data_tmp2 = data.frame(CognitionWeights_All_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall));
Data_tmp2$PrincipleGradient_All_NoMedialWall = as.numeric(Data_Mat$PrincipleGradient.All.NoMedialWall);
cor.test(Data_tmp2$CognitionWeights_All_NoMedialWall, Data_tmp2$PrincipleGradient_All_NoMedialWall, method = "spearman");

hexinfo <- hexbin(Data_tmp2$PrincipleGradient_All_NoMedialWall, Data_tmp2$CognitionWeights_All_NoMedialWall, xbins = 30);
data_hex <- data.frame(hcell2xy(hexinfo), count = hexinfo@count);
ggplot() +
    #geom_hex(data = data_hex, aes(x, y, fill = count), stat = "identity") +
    geom_hex(data = subset(data_hex, count > 10), aes(x, y, fill = count), stat = "identity") +
    scale_fill_gradientn(colours = myPalette) +
    geom_smooth(data = Data_tmp2, aes(x = PrincipleGradient_All_NoMedialWall, y = CognitionWeights_All_NoMedialWall), method = lm, color = "#FFFFFF", linetype = "dashed") +
    theme_classic() + labs(x = "Principal Gradient", y = "EF Prediction Weights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30), aspect.ratio = 1) +
    theme(legend.text = element_text(size = 18), legend.title = element_text(size = 18)) +
    theme(legend.justification = c(1, 1), legend.position = c(1, 1)) +
    scale_x_continuous(limits = c(-6, 7.5), breaks = c(-6, -3, 0, 3, 6)) +
    scale_y_continuous(limits = c(-0.000001, 0.042), breaks = c(0, 0.01, 0.02, 0.03, 0.04));
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/EFPredictionWeights_Gradient.pdf', width = 17, height = 15, dpi = 600, units = "cm");

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

hexinfo <- hexbin(Data_tmp4$Myelin_All_NoMedialWall, Data_tmp4$CognitionWeights_All_NoMedialWall, xbins = 30);
data_hex <- data.frame(hcell2xy(hexinfo), count = hexinfo@count);
ggplot() +
    #geom_hex(data = data_hex, aes(x, y, fill = count), stat = "identity") +
    geom_hex(data = subset(data_hex, count > 10), aes(x, y, fill = count), stat = "identity") +
    scale_fill_gradientn(colours = myPalette) +
    geom_smooth(data = Data_tmp4, aes(x = Myelin_All_NoMedialWall, y = CognitionWeights_All_NoMedialWall), method = lm, color = "#FFFFFF", linetype = "dashed") +
    theme_classic() + labs(x = "Myelin", y = "EF Prediction Weights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30), aspect.ratio = 1) +
    theme(legend.text = element_text(size = 18), legend.title = element_text(size = 18)) +
    theme(legend.justification = c(1, 1), legend.position = c(1, 1)) +
    scale_x_continuous(limits = c(0.98, 1.9), breaks = c(1.0, 1.2, 1.4, 1.6, 1.8)) +
    scale_y_continuous(limits = c(-0.000001, 0.042), breaks = c(0, 0.01, 0.02, 0.03, 0.04));
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/EFPredictionWeights_Myelin.pdf', width = 17, height = 15, dpi = 600, units = "cm");


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
Data_tmp6 = data.frame(CognitionWeights_All_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall[Index]));
Data_tmp6$AllometricScaling_All_NoMedialWall = as.numeric(Data_Mat$AllometricScaling.All.NoMedialWall[Index]);
cor.test(Data_tmp6$CognitionWeights_All_NoMedialWall, Data_tmp6$AllometricScaling_All_NoMedialWall, method = "spearman");

hexinfo <- hexbin(Data_tmp6$AllometricScaling_All_NoMedialWall, Data_tmp6$CognitionWeights_All_NoMedialWall, xbins = 30);
data_hex <- data.frame(hcell2xy(hexinfo), count = hexinfo@count);
ggplot() +
    #geom_hex(data = data_hex, aes(x, y, fill = count), stat = "identity") +
    geom_hex(data = subset(data_hex, count > 10), aes(x, y, fill = count), stat = "identity") +
    scale_fill_gradientn(colours = myPalette, breaks = c(50, 100, 150)) +
    geom_smooth(data = Data_tmp6, aes(x = AllometricScaling_All_NoMedialWall, y = CognitionWeights_All_NoMedialWall), method = lm, color = "#FFFFFF", linetype = "dashed") +
    theme_classic() + labs(x = "Allometric Scaling", y = "EF Prediction Weights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30), aspect.ratio = 1) +
    theme(legend.text = element_text(size = 18), legend.title = element_text(size = 18)) +
    theme(legend.justification = c(1, 1), legend.position = c(1, 1)) +
    scale_x_continuous(limits = c(0.4, 1.5), breaks = c(0.5, 1,0, 1.5)) +
    scale_y_continuous(limits = c(-0.000001, 0.042), breaks = c(0, 0.01, 0.02, 0.03, 0.04));
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/EFPredictionWeights_Scaling.pdf', width = 17, height = 15, dpi = 600, units = "cm");

# CognitionWeights vs. Mean CBF
Data_tmp7 = data.frame(CognitionWeights_All_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall));
Data_tmp7$MeanCBF_All_NoMedialWall = as.numeric(Data_Mat$MeanCBF.All.NoMedialWall);
cor.test(Data_tmp7$CognitionWeights_All_NoMedialWall, Data_tmp7$MeanCBF_All_NoMedialWall, method = "spearman");
ggplot(data = Data_tmp7, aes(MeanCBF_All_NoMedialWall, CognitionWeights_All_NoMedialWall)) +
    geom_point() +
    geom_smooth(method = lm) +
    theme_classic() + labs(x = "Mean CBF", y = "CognitionWeights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
    scale_fill_manual("", values = "grey12");
# CognitionWeights vs. Mean CBF
Index = which(Data_Mat$MeanCBF.All.NoMedialWall >= 27);
Data_tmp8 = data.frame(CognitionWeights_All_NoMedialWall = as.numeric(Data_Mat$CognitionWeights.All.NoMedialWall[Index]));
Data_tmp8$MeanCBF_All_NoMedialWall = as.numeric(Data_Mat$MeanCBF.All.NoMedialWall[Index]);
cor.test(Data_tmp8$CognitionWeights_All_NoMedialWall, Data_tmp8$MeanCBF_All_NoMedialWall, method = "spearman");

hexinfo <- hexbin(Data_tmp8$MeanCBF_All_NoMedialWall, Data_tmp8$CognitionWeights_All_NoMedialWall, xbins = 30);
data_hex <- data.frame(hcell2xy(hexinfo), count = hexinfo@count);
ggplot() +
    #geom_hex(data = data_hex, aes(x, y, fill = count), stat = "identity") +
    geom_hex(data = subset(data_hex, count > 10), aes(x, y, fill = count), stat = "identity") +
    scale_fill_gradientn(colours = myPalette, breaks = c(40, 80, 120)) +
    geom_smooth(data = Data_tmp8, aes(x = MeanCBF_All_NoMedialWall, y = CognitionWeights_All_NoMedialWall), method = lm, color = "#FFFFFF", linetype = "dashed") +
    theme_classic() + labs(x = "Mean CBF", y = "EF Prediction Weights") +
    theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30), aspect.ratio = 1) +
    theme(legend.text = element_text(size = 18), legend.title = element_text(size = 18)) +
    theme(legend.justification = c(1, 1), legend.position = c(1, 1)) +
    scale_x_continuous(limits = c(32, 88), breaks = c(40, 60, 80)) +
    scale_y_continuous(limits = c(-0.000001, 0.042), breaks = c(0, 0.01, 0.02, 0.03, 0.04));
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/EFPredictionWeights_MeanCBF.pdf', width = 17, height = 15, dpi = 600, units = "cm");

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
  # Plot for permutation distribution
PermutationData = data.frame(x = t(Perm_Corr_Evo));
PermutationData$Line_x = as.numeric(matrix(0.32, 1, 1000));
PermutationData$Line_y = as.numeric(seq(0,140,length.out=1000));
ggplot(PermutationData) +
    geom_histogram(aes(x = x), bins = 30, color = "#999999", fill = "#999999") +
    #geom_point(aes(x = Actual_Corr, y = 0), size=3) +
    geom_line(aes(x = Line_x, y = Line_y, group = 1), size = 1, color = 'red', linetype = "dashed") +
    theme_classic() + labs(x = "", y = "") +
    theme(axis.text=element_text(size=50, color='black'), aspect.ratio = 1) +
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(limits = c(-0.6, 0.6), breaks = c(-0.4, 0, 0.4), labels = c('-0.4', '0', '0.4'))
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/SpinTestDensity_EFPredictionWeights_Evo.pdf', width = 17, height = 15, dpi = 600, units = "cm");

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
  # Plot for permutation distribution
PermutationData = data.frame(x = t(Perm_Corr_Gradient));
PermutationData$Line_x = as.numeric(matrix(0.29, 1, 1000));
PermutationData$Line_y = as.numeric(seq(0,120,length.out=1000));
ggplot(PermutationData) +
    geom_histogram(aes(x = x), bins = 30, color = "#999999", fill = "#999999") +
    #geom_point(aes(x = Actual_Corr, y = 0), size=3) +
    geom_line(aes(x = Line_x, y = Line_y, group = 1), size = 1, color = 'red', linetype = "dashed") +
    theme_classic() + labs(x = "", y = "") +
    theme(axis.text=element_text(size=50, color='black'), aspect.ratio = 1) +
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(limits = c(-0.5, 0.5), breaks = c(-0.3, 0, 0.3), labels = c('-0.3', '0', '0.3'))
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/SpinTestDensity_EFPredictionWeights_Gradient.pdf', width = 17, height = 15, dpi = 600, units = "cm");

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
  # Plot for permutation distribution
PermutationData = data.frame(x = t(Perm_Corr_Myelin));
PermutationData$Line_x = as.numeric(matrix(-0.29, 1, 1000));
PermutationData$Line_y = as.numeric(seq(0,110,length.out=1000));
ggplot(PermutationData) +
    geom_histogram(aes(x = x), bins = 30, color = "#999999", fill = "#999999") +
    #geom_point(aes(x = Actual_Corr, y = 0), size=3) +
    geom_line(aes(x = Line_x, y = Line_y, group = 1), size = 1, color = 'red', linetype = "dashed") +
    theme_classic() + labs(x = "", y = "") +
    theme(axis.text=element_text(size=50, color='black'), aspect.ratio = 1) +
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(limits = c(-0.5, 0.5), breaks = c(-0.3, 0, 0.3), labels = c('-0.3', '0', '0.3'))
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/SpinTestDensity_EFPredictionWeights_Myelin.pdf', width = 17, height = 15, dpi = 600, units = "cm");

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
  # Plot for permutation distribution
PermutationData = data.frame(x = t(Perm_Corr_Scaling));
PermutationData$Line_x = as.numeric(matrix(0.21, 1, 1000));
PermutationData$Line_y = as.numeric(seq(0,170,length.out=1000));
ggplot(PermutationData) +
    geom_histogram(aes(x = x), bins = 30, color = "#999999", fill = "#999999") +
    #geom_point(aes(x = Actual_Corr, y = 0), size=3) +
    geom_line(aes(x = Line_x, y = Line_y, group = 1), size = 1, color = 'red', linetype = "dashed") +
    theme_classic() + labs(x = "", y = "") +
    theme(axis.text=element_text(size=50, color='black'), aspect.ratio = 1) +
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(limits = c(-0.5, 0.5), breaks = c(-0.3, 0, 0.3), labels = c('-0.3', '0', '0.3'))
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/SpinTestDensity_EFPredictionWeights_Scaling.pdf', width = 17, height = 15, dpi = 600, units = "cm");

# CognitionWeights vs MeanCBF
Index = which(Data_Mat$MeanCBF.All.NoMedialWall >= 27);
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
  # Plot for permutation distribution
PermutationData = data.frame(x = t(Perm_Corr_CBF));
PermutationData$Line_x = as.numeric(matrix(0.18, 1, 1000));
PermutationData$Line_y = as.numeric(seq(0,140,length.out=1000));
ggplot(PermutationData) +
    geom_histogram(aes(x = x), bins = 30, color = "#999999", fill = "#999999") +
    #geom_point(aes(x = Actual_Corr, y = 0), size=3) +
    geom_line(aes(x = Line_x, y = Line_y, group = 1), size = 1, color = 'red', linetype = "dashed") +
    theme_classic() + labs(x = "", y = "") +
    theme(axis.text=element_text(size=50, color='black'), aspect.ratio = 1) +
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(limits = c(-0.5, 0.5), breaks = c(-0.3, 0, 0.3), labels = c('-0.3', '0', '0.3'))
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/SpinTestDensity_EFPredictionWeights_MeanCBF.pdf', width = 17, height = 15, dpi = 600, units = "cm");
