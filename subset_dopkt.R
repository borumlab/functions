#calculate time on PKT at time of data collection and remove data after desired days on PKT
#how to use: paste the lines below into your R code and modify per criteria
#source("subset_dopkt.R")
#table_name <- subset_dopkt(table_name, specify days on pkt)

subset_dopkt <- function(a,b){
  
  #merge table with demographics initiatied date and DOB
  table <- merge(x = a, y = demographics_id_calculated[,c("MRNUMBER", "PKT_INITIATED_DATE","DOB")], by = "MRNUMBER", all.x=TRUE)
  
  #determine time on PKT at time of data collection
  table$DATE <- as.Date(table$DATE)
  span <- interval(table$PKT_INITIATED_DATE, table$DATE)
  table$DOPKT <- as.period(span, "days")
  table$DOPKT <- as.numeric(day(table$DOPKT)) + 1
 
  #remove data after desired number of days on PKT
  table <- subset(table, DOPKT <= b)
  
  return(table)
  
}


