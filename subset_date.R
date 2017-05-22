#remove data after desired date on PKT
#how to use: paste the lines below into your R code and modify per criteria
#source("subset_date.R")
#table_name <- subset_date(table_name, 'mm/dd/yyyy')

subset_date <- function(x,y){
  table<-x
  y <- as.Date(y, "%m/%d/%Y")
  
 #remove data after desired date on PKT
  table <- subset(table, DATE <= y)
  
  return(table)
  
}



