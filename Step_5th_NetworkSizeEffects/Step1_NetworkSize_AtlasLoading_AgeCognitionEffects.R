
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
Gam_P_Vector_Age_WholeNetworkSum <- matrix(0, 1, 17);
Gam_Z_Vector_Age_WholeNetworkSum <- matrix(0, 1, 17);
Gam_P_Vector_Cognition_WholeNetworkSum <- matrix(0, 1, 17);
Gam_Z_Vector_Cognition_WholeNetworkSum <- matrix(0, 1, 17);
for (i in 1:17)
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

# Using 7 colors scheme for bar plot
# bar plot for age effects 
data <- data.frame(AgeEffects_Z = as.numeric(Gam_Z_Vector_Age_WholeNetworkSum));
data$EffectRank <- rank(data$AgeEffects_Z);
Fig <- ggplot(data, aes(EffectRank, AgeEffects_Z)) +
            geom_bar(stat = "identity", fill=c("#AF33AD", "#E76178", 
            "#F5BA2E", "#E76178", "#7499C2", "#F5BA2E", "#AF33AD",
            "#00A131", "#F5BA2E", "#00A131", "#7499C2", "#00A131", 
            "#E443FF", "#E76178", "#7499C2", "#F5BA2E", "#EBE297"), width = 0.8);
Fig <- Fig + labs(x = "", y = "Age Effect (Z)") + theme_classic()
Fig <- Fig + theme(axis.text.x = element_text(size= 17.5, color = "black"), axis.text.y = element_text(size= 24, color = "black"), axis.title=element_text(size = 26))
Fig + theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
             scale_x_discrete(limits = c("Network 6 (Visual)", "Network 3 (DM)", 
             "Network 17 (FP)", "Network 1 (DM)", "Network 2 (Motor)", "Network 10 (FP)",
             "Network 7 (Visual)", "Network 13 (DA)", "Network 14 (FP)", "Network 15 (DA)",
             "Network 9 (Motor)", "Network 8 (DA)", "Network 11 (VA)", "Network 12 (DM)", 
             "Network 16 (Motor)", "Network 5 (FP)", "Network 4 (Limbic)"));
# bar plot for cognition effects
data <- data.frame(AgeEffects_Z_Cognition = as.numeric(Gam_Z_Vector_Cognition_WholeNetworkSum));
data$EffectRank <- rank(data$AgeEffects_Z_Cognition);
Fig <- ggplot(data, aes(EffectRank, AgeEffects_Z_Cognition)) +
            geom_bar(stat = "identity", fill=c("#7499C2", "#E76178", "#AF33AD",
            "#AF33AD", "#00A131", "#EBE297", "#7499C2", "#F5BA2E",
            "#F5BA2E", "#E76178", "#00A131", "#E443FF", "#7499C2",
            "#E76178", "#00A131", "#F5BA2E", "#F5BA2E"), width = 0.8);
Fig <- Fig + labs(x = "", y = "Cognition Effect (Z)") + theme_classic()
Fig <- Fig + theme(axis.text.x = element_text(size= 17.5, color = "black"), axis.text.y = element_text(size= 24, color = "black"), axis.title=element_text(size = 26))
Fig + theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
             scale_x_discrete(limits = c("Network 16 (Motor)", "Network 3 (DM)", 
             "Network 6 (Visual)", "Network 7 (Visual)", "Network 13 (DA)", 
             "Network 4 (Limbic)", "Network 2 (Motor)", "Network 14 (FP)", 
             "Network 17 (FP)", "Network 1 (DM)", "Network 15 (DA)", 
             "Network 11 (VA)", "Network 9 (Motor)", "Network 12 (DM)", 
             "Network 8 (DA)", "Network 10 (FP)", "Network 5 (FP)"));

