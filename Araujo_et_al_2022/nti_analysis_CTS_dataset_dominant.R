# Description: NTI, beta-NTI analysis for the CTS dataset (the dominant biosphere)
# Date: 22-06-2022
# Author: Jia Xiu (xibeihenai@gmail.com)



rm(list=ls())


library(picante)
library(vegan)


cat("calculate NTI for the dominant biosphere")


print("load table")
com <- read.csv("OTU_table_dominant.csv", sep=",", header=T, row.names=1, check.names = FALSE)
com <- t(com)
str(com)
com[1:5, 1:2]

cat("the range of total number of sequences of each species is:", range(apply(com,2,sum)))
cat("the range of total sequences per sample is:", range(apply(com,1,sum)))

print("load phylogenetic tree (rooted) and match it with taxa in the OTU table")
phylo <- read.tree("tree_pruned.nwk")
str(phylo)

print("prune tree")
match.phylo.com <- match.phylo.data(phylo, t(com)); # species as rows, samples as columns for com table
str(match.phylo.com)



print("calculate beta NTI")
beta.mntd.weighted = as.matrix(comdistnt(t(match.phylo.com$data), cophenetic(match.phylo.com$phy), abundance.weighted=T));
dim(beta.mntd.weighted);
beta.mntd.weighted[1:5,1:5];


identical(colnames(match.phylo.com$data), colnames(beta.mntd.weighted)); # just a check, should be TRUE
identical(colnames(match.phylo.com$data), rownames(beta.mntd.weighted)); # just a check, should be TRUE


beta.reps = 999; # number of randomizations

rand.weighted.bMNTD.comp = array(c(-999), dim=c(ncol(match.phylo.com$data),ncol(match.phylo.com$data), beta.reps));
dim(rand.weighted.bMNTD.comp);
write.csv(beta.mntd.weighted, "betaMNTD_weighted_dominant.csv", quote=F);


print("calculate randomized betaMNTD")
for (rep in 1:beta.reps) {
  
  rand.weighted.bMNTD.comp[,,rep] = as.matrix(comdistnt(t(match.phylo.com$data), taxaShuffle(cophenetic(match.phylo.com$phy)),
                                                        abundance.weighted=T, exclude.conspecifics = F));
  
  print(c(date(),rep));
  
}

weighted.bNTI = matrix(c(NA), nrow=ncol(match.phylo.com$data), ncol=ncol(match.phylo.com$data));
dim(weighted.bNTI);

for (columns in 1:(ncol(match.phylo.com$data)-1)) {
  for (rows in (columns+1):ncol(match.phylo.com$data)) {
    
    rand.vals = rand.weighted.bMNTD.comp[rows,columns,];
    weighted.bNTI[rows,columns] = (beta.mntd.weighted[rows,columns] - mean(rand.vals)) / sd(rand.vals);
    rm("rand.vals");
    
  };
};

rownames(weighted.bNTI) = colnames(match.phylo.com$data);
colnames(weighted.bNTI) = colnames(match.phylo.com$data);
weighted.bNTI;
write.csv(weighted.bNTI, "betaNTI_weighted_dominant.csv", quote=F)


# -------------------------------
print("# calculate ses-mntd")
null.model.type = 'independentswap'
iterations = 999

ses_mntd <- ses.mntd(t(match.phylo.com$data), cophenetic(match.phylo.com$phy), 
                     null.model=null.model.type, runs=iterations)
str(ses_mntd)

write.csv(ses_mntd, "SES_MNTD_dominant.csv", row.names=T, quote=F)


print("analysis was done. Good luck!")

