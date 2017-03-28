#subset data in all data tables based on MRNUMBERS that meet inclusion criteria
#how to use: paste the lines below into your R code and modify per criteria
#source("subset_pop.R")
#table_name <- subset_pop(table_name, pop0000xx)


subset_pop <- function(x,y){

  table <- subset(x,MRNUMBER %in% y$MRNUMBER)
  
  return(table)

}


#subset list of patients defined for pop000023
#df.list <- lapply(df.list,function(x){subset(df.list,x$MRNUMBER %in% pop000023$MRNUMBER)})
#list2env(df.list1,.GlobalEnv)






