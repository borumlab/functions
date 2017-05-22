#calculate frequency and proportion of parameter in demographics
#how to use: paste the lines below into your R code and modify per criteria
#source("demoDesc.R")
#table_name <- (df, col = "column")

demoDesc <- function(df, col = "column"){

  table <- transform(setNames(as.data.frame(table(df[, col])), c(col, "Count")), Percent = paste0(round((100*Count/sum(Count)),0), "%"))
  
  return(table)
  
}

