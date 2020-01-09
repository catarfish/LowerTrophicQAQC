### Catarina Pien
### 5/30/19
### Merge species taxonomy - Yolo with FRP
### Trying to add life stage as a column for our data

library(dplyr)
library(tidyr)
library(stringr)

# Merge species codes FRP and YBFMP

rm(list=ls(all=TRUE))

setwd("C:/Users/cpien/OneDrive - California Department of Water Resources/Work/Database/R_code/")
frp_sp <- read.csv("Data/FRP_SpeciesCodes.csv")
yb_sp <- read.csv("Data/TblZoopsLookUpV2.csv")

# Join datasets
sp_common <- left_join(yb_sp, frp_sp, by = "Organism")

# Add Life Stage Column for those Organism categories with life stage embedded. 
sp_lifestage <- sp_common %>%
  mutate(LS = ifelse(str_detect(Organism, "copepodid"), "copepodid", 
                     ifelse(str_detect(Organism, "adult"), "adult",
                            ifelse(str_detect(Organism, "naupli"), "nauplius",
                                   ifelse(str_detect(Organism, "juvenile"), "juvenile",
                                          ifelse(str_detect(Organism, "larva"), "larva",
                                                 ifelse(str_detect(Organism, "Larva"), "larva",
                                                        ifelse(str_detect(Organism, "baby"), "baby",NA)))))))) %>%
  select(-c(4,5,6,13:15))


# Write new file
write.csv(sp_lifestage, "Data/Merge_FRP_YB.csv")
