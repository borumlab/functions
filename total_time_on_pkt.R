#select population based on total time on PKT from demographics
#how to use: paste the lines below into your R code and modify per criteria
#source("total_time_on_pkt.R")
#table_name <- total_time_on_pkt('mm/dd/yyyy',specify number of days)

total_time_on_pkt <- function(x,y){
  
  x <- as.Date(x, "%m/%d/%Y")
  
  #replace missing PKT_STOPPED_DATE with specified date (x)
  demographics_id_calculated$PKT_STOPPED_DATE <- as.Date(demographics_id_calculated$PKT_STOPPED_DATE)
  demographics_id_calculated$PKT_INITIATED_DATE <- as.Date(demographics_id_calculated$PKT_INITIATED_DATE)
  demographics_id_calculated$PKT_STOPPED_DATE[is.na(demographics_id_calculated$PKT_STOPPED_DATE)] <- x
  
  #calculate total length of time on PKT in days (y)
  span <- interval(demographics_id_calculated$PKT_INITIATED_DATE, demographics_id_calculated$PKT_STOPPED_DATE)
  demographics_id_calculated$TOTAL_DAYS_PKT <- as.period(span, "days")
  demographics_id_calculated$TOTAL_DAYS_PKT <- as.numeric(day(demographics_id_calculated$TOTAL_DAYS_PKT)) + 1
  
  #get demographics of patients who have been on at least y days
  newdemo <- subset(demographics_id_calculated,TOTAL_DAYS_PKT >= y)

  return(newdemo)
  
}





