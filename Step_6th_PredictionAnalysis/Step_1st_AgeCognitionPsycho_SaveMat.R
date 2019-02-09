
library(R.matlab);
library(mgcv);
library(visreg);
library(ggplot2);

ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
###############################################
# Import demographics, cognition and strength #
###############################################
# Demographics, motion
AllInfo <- read.csv(paste0(ReplicationFolder, '/data/n713_Behavior_20181219.csv'));
BBLID <- AllInfo$bblid;
AgeYears <- AllInfo$ageAtScan1/12;
Sex <- AllInfo$sex;
Motion_Rest <- AllInfo$restRelMeanRMSMotion;
Motion_NBack <- AllInfo$nbackRelMeanRMSMotion;
Motion_Emotion <- AllInfo$idemoRelMeanRMSMotion;
Motion <- (Motion_Rest + Motion_NBack + Motion_Emotion)/3;
F1_Exec_Comp_Res_Accuracy <- AllInfo$F1_Exec_Comp_Res_Accuracy;

dir.create(paste0(ReplicationFolder, '/results/PredictionAnalysis'));
writeMat(paste0(ReplicationFolder, '/results/PredictionAnalysis/Behavior_713.mat'), 
    BBLID = BBLID, AgeYears = AgeYears, Sex = Sex, Motion = Motion,
    F1_Exec_Comp_Res_Accuracy = F1_Exec_Comp_Res_Accuracy);

