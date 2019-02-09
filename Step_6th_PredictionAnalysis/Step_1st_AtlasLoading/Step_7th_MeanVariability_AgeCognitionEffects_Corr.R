
library(R.matlab)
library(ggplot2)

ResultsFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results';
VariabilityFolder = paste0(ResultsFolder, '/SingleParcellation/SingleAtlas_Analysis/Variability_Visualize');
PredictionFolder = paste0(ResultsFolder, '/PredictionAnalysis/AtlasLoading');

Variability_Mat = readMat(paste0(VariabilityFolder, '/VariabilityLoading_Median_17SystemMean.mat'));
Variability_Data = Variability_Mat$VariabilityLoading.Median.17SystemMean.NoMedialWall;

Prediction_Age_Results = readMat(paste0(PredictionFolder, '/Weight_Age/w_Brain_Age_abs_sum.mat'));
AgeWeights_Mean = Prediction_Age_Results$w.Brain.Age.abs.sum;
cor.test(Variability_Data, AgeWeights_Mean);

Prediction_Cognition_Results = readMat(paste0(PredictionFolder, '/Weight_EFAccuracy/w_Brain_EFAccuracy_abs_sum.mat'));
CognitionWeights_Mean = Prediction_Cognition_Results$w.Brain.EFAccuracy.abs.sum;
cor.test(Variability_Data, CognitionWeights_Mean);

# plot the highest correlation
# Correlation between mean variability and mean absolute effects
data_Age = data.frame(Variability_Data = as.numeric(t(Variability_Data)));
data_Age$AgeWeights_Mean = as.numeric(AgeWeights_Mean);
ggplot(data = data_Age, aes(Variability_Data, AgeWeights_Mean)) +
         geom_point() +
         geom_smooth(method = lm) +
         theme_classic() + labs(x = "Mean variability of 17 networks", y = "Mean absolute age effects") +
         theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
         scale_fill_manual("", values = "grey12");
# Cognition
data_Cognition = data.frame(Variability_Data = as.numeric(t(Variability_Data)));
data_Cognition$CognitionWeights_Mean = as.numeric(CognitionWeights_Mean);
ggplot(data = data_Cognition, aes(Variability_Data, CognitionWeights_Mean)) +
        geom_point() +
        geom_smooth(method = lm) +
        theme_classic() + labs(x = "Mean variability of 17 networks", y = "Mean absolute cognition effects") +
        theme(axis.text=element_text(size=25, color='black'), axis.title=element_text(size=30)) +
        scale_fill_manual("", values = "grey12");

