
library(R.matlab)
library(ggplot2)

PredictionFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/PredictionAnalysis';

# Age prediction
AgePrediction_ResFolder = paste0(PredictionFolder, '/AtlasLoading/2Fold_Sort_Age');
# Fold 0
Prediction_Fold0 = readMat(paste0(AgePrediction_ResFolder, '/2Fold_Sort_Fold0_Specificity_Sig_Age.mat'));
# Corr
Corr_Fold0_Rand = Prediction_Fold0$ParCorr.Rand.Fold0;
PermutationData = data.frame(x = t(Corr_Fold0_Rand));
PermutationData$Line_x = as.numeric(matrix(0.71, 1, 1000));
PermutationData$Line_y = as.numeric(seq(0,157,length.out=1000));
ggplot(PermutationData) +
    geom_histogram(aes(x = x), bins = 30, color = "#7F7F7F", fill = "#7F7F7F") +
    geom_line(aes(x = Line_x, y = Line_y, group = 1), size = 1, color = 'red', linetype = "dashed") +
    theme_classic() + labs(x = "", y = "") +
    theme(axis.text=element_text(size=50, color='black'), aspect.ratio = 1) +
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(limits = c(-0.28, 0.73), breaks = c(-0.25, 0, 0.25, 0.71), labels = c('-0.25', '0', '0.25', '0.71'))
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/Permutation_Age_Corr_Fold0.tiff', width = 17, height = 15, dpi = 600, units = "cm");
# MAE
MAE_Fold0_Rand = Prediction_Fold0$MAE.Rand.Fold0;

# Fold 1
Prediction_Fold1 = readMat(paste0(AgePrediction_ResFolder, '/2Fold_Sort_Fold1_Specificity_Sig_Age.mat'));
# Corr
Corr_Fold1_Rand = Prediction_Fold1$ParCorr.Rand.Fold1;
PermutationData = data.frame(x = t(Corr_Fold1_Rand));
PermutationData$Line_x = as.numeric(matrix(0.74, 1, 1000));
PermutationData$Line_y = as.numeric(seq(0,157,length.out=1000));
ggplot(PermutationData) +
    geom_histogram(aes(x = x), bins = 30, color = "#000000", fill = "#000000") +
    geom_line(aes(x = Line_x, y = Line_y, group = 1), size = 1, color = 'red', linetype = "dashed") +
    theme_classic() + labs(x = "", y = "") +
    theme(axis.text=element_text(size=50, color='black'), aspect.ratio = 1) +
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(limits = c(-0.28, 0.76), breaks = c(-0.25, 0, 0.25, 0.74), labels = c('-0.25', '0', '0.25', '0.74'))
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/Permutation_Age_Corr_Fold1.tiff', width = 17, height = 15, dpi = 600, units = "cm");
# MAE
MAE_Fold1_Rand = Prediction_Fold1$MAE.


# EF prediction
EFPrediction_ResFolder = paste0(PredictionFolder, '/AtlasLoading/2Fold_Sort_EFAccuracy');
# Fold 0
Prediction_Fold0 = readMat(paste0(EFPrediction_ResFolder, '/2Fold_Sort_Fold0_Specificity_Sig_EFAccuracy.mat'));
# Corr
Corr_Fold0_Rand = Prediction_Fold0$ParCorr.Rand.Fold0;
PermutationData = data.frame(x = t(Corr_Fold0_Rand));
PermutationData$Line_x = as.numeric(matrix(0.47, 1, 1000));
PermutationData$Line_y = as.numeric(seq(0,145,length.out=1000));
ggplot(PermutationData) +
    geom_histogram(aes(x = x), bins = 30, color = "#000000", fill = "#000000") +
    geom_line(aes(x = Line_x, y = Line_y, group = 1), size = 1, color = 'red', linetype = "dashed") +
    theme_classic() + labs(x = "", y = "") +
    theme(axis.text=element_text(size=50, color='black'), aspect.ratio = 1) +
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(limits = c(-0.28, 0.50), breaks = c(-0.2, 0, 0.2, 0.47), labels = c('-0.2', '0', '0.2', '0.47'))
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/Permutation_EFAccuracy_Corr_Fold0.tiff', width = 17, height = 15, dpi = 600, units = "cm");
# MAE
MAE_Fold0_Rand = Prediction_Fold0$MAE.Rand.Fold0;

# Fold 1
Prediction_Fold1 = readMat(paste0(EFPrediction_ResFolder, '/2Fold_Sort_Fold1_Specificity_Sig_EFAccuracy.mat'));
# Corr
Corr_Fold1_Rand = Prediction_Fold1$ParCorr.Rand.Fold1;
PermutationData = data.frame(x = t(Corr_Fold1_Rand));
PermutationData$Line_x = as.numeric(matrix(0.43, 1, 1000));
PermutationData$Line_y = as.numeric(seq(0,145,length.out=1000));
ggplot(PermutationData) +
    geom_histogram(aes(x = x), bins = 30, color = "#7F7F7F", fill = "#7F7F7F") +
    geom_line(aes(x = Line_x, y = Line_y, group = 1), size = 1, color = 'red', linetype = "dashed") +
    theme_classic() + labs(x = "", y = "") +
    theme(axis.text=element_text(size=50, color='black'), aspect.ratio = 1) +
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_continuous(limits = c(-0.28, 0.46), breaks = c(-0.2, 0, 0.2, 0.43), labels = c('-0.2', '0', '0.2', '0.43'))
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/Permutation_EFAccuracy_Corr_Fold1.tiff', width = 17, height = 15, dpi = 600, units = "cm");
# MAE
MAE_Fold1_Rand = Prediction_Fold1$MAE.Rand.Fold1;


