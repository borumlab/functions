#de-identify the data
#how to use: paste the lines below into your R code and modify per criteria
#source("deidentify.R")
#table_name <- deidentify(table_name)

deidentify <- function(table){
  
  #de-identify the data
  table <- merge(x = table, y = kgid_mrnumber_link_research[ , c("MRNUMBER", "KGID")], by = "MRNUMBER", all.x=TRUE)
  
  #remove identifying columns
  table <- subset(table, select=-c(PKT_INITIATED_DATE,DOB,DATE,MRNUMBER))
  
  return(table)
  
}



