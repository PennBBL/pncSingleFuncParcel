
library('R.matlab');
library('mgcv');
library('matrixStats');
library('ggplot2')

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

# Using 7 colors scheme for bar plot
# bar plot for age effects 
data <- data.frame(AgeEffects_Z = as.numeric(Gam_Z_Vector_System));
data$EffectRank <- rank(data$AgeEffects_Z);
Fig <- ggplot(data, aes(EffectRank, AgeEffects_Z)) +
            geom_bar(stat = "identity", fill=c("#7499C2", "#00A131", 
            "#E76178", "#E76178", "#AF33AD", "#AF33AD", "#F5BA2E",
            "#F5BA2E", "#E76178", "#E443FF", "#F5BA2E", "#00A131", 
            "#7499C2", "#00A131", "#F5BA2E", "#7499C2", "#EBE297"), width = 0.8);
Fig <- Fig + labs(x = "", y = "Age Effect (Z)") + theme_classic()
Fig <- Fig + theme(axis.text.x = element_text(size= 17.5, color = "black"), axis.text.y = element_text(size= 24, color = "black"), axis.title=element_text(size = 26))
Fig + theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
             scale_x_discrete(limits = c("Network 2 (Motor)", "Network 13 (DA)", 
             "Network 3 (DM)", "Network 1 (DM)", "Network 6 (Visual)", 
             "Network 7 (Visual)", "Network 10 (FP)", "Network 17 (FP)", 
             "Network 12 (DM)", "Network 11 (VA)", "Network 14 (FP)", 
             "Network 8 (DA)", "Network 16 (Motor)", "Network 15 (DA)",
             "Network 5 (FP)", "Network 9 (Motor)", "Network 4 (Limbic)"));
# bar plot for cognition effects
data <- data.frame(AgeEffects_Z_Cognition = as.numeric(Gam_Z_Cognition_Vector_System));
data$EffectRank <- rank(data$AgeEffects_Z_Cognition);
Fig <- ggplot(data, aes(EffectRank, AgeEffects_Z_Cognition)) +
            geom_bar(stat = "identity", fill=c("#AF33AD", "#E76178",
            "#EBE297", "#E76178", "#F5BA2E", "#7499C2", "#7499C2", 
            "#00A131", "#AF33AD", "#E76178", "#00A131", "#7499C2", 
            "#F5BA2E", "#E443FF", "#00A131", "#F5BA2E", "#F5BA2E"), width = 0.8);
Fig <- Fig + labs(x = "", y = "Cognition Effect (Z)") + theme_classic()
Fig <- Fig + theme(axis.text.x = element_text(size= 17.5, color = "black"), axis.text.y = element_text(size= 24, color = "black"), axis.title=element_text(size = 26))
Fig + theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
             scale_x_discrete(limits = c("Network 6 (Visual)", "Network 3 (DM)",
             "Network 4 (Limbic)", "Network 1 (DM)", "Network 14 (FP)", 
             "Network 2 (Motor)", "Network 16 (Motor)", "Network 13 (DA)",
             "Network 7 (Visual)", "Network 12 (DM)", "Network 15 (DA)", 
             "Network 9 (Motor)", "Network 17 (FP)", "Network 11 (VA)",
             "Network 8 (DA)", "Network 10 (FP)", "Network 5 (FP)"));
