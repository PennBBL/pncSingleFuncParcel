
library('R.matlab');
library('mgcv');
library('matrixStats');
library('visreg');
library('ggplot2');

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
Corr_Individual_Group_Hongming_File <- paste0(ReplicationFolder, '/results/ARI/Corr_Individual_Group_LoadingHongming.mat');
Corr_Individual_Group_Hongming_Mat <- readMat(Corr_Individual_Group_Hongming_File);
Corr_Individual_Group_Hongming_Data <- data.frame(BBLID = as.numeric(Corr_Individual_Group_Hongming_Mat$BBLID));
Corr_Individual_Group_Hongming_Data$Corr_Individual_Group_Hongming <- as.numeric(Corr_Individual_Group_Hongming_Mat$Corr.Individual.Group);
Behavior_New <- merge(Behavior_New, Corr_Individual_Group_Hongming_Data, by = "BBLID", sort = FALSE);

# Age and cognition effect of network size
Gam_Analysis <- gam(Corr_Individual_Group_Hongming ~ s(AgeYears, k=4) + Sex_factor + TBV + Motion, method = "REML", data = Behavior_New);
plotdata <- visreg(Gam_Analysis, 'AgeYears', type = "conditional", plot = FALSE);
smooths <- data.frame(Variable = plotdata$meta$x,
                      x = plotdata$fit[[plotdata$meta$x]],
                      smooth = plotdata$fit$visregFit,
                      lower = plotdata$fit$visregLwr,
                      upper = plotdata$fit$visregUpr);
predicts <- data.frame(Variable = "dim1",
                      x = plotdata$res$AgeYears,
                      y = plotdata$res$visregRes)

Fig <- ggplot() +
       geom_point(data = predicts, aes(x, y), colour = '#000000', size = 1.8) +
       geom_line(data = smooths, aes(x = x, y = smooth), colour = '#000000', size = 1.5) +
       geom_ribbon(data = smooths, aes(x = x, ymin = lower, ymax = upper, fill = "0"), alpha = 0.15) + 
       theme_classic() + theme(axis.text=element_text(size=32, color='black'), axis.title=element_text(size=32)) +
       scale_y_continuous(limits = c(0.35, 0.58), breaks = c(0.35, 0.45, 0.55)) +
       scale_x_continuous(limits = c(8, 23), breaks = c(8:23)) + 
       #geom_point(color = '#000000', size = 1.5) +
       xlab('AgeYears') + ylab('Corr (individual vs. group)')
Fig
#ggsave(paste(WorkFolder, '/AgeEffect_WholeBrainLevel_Scatter.tiff', sep = ''), width = 17, height = 15, dpi = 300, units = "cm");

Gam_Analysis_Cognition <- gam(Corr_Individual_Group_Hongming ~ F1_Exec_Comp_Res_Accuracy + s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
visreg(Gam_Analysis_Cognition, 'F1_Exec_Comp_Res_Accuracy');
visreg(Gam_Analysis_Cognition, 'AgeYears');
