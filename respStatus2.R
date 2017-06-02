#assign response level based on Seizure score 50 and 80 as cutoffs
#how to use: paste the lines below into your R code and modify per criteria
#source("respStatus2.R")
#table_name <- respStatus2(df, col = "column")

respStatus2 <- function (df, col = "column"){
  
  new_column <- ifelse(df[, col] <=50, "level2_1",ifelse(df[, col] >50, "level2_2","none"))
  
  return(new_column)
  
}