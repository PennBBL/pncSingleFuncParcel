
library('R.matlab');
library('mgcv');
library('ggplot2');

ProjectFolder <- '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
Behavior <- read.csv(paste0(ProjectFolder, '/data/n713_Behavior_20181219.csv'));
Behavior_New <- data.frame(BBLID = Behavior$bblid);
Behavior_New$AgeYears <- as.numeric(Behavior$ageAtScan1/12);
Motion <- (Behavior$restRelMeanRMSMotion + Behavior$nbackRelMeanRMSMotion + Behavior$idemoRelMeanRMSMotion)/3;
Behavior_New$Motion <- as.numeric(Motion);
Behavior_New$Sex_factor <- as.factor(Behavior$sex);
Behavior_New$F1_Exec_Comp_Res_Accuracy <- as.numeric(Behavior$F1_Exec_Comp_Res_Accuracy);
AtlasLoading_Folder <- paste0(ProjectFolder, '/results/SingleParcellation/SingleAtlas_Analysis/FinalAtlasLoading');

SubjectsQuantity = 713;
FeaturesQuantity = 18715;
# Extract Loading
Data_Size <- SubjectsQuantity * FeaturesQuantity * 17;
Data_All <- matrix(0, 1, Data_Size);
dim(Data_All) <- c(SubjectsQuantity, FeaturesQuantity, 17);
BBLID <- Behavior_New$BBLID;
for (i in c(1:length(BBLID)))
{
  print(i);
  AtlasLoading_File <- paste0(AtlasLoading_Folder, '/', as.character(BBLID[i]), '.mat');
  Data <- readMat(AtlasLoading_File);
  Data_All[i,,] <- Data$sbj.AtlasLoading.NoMedialWall;
}

# Age effect
Gam_P_Vector_Age_WholeNetworkSum <- matrix(0, 1, 16);
Gam_Z_Vector_Age_WholeNetworkSum <- matrix(0, 1, 16);
Gam_P_Vector_Cognition_WholeNetworkSum <- matrix(0, 1, 16);
Gam_Z_Vector_Cognition_WholeNetworkSum <- matrix(0, 1, 16);
for (i in 1:16)
{
  print(i);
  Data_I = Data_All[,,i];
  WholeNetworkSum = as.numeric(rowSums(Data_I));
  # Effects of network size 
  Gam_Analysis_WholeNetworkSum <- gam(WholeNetworkSum ~ s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
  Gam_P_Vector_Age_WholeNetworkSum[i] = summary(Gam_Analysis_WholeNetworkSum)$s.table[4];
  Gam_Z_Vector_Age_WholeNetworkSum[i] <- qnorm(Gam_P_Vector_Age_WholeNetworkSum[i] / 2, lower.tail = FALSE);
  lm_Analysis_WholeNetworkSum <- lm(WholeNetworkSum ~ AgeYears + Sex_factor + Motion, data = Behavior_New);
  Age_T <- summary(lm_Analysis_WholeNetworkSum)$coefficients[2, 3];
  if (Age_T < 0) {
    Gam_Z_Vector_Age_WholeNetworkSum[i] <- -Gam_Z_Vector_Age_WholeNetworkSum[i];
  }
  print(paste0('Age effect: P Value is: ', as.character(summary(Gam_Analysis_WholeNetworkSum)$s.table[4]))) 

  Gam_Analysis_Cognition_WholeNetworkSum <- gam(WholeNetworkSum ~ F1_Exec_Comp_Res_Accuracy + s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
  Gam_P_Vector_Cognition_WholeNetworkSum[i] = summary(Gam_Analysis_Cognition_WholeNetworkSum)$p.table[2,4];
  Gam_Z_Vector_Cognition_WholeNetworkSum[i] = summary(Gam_Analysis_Cognition_WholeNetworkSum)$p.table[2,3];
  print(paste0('Cognition effect: P Value is: ', as.character(summary(Gam_Analysis_Cognition_WholeNetworkSum)$p.table[2,4])));
}
Gam_P_Vector_Age_WholeNetworkSum_FDR = p.adjust(Gam_P_Vector_Age_WholeNetworkSum, 'fdr');
Gam_P_Vector_Cognition_WholeNetworkSum_FDR = p.adjust(Gam_P_Vector_Cognition_WholeNetworkSum, 'fdr');
# Scatter plots for network 4 (limbic) and network 5 (FP)
# Network 4
Data_I = Data_All[,,4];
WholeNetworkSum = as.numeric(rowSums(Data_I));
Gam_Analysis_WholeNetworkSum <- gam(WholeNetworkSum ~ s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
Fig <- visreg(Gam_Analysis_WholeNetworkSum, "AgeYears", xlab = "Age (Years)", ylab = "Limbic network", line.par = list(col = '#EBE297'), gg = TRUE)
Fig <- Fig + theme_classic() + theme(axis.text=element_text(size=32, color='black'), text = element_text(size=32));
Fig <- Fig + scale_y_continuous(limits = c(1100, 1900), breaks = c(1100, 1400, 1700))
Fig + geom_point(color = '#EBE297', size = 1.5)
# Network 5
Data_I = Data_All[,,5];
WholeNetworkSum = as.numeric(rowSums(Data_I));
Gam_Analysis_WholeNetworkSum <- gam(WholeNetworkSum ~ s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
Fig <- visreg(Gam_Analysis_WholeNetworkSum, "AgeYears", xlab = "Age (Years)", ylab = "FP network", line.par = list(col = '#F5BA2E'), gg = TRUE)
Fig <- Fig + theme_classic() + theme(axis.text=element_text(size=32, color='black'), text = element_text(size=32));
Fig <- Fig + scale_y_continuous(limits = c(900, 1800), breaks = c(900, 1200, 1500, 1800))
Fig + geom_point(color = '#F5BA2E', size = 1.5)

# Using 7 colors scheme for bar plot
# bar plot for age effects 
data <- data.frame(AgeEffects_Z = as.numeric(Gam_Z_Vector_Age_WholeNetworkSum));
data$EffectRank <- rank(data$AgeEffects_Z);
BorderColor <- c("#AF33AD", "#E76178", "#F5BA2E", "#E76178", "#7499C2", "#F5BA2E",
                 "#AF33AD", "#00A131", "#F5BA2E", "#00A131", "#7499C2", "#E443FF",
                 "#E443FF", "#E76178", "#7499C2", "#F5BA2E");
LineType <- c("dashed", "dashed", "dashed", "dashed", "dashed", "dashed",
              "dashed", "dashed", "dashed", "dashed", "dashed", "dashed",
              "dashed", "dashed", "dashed", "solid");
Fig <- ggplot(data, aes(EffectRank, AgeEffects_Z)) +
       geom_bar(stat = "identity", fill=c("#FFFFFF", "#FFFFFF", 
            "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF",
            "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", 
            "#FFFFFF", "#FFFFFF", "#FFFFFF", "#F5BA2E"), 
            colour = BorderColor, linetype = LineType, width = 0.8) +
       labs(x = "Networks", y = "Age Effect (Z)") + theme_classic() + 
       theme(axis.text.x = element_text(size = 17.5, color = BorderColor),
            axis.text.y = element_text(size = 24, color = "black"), 
            axis.title=element_text(size = 26)) +
       theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
            scale_x_discrete(limits = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
                 13, 14, 15, 16), 
                 labels = c("6", "3", "17", "1", "2", "10", "7", 
                 "13", "14", "15", "9", "8", "11", "12", "16", "5")) + 
        scale_y_continuous(limits = c(-3.2, 5.5), breaks = c(-2.5, 0, 2.5, 5));
Fig
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/NetworkSize_Loading_AgeEffects.tiff', width = 17, height = 15, dpi = 600, units = "cm");
# bar plot for cognition effects
data <- data.frame(AgeEffects_Z_Cognition = as.numeric(Gam_Z_Vector_Cognition_WholeNetworkSum));
data$EffectRank <- rank(data$AgeEffects_Z_Cognition);
BorderColor <- c("#7499C2", "#E76178", "#AF33AD", "#AF33AD", "#00A131", "#7499C2", 
                 "#F5BA2E", "#F5BA2E", "#E76178", "#00A131", "#E443FF", "#7499C2", 
                 "#E76178", "#E443FF", "#F5BA2E", "#F5BA2E");
LineType <- c("solid", "solid", "dashed", "dashed", "dashed", "dashed",
              "dashed", "dashed", "dashed", "dashed", "dashed", "dashed",
              "dashed", "solid", "solid", "solid");
Fig <- ggplot(data, aes(EffectRank, AgeEffects_Z_Cognition)) +
            geom_bar(stat = "identity", fill=c("#7499C2", "#E76178",
            "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF",
            "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF",
            "#FFFFFF", "#E443FF", "#F5BA2E", "#F5BA2E"), 
            colour = BorderColor, linetype = LineType, width = 0.8) + 
       labs(x = "Networks", y = "Cognition Effect (Z)") + theme_classic() +
       theme(axis.text.x = element_text(size= 17.5, color = BorderColor), 
            axis.text.y = element_text(size= 24, color = "black"), 
            axis.title=element_text(size = 26)) +
       theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
             scale_x_discrete(limits = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
                 13, 14, 15, 16),
                 labels = c("16", "3", "6", "7", "13", "2", "14", "17", 
                 "1", "15", "11", "9", "12", "8", "10", "5")) + 
       scale_y_continuous(limits = c(-3.2, 5.5), breaks = c(-2.5, 0, 2.5, 5));
Fig
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/NetworkSize_Loading_EFEffects.tiff', width = 17, height = 15, dpi = 600, units = "cm");
# Scatter plots for network 5 (FP) and network 10 (FP)
# Network 5
Data_I = Data_All[,,5];
WholeNetworkSum = as.numeric(rowSums(Data_I));
Gam_Analysis_Cognition_WholeNetworkSum <- gam(WholeNetworkSum ~ F1_Exec_Comp_Res_Accuracy + s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
Fig <- visreg(Gam_Analysis_Cognition_WholeNetworkSum, "F1_Exec_Comp_Res_Accuracy", xlab = "Executive Performance", ylab = "Network 5 (Frontoparietal)", line.par = list(col = '#F5BA2E'), gg = TRUE)
Fig <- Fig + theme_classic() + theme(axis.text=element_text(size=32, color='black'), text = element_text(size=32));
Fig <- Fig + scale_y_continuous(limits = c(900, 1800), breaks = c(900, 1200, 1500, 1800))
Fig + geom_point(color = '#F5BA2E', size = 1.5)
# Network 10
Data_I = Data_All[,,10];
WholeNetworkSum = as.numeric(rowSums(Data_I));
Gam_Analysis_Cognition_WholeNetworkSum <- gam(WholeNetworkSum ~ F1_Exec_Comp_Res_Accuracy + s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
Fig <- visreg(Gam_Analysis_Cognition_WholeNetworkSum, "F1_Exec_Comp_Res_Accuracy", xlab = "Executive Performance", ylab = "Network 5 (Frontoparietal)", line.par = list(col = '#F5BA2E'), gg = TRUE)
Fig <- Fig + theme_classic() + theme(axis.text=element_text(size=32, color='black'), text = element_text(size=32));
Fig <- Fig + scale_y_continuous(limits = c(1230, 2150), breaks = c(1300, 1600, 1900))
Fig + geom_point(color = '#F5BA2E', size = 1.5)
