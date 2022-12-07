# Description: Calculate RC-bray matrix for the CTS dataset
# Date: 22-06-2022
# Author: Jia Xiu (xibeihenai@gmail.com)


rm(list=ls())

library(vegan)

source("raup_crick_abundance.R")


cat("read feature table for the rare biosphere")
com <- read.csv("OTU_table_rare.csv", sep=",", header=T, row.names=1, check.names = FALSE)
com <- t(com)
str(com)

iteration = 999
df <- raup_crick_abundance(com, reps = iteration)

print("write csv")

write.csv(as.data.frame(as.matrix(df)), "RC-bray_rare.csv")





