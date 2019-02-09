
library('R.matlab');
library('mgcv');
library('matrixStats');
library('visreg');

ReplicationFolder <- '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
Behavior <- read.csv(paste0(ReplicationFolder, '/data/n713_Behavior_20181219.csv'));
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
ARI_Individual_Group_Kong_File <- paste0(ReplicationFolder, '/results/ARI/ARI_Individual_Group_Kong.mat');
ARI_Individual_Group_Kong_Mat <- readMat(ARI_Individual_Group_Kong_File);
ARI_Individual_Group_Kong_Data <- data.frame(BBLID = as.numeric(ARI_Individual_Group_Kong_Mat$BBLID));
ARI_Individual_Group_Kong_Data$ARI_Individual_Group_Kong <- as.numeric(ARI_Individual_Group_Kong_Mat$ARI.Individual.Group);
Behavior_New <- merge(Behavior_New, ARI_Individual_Group_Kong_Data, by = "BBLID", sort = FALSE);

# Age and cognition effect of network size
Gam_Analysis <- gam(ARI_Individual_Group_Kong ~ s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
visreg(Gam_Analysis, 'AgeYears');
Gam_Analysis_Cognition <- gam(ARI_Individual_Group_Kong ~ F1_Exec_Comp_Res_Accuracy + s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
visreg(Gam_Analysis_Cognition, 'F1_Exec_Comp_Res_Accuracy');
