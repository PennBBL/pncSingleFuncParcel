
clear

ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
AgePrediction_ResFolder = [ReplicationFolder '/results/PredictionAnalysis/AtlasLoading/2Fold_Age_RandomCV'];
Behavior = load([ReplicationFolder '/results/PredictionAnalysis/Behavior_713.mat']);

for i = 0:19
    Prediction_Fold0 = load([AgePrediction_ResFolder '/Time_' num2str(i) '/Fold_0_Score.mat']);
    MAE_Actual_Fold0 = Prediction_Fold0.MAE;
    Index_Fold0 = Prediction_Fold0.Index + 1;
    Prediction_Fold1 = load([AgePrediction_ResFolder '/Time_' num2str(i) '/Fold_1_Score.mat']);
    MAE_Actual_Fold1 = Prediction_Fold1.MAE;
    Index_Fold1 = Prediction_Fold1.Index + 1;

    % Fold 0
    Age_Fold0 = Behavior.AgeYears(Index_Fold0);
    Sex_Fold0 = Behavior.Sex(Index_Fold0);
    Motion_Fold0 = Behavior.Motion(Index_Fold0);
    % Fold 1
    Age_Fold1 = Behavior.AgeYears(Index_Fold1);
    Sex_Fold1 = Behavior.Sex(Index_Fold1);
    Motion_Fold1 = Behavior.Motion(Index_Fold1);

    [ParCorr_Actual_Fold0, ~] = partialcorr(Prediction_Fold0.Predict_Score', Age_Fold0, double([Sex_Fold0 Motion_Fold0]));
    [ParCorr_Actual_Fold1, ~] = partialcorr(Prediction_Fold1.Predict_Score', Age_Fold1, double([Sex_Fold1 Motion_Fold1]));
    
    ParCorr_Actual(i + 1) = mean([ParCorr_Actual_Fold0, ParCorr_Actual_Fold1]);
    MAE_Actual(i + 1) = mean([MAE_Actual_Fold0, MAE_Actual_Fold1]);
end
ParCorr_Actual_Random_Mean = mean(ParCorr_Actual);
MAE_Actual_Random_Mean = mean(MAE_Actual);

save([AgePrediction_ResFolder '/2Fold_Random_ParCorr_MAE.mat'], 'ParCorr_Actual_Random_Mean', 'MAE_Actual_Random_Mean');
