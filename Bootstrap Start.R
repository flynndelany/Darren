#Bootstrap data

DataTrialBoot <- ALL_CP_Culture_RAW_R_Data_Neg %>%
  select(CLR = `Amended CL DW`, Treatment, Strain)
#DataTrialBoot <- CP_RHODO_Culture_RAW_R_Data_Neg %>%
#       select(CLR = `Amended CL DW`, Treatment, Strain)
head(DataTrialBoot)

n <- 1000
#Anova with bootstrap values
anovbt <- ANOVA.boot(CLR ~ Treatment + as.factor(Strain), B = n, data = DataTrialBoot, seed = 1996)
anovbt$`p-values`

#Bootstrap
set.seed(1996)
avgStrainBoot <- data.frame()
avgTreatmentBoot <- data.frame()
colnames(avgStrainBoot) <- c("Strain", "avgCLR")
colnames(avgTreatmentBoot) <- c("Strain", "avgCLR")

for (i in 1:n) {
  sampleDist = DataTrialBoot[sample(1:nrow(DataTrialBoot), nrow(DataTrialBoot), replace = T),]
  
  avgStrain <- sampleDist %>%
    group_by(Strain) %>%
    summarise(avgCLR = mean(CLR))
  avgStrainBoot <- rbind(avgStrainBoot, avgStrain)
  
  avgTreatment <- sampleDist %>%
    group_by(Treatment) %>%
    summarise(avgCLR = mean(CLR))
  avgTreatmentBoot <- rbind(avgTreatmentBoot, avgTreatment)
}
head(avgStrainBoot)
avgStrainBoot$Strain <- as.factor(avgStrainBoot$Strain)
library(ggplot2)
ggplot(avgStrainBoot, aes(x = Strain, y = avgCLR)) +
  geom_boxplot()

avgTreatmentBoot$Treatment <- as.factor(avgTreatmentBoot$Treatment)
ggplot(avgTreatmentBoot, aes(x = Treatment, y = avgCLR)) +
  geom_boxplot()
