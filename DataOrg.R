library(tidyverse)
library(readxl)

## Question 1: Who do they like when exposed to just one thing?

Exp1Treats <- c(250, 500, 750, 1000)

WildTypeFull <- read_xlsx("D:/Projects/DarrenThesis/Darren/Data/ALL_CP Bloom_ Data 2022.xlsx", sheet = "UseThis")

WildTypeAlone <- WildTypeFull %>%
  filter(Treatment %in% Exp1Treats)

CocAlone <- read_xlsx("D:/Projects/DarrenThesis/Darren/Data/ALL_CP_Culture_Data 2022.xlsx", sheet = "UseThis")

RhodoAlone <- read_xlsx("D:/Projects/DarrenThesis/Darren/Data/ALL_Rhodo_M.m_Raw_R Data.xlsx", sheet = "UseThis")

RhodoAlone <- RhodoAlone %>%
  filter(Treatment %in% Exp1Treats)

AloneFull <- rbind(CocAlone, WildTypeAlone, RhodoAlone)

summary(AloneFull)
