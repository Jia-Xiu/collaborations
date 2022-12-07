# Classify different rarity types
# Builted on 26-11-2018 by Leonel Herrera Alsina
# Updated on 28-11-2018 by Xiu Jia


rarity_type <- function(dataset, cutoff, total_abundance) {
  
  vector_category <- NULL
  
  for(i in 1:nrow(dataset)){
    
    focal_species <- as.numeric(dataset[i, 1:ncol(dataset)])
    
    if(sum(focal_species) == 0) {
      cat("The ASV", i,"has abundance of zero \n")
    } 
    
    if(max(focal_species) > cutoff * total_abundance) {
      # conditionally rare/dominant
      category <- 'C'
    } else {
      
      if(sum(focal_species != 0) == 1 ) {
        # transiently rare
        category <- 'B'
      } else { 
        # permanently rare
        category <- 'A'
      }
    }
    
    vector_category <- c(vector_category,category)
    
  }
  new_table<-cbind(dataset,vector_category)
  return(new_table)
}
