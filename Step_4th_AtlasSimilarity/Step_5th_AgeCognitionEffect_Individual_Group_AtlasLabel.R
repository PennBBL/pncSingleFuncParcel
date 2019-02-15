
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
ARI_Individual_Group_Hongming_File <- paste0(ProjectFolder, '/results/AtlasSimilarity/ARI_Individual_Group_Hongming_System.mat');
ARI_Individual_Group_Hongming_Mat <- readMat(ARI_Individual_Group_Hongming_File);

Gam_P_Vector_Age <- matrix(0, 1, 17);
Gam_Z_Vector_Age <- matrix(0, 1, 17);
Gam_P_Vector_EF <- matrix(0, 1, 17);
Gam_Z_Vector_EF <- matrix(0, 1, 17);
for (i in c(1:17))
{
  tmp_Data <- data.frame(BBLID = as.numeric(ARI_Individual_Group_Hongming_Mat$BBLID));
  tmp_Data$ARI_Individual_Group_Hongming_SystemI <- as.numeric(ARI_Individual_Group_Hongming_Mat$ARI.Individual.Group.System[,i]);
  Data_All <- Behavior_New;
  Data_All <- merge(Data_All, tmp_Data, by = "BBLID", sort = FALSE);
  # Age and cognition effect of network size
  Gam_Analysis <- gam(ARI_Individual_Group_Hongming_SystemI ~ s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Data_All);
  #visreg(Gam_Analysis, 'AgeYears');
  Gam_P_Vector_Age[i] <- summary(Gam_Analysis)$s.table[, 4];
  Gam_Z_Vector_Age[i] <- qnorm(Gam_P_Vector_Age[i] / 2, lower.tail = FALSE);
  lm_Analysis <- lm(ARI_Individual_Group_Hongming_SystemI ~ AgeYears + Sex_factor + Motion, data = Data_All);
  Age_T <- summary(lm_Analysis)$coefficients[2, 3];
  if (Age_T < 0) {
    Gam_Z_Vector_Age[i] <- -Gam_Z_Vector_Age[i];
  }

  Gam_Analysis_EF <- gam(ARI_Individual_Group_Hongming_SystemI ~ F1_Exec_Comp_Res_Accuracy + s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Data_All);
#  visreg(Gam_Analysis_EF, 'F1_Exec_Comp_Res_Accuracy');
  Gam_P_Vector_EF[i] <- summary(Gam_Analysis_EF)$p.table[2, 4];
  Gam_Z_Vector_EF[i] <- summary(Gam_Analysis_EF)$p.table[2, 3];
  rm(tmp_Data);
}
Gam_P_FDR_Vector_Age <- p.adjust(Gam_P_Vector_Age, "fdr");
Gam_P_FDR_Vector_EF <- p.adjust(Gam_P_Vector_EF, "fdr");

