
library('R.matlab');
library('mgcv');
library('matrixStats');
library('visreg');
library('ggplot2');

ProjectFolder <- '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
Behavior <- read.csv(paste0(ProjectFolder, '/data/n713_Behavior_20181219.csv'));
Behavior_New <- data.frame(BBLID = Behavior$bblid);
Behavior_New$AgeYears <- as.numeric(Behavior$ageAtScan1/12);
Motion <- (Behavior$restRelMeanRMSMotion + Behavior$nbackRelMeanRMSMotion + Behavior$idemoRelMeanRMSMotion)/3;
Behavior_New$Motion <- as.numeric(Motion);
Behavior_New$restRelMeanRMSMotion <- Behavior$restRelMeanRMSMotion;
Behavior_New$nbackRelMeanRMSMotion <- Behavior$nbackRelMeanRMSMotion;
Behavior_New$idemoRelMeanRMSMotion <- Behavior$idemoRelMeanRMSMotion;
Behavior_New$Sex_factor <- as.factor(Behavior$sex);
Behavior_New$TBV <- as.numeric(Behavior$mprage_antsCT_vol_TBV);
Behavior_New$Handedness <- as.factor(Behavior$handednessv2);
Behavior_New$F1_Exec_Comp_Res_Accuracy <- as.numeric(Behavior$F1_Exec_Comp_Res_Accuracy);
Behavior_New$F3_Executive_Efficiency <- as.numeric(Behavior$F3_Executive_Efficiency);
Corr_Individual_Group_Hongming_File <- paste0(ProjectFolder, '/results/ARI/Corr_Individual_Group_LoadingHongming_System.mat');
Corr_Individual_Group_Hongming_Mat <- readMat(Corr_Individual_Group_Hongming_File);

Gam_P_Vector_Age <- matrix(0, 1, 17);
Gam_Z_Vector_Age <- matrix(0, 1, 17);
Gam_P_Vector_EF <- matrix(0, 1, 17);
Gam_Z_Vector_EF <- matrix(0, 1, 17);
for (i in c(1:17))
{
  tmp_Data <- data.frame(BBLID = as.numeric(Corr_Individual_Group_Hongming_Mat$BBLID));
  tmp_Data$Corr_Individual_Group_Hongming_SystemI <- as.numeric(Corr_Individual_Group_Hongming_Mat$Corr.Individual.Group.System[,i]);
  Data_All <- Behavior_New;
  Data_All <- merge(Data_All, tmp_Data, by = "BBLID", sort = FALSE);
  # Age and cognition effect of network size
  Gam_Analysis <- gam(Corr_Individual_Group_Hongming_SystemI ~ s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Data_All);
  #visreg(Gam_Analysis, 'AgeYears');
  Gam_P_Vector_Age[i] <- summary(Gam_Analysis)$s.table[, 4];
  Gam_Z_Vector_Age[i] <- qnorm(Gam_P_Vector_Age[i] / 2, lower.tail = FALSE);
  lm_Analysis <- lm(Corr_Individual_Group_Hongming_SystemI ~ AgeYears + Sex_factor + Motion, data = Data_All);
  Age_T <- summary(lm_Analysis)$coefficients[2, 3];
  if (Age_T < 0) {
    Gam_Z_Vector_Age[i] <- -Gam_Z_Vector_Age[i];
  }

  Gam_Analysis_EF <- gam(Corr_Individual_Group_Hongming_SystemI ~ F1_Exec_Comp_Res_Accuracy + s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Data_All);
#  visreg(Gam_Analysis_EF, 'F1_Exec_Comp_Res_Accuracy');
  Gam_P_Vector_EF[i] <- summary(Gam_Analysis_EF)$p.table[2, 4];
  Gam_Z_Vector_EF[i] <- summary(Gam_Analysis_EF)$p.table[2, 3];
  rm(tmp_Data);
}
Gam_P_FDR_Vector_Age <- p.adjust(Gam_P_Vector_Age, "fdr");
Gam_P_FDR_Vector_EF <- p.adjust(Gam_P_Vector_EF, "fdr");

# Bar plot for age effects
data <- data.frame(AgeEffects_Z = as.numeric(Gam_Z_Vector_Age));
data$EffectRank <- rank(data$AgeEffects_Z);
Fig <- ggplot(data, aes(EffectRank, AgeEffects_Z)) +
            geom_bar(stat = "identity", fill=c("#7499C2", "#E76178", "#F5BA2E",
            "#AF33AD", "#E443FF", "#00A131", "#AF33AD", "#E76178", "#7499C2",
            "#E76178", "#7499C2", "#7499C2", "#F5BA2E", "#E76178", "#F5BA2E",
            "#AF33AD", "#EBE297"), width=0.8)
Fig <- Fig + labs(x = "", y = "") + theme_classic()
Fig <- Fig + theme(axis.text.x = element_text(size= 17.5, color = "black"), axis.text.y = element_text(size= 24, color = "black"), axis.title=element_text(size = 26))
Fig + theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
             scale_x_discrete(limits = c("Network 5 (Motor)", "Network 1 (DM)", "Network 17 (FP)",
             "Network 15 (Visual)", "Network 10 (VA)", "Network 13 (DA)", "Network 6 (Visual)",
             "Network 3 (DM)", "Network 4 (Motor)", "Network 14 (DM)", "Network 12 (Motor)",
             "Network 11 (Motor)", "Network 2 (FP)", "Network 7 (DM)", "Network 9 (FP)",
             "Network 8 (Visual)", "Network 16 (Limbic)"))

