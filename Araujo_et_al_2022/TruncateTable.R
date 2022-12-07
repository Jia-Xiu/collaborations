# Author: Xiu Jia (xibeihenai@gmail.com)
# Date: 20-05-2022
# Based onthe scripts of Xiu (01-09-2018) which was inspired by Angelique Gobet & Alban Ramette, MultiCoLA Manual - Quick and Easy version (2011) https://www.mpi-bremen.de/Binaries/Binary1660/MultiCoLA.1.4.-.zip

# package needed in the analysis
library(vegan)

# sample-specific cutoffs
TruncateTable <- function(dataset, typem){
  
  # remove columns in the matrix for which the sum of the line is 0
  CLrow <- function(m) {
    m <- m[, colSums(m)!=0] 
    return(m)
  }
  
  # remove all the rows in the matrix for which the sum of the line is 0
  # the case happend only if you increased the cutoff untill it reaches the lowest number of the maximum OTU occurance in all samples
  CLcol <- function(m) {
    m <- m[, rowSums(m)!=0]
    return (m)
  }
  

  # write dataset as OTU table (sample x species)
  otu_table <- dataset
  
  # get the sample specific cutoffs
  Chao <- as.data.frame(t(estimateR(otu_table)))
  Chao$slope <- Chao$S.obs/Chao$S.chao1
  head(Chao)
  
  # built empty matrix
  cutoffs <- matrix(NA, nrow(otu_table), 3)
  row.names(cutoffs) <- row.names(otu_table)
  cutoffs[,2] <- Chao$slope
  cutoffs[,3] <- Chao$S.obs
  colnames(cutoffs) <- c("Rarity.cutoffs", "Slopes", "S.obs")
  
  # find rarity cutoffs 
  for (j in 1:nrow(otu_table)) {
    otu_table_j <- sort(as.numeric(otu_table[j, ]), decreasing = TRUE)
    otu_table_j <- otu_table_j[otu_table_j != 0]
    slope <- cutoffs[j, 2]
    for (i in 1:length(otu_table_j)){
      if (otu_table_j[i] >= i*slope){
        H <- i
      }
    }
    cutoffs[j, 1] <- H
    
    
    length(otu_table[j, ])
    # define the dominant biosphere - all species presents more than the cutoff
    if(typem == "dominant") {otu_table[j, ][otu_table[j, ] <= H] <- 0}
    
    
    # define the rare biosphere - all species presents no more than the cutoff
    if(typem == "rare") {otu_table[j, ][otu_table[j, ] > H] <- 0}
  }
  
  otu_table <- CLcol(CLrow(otu_table))	#remove rows and columns whose sum=0
  
  cutoffs <- as.data.frame(cutoffs)
  cutoffs$Var1 <- factor(row.names(cutoffs))
  
  return(otu_table)
  # return(cutoffs)
}  # end TruncateTable

