
library('R.matlab');
library('mgcv');
library('matrixStats');

ProjectFolder <- '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
Behavior <- read.csv(paste0(ProjectFolder, '/data/n713_Behavior_20181219.csv'));
Behavior_New <- data.frame(BBLID = Behavior$bblid);
Behavior_New$AgeYears <- as.numeric(Behavior$ageAtScan1/12);
Motion <- (Behavior$restRelMeanRMSMotion + Behavior$nbackRelMeanRMSMotion + Behavior$idemoRelMeanRMSMotion)/3;
Behavior_New$Motion <- as.numeric(Motion);
Behavior_New$Sex_factor <- as.factor(Behavior$sex);
Behavior_New$F1_Exec_Comp_Res_Accuracy <- as.numeric(Behavior$F1_Exec_Comp_Res_Accuracy);
AtlasLabel_Folder <- paste0(ProjectFolder, '/results/SingleParcellation/SingleAtlas_Analysis/FinalAtlasLabel');

SubjectsQuantity = 713;
FeaturesQuantity = 18715;
# Extract Probability
Data_Size <- SubjectsQuantity * FeaturesQuantity;
Data_All <- matrix(0, 1, Data_Size);
dim(Data_All) <- c(SubjectsQuantity, FeaturesQuantity);
Data_All_Size <- matrix(0, 1, SubjectsQuantity * 17);
dim(Data_All_Size) <- c(SubjectsQuantity, 17);
BBLID <- Behavior_New$BBLID;
for (i in c(1:length(BBLID)))
{
  print(i)
  AtlasLabel_File <- paste0(AtlasLabel_Folder, '/', as.character(BBLID[i]), '.mat');
  Data <- readMat(AtlasLabel_File);
  for (j in 1:17) {
    Cmd_Str = paste0('Data_All_Size[i,', as.character(j), ']<-length(which(Data$sbj.AtlasLabel.NoMedialWall == ', as.character(j), '));');
    eval(parse(text=Cmd_Str));
  }
}

# Age and cognition effect of network size
Gam_P_Vector_System <- matrix(0, 1, 17);
Gam_Z_Vector_System <- matrix(0, 1, 17);
Gam_P_Cognition_Vector_System <- matrix(0, 1, 17);
Gam_Z_Cognition_Vector_System <- matrix(0, 1, 17);
for (i in 1:17)
{
  print(i);
  Network_Size = as.numeric(Data_All_Size[, i]);
  Gam_Analysis <- gam(Network_Size ~ s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
  Gam_P_Vector_System[i] <- summary(Gam_Analysis)$s.table[, 4];
  Gam_Z_Vector_System[i] <- qnorm(Gam_P_Vector_System[i] / 2, lower.tail = FALSE);
  lm_Analysis <- lm(Network_Size ~ AgeYears + Sex_factor + Motion, data = Behavior_New);
  Age_T <- summary(lm_Analysis)$coefficients[2, 3];
  if (Age_T < 0) {
    Gam_Z_Vector_System[i] <- -Gam_Z_Vector_System[i];
  }
  print(paste0('Age effect: P Value is: ', as.character(summary(Gam_Analysis)$s.table[4])))
  Gam_Analysis_Cognition <- gam(Network_Size ~ F1_Exec_Comp_Res_Accuracy + s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
  Gam_Z_Cognition_Vector_System[i] <- summary(Gam_Analysis_Cognition)$p.table[2, 3];
  Gam_P_Cognition_Vector_System[i] <- summary(Gam_Analysis_Cognition)$p.table[2, 4];
  print(paste0('Cognition effect: P Value is: ', as.character(summary(Gam_Analysis_Cognition)$p.table[2,4])));
}
Gam_P_FDR_Vector_System <- p.adjust(Gam_P_Vector_System, "fdr");
Gam_P_FDR_Cognition_Vector_System <- p.adjust(Gam_P_Cognition_Vector_System, "fdr");

