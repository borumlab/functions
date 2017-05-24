#assign response level based on Seizure score using 10, 80, and >80 as cutoffs
#how to use: paste the lines below into your R code and modify per criteria
#source("respStatus.R")
#anthros <- respStatus(df, col = "column")

respStatus <- function (df, col = "column"){
  
  new_column <- ifelse(df[, col] <=10, "level1",ifelse(df[, col] >80, "level3", "level2"))
  
  return(new_column)
  
}