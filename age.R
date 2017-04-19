#calculate age at time of data collection in year, month, and day of life
#how to use: paste the lines below into your R code and modify per criteria
#source("age.R")
#table_name_calculated <- age(table_name)

age <- function(table){
  
  span <- interval(table$DOB, table$DATE)
  table$AGE <- as.period(span)
  table$AGE <- as.numeric(year(table$AGE))
  table$AGE_MO <- as.period(span, "months")
  table$AGE_MO <- as.numeric(month(table$AGE_MO))
  table$AGE_DOL <- as.period(span, "days")
  table$AGE_DOL <- as.numeric(day(table$AGE_DOL)) + 1
  
  return(table)
  
}

