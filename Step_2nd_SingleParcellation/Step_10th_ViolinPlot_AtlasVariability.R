
library(R.matlab)
library(ggplot2);

ResultsFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results';
AtlasFolder = paste0(ResultsFolder, '/SingleParcellation/SingleAtlas_Analysis');
Variability_Visualize_Folder = paste0(AtlasFolder, '/Variability_Visualize');
Variability_Mat = readMat(paste0(Variability_Visualize_Folder, '/VariabilityLoading_Median_17SystemMean.mat'));

AtlasLabel_Mat = readMat(paste0(AtlasFolder, '/Group_AtlasLabel.mat'));

AllData = data.frame(Variability = matrix(0, 18715, 1));
AllData$Label = matrix(0, 18715, 1);
for (i in c(1:18715))
{
  AllData$Variability[i] = Variability_Mat$VariabilityLoading.Median.17SystemMean.NoMedialWall[i];
  AllData$Label[i] = AtlasLabel_Mat$sbj.AtlasLabel.NoMedialWall[i];
}
AllData$Variability = as.numeric(AllData$Variability);
AllData$Label = as.factor(AllData$Label);
ColorScheme = c("#E76178", "#7499C2", "#E76178", "#EBE297",
             "#F5BA2E", "#AF33AD", "#AF33AD", "#E443FF", "#7499C2", "#F5BA2E", "#E443FF",
             "#E76178", "#00A131", "#F5BA2E", "#00A131", "#7499C2", "#F5BA2E");
ColorScheme_XText = c("#AF33AD", "#7499C2", "#AF33AD", "#7499C2", "#7499C2",
             "#EBE297", "#E443FF", "#00A131", "#E76178", "#E76178", "#F5BA2E",
             "#00A131", "#E76178", "#E443FF", "#F5BA2E", "#F5BA2E", "#F5BA2E");
Order = c(7, 2, 6, 9, 16, 4, 11, 15, 3, 12, 17, 13, 1, 8, 5, 10, 14);
ColorScheme_XText_New = ColorScheme_XText;
for (i in c(1:17)) {
  ind = which(Order == i);
  ColorScheme_XText_New[ind] = ColorScheme_XText[i];
}
ggplot(AllData, aes(x = Label, y = Variability, fill = Label, color = Label)) + 
      geom_violin(trim = FALSE) +
      scale_color_manual(values = ColorScheme) + 
      scale_fill_manual(values = ColorScheme) + 
      labs(x = "Networks", y = "Across-subject Variability") + theme_classic() +
      theme(axis.text.x = element_text(size = 17.5, color = ColorScheme_XText_New),
            axis.text.y = element_text(size = 24, color = "black"),
            axis.title = element_text(size = 26)) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
      theme(legend.position = "none") + 
      scale_x_discrete(
            limits = c(7, 2, 6, 9, 16, 4, 11, 15, 3, 12, 17, 13, 1, 8, 5, 10, 14),
            labels = c("11", "2", "4", "3", "10", "9", "17", "5", "6", "13", 
                     "14", "1", "7", "15", "16", "12", "8")) +
      geom_boxplot(width=0.1, fill = "white");
ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/results/Figures/Variability_Violin.tiff', width = 20, height = 15, dpi = 600, units = "cm");
