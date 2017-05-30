#calculate age at initiation and subset patients who are less than your selected age
#how to use: paste the lines below into your R code and modify per criteria
#source("age_initiation.R")
#demographics_id_calculated <- age_initiation(age in years)

age_initiation <- function(x){
  
  demographics_id_calculated$DOB <- as.Date(demographics_id_calculated$DOB)
  demographics_id_calculated$PKT_INITIATED_DATE <- as.Date(demographics_id_calculated$PKT_INITIATED_DATE)
  
  span <- interval(demographics_id_calculated$DOB, demographics_id_calculated$PKT_INITIATED_DATE)
  demographics_id_calculated$AGE_INITIATION <- time_length(span, "year")
  demographics_id_calculated$AGE_INITIATION <- floor(demographics_id_calculated$AGE_INITIATION*100)/100
  
  #get demographics of patients who have been on at least y days
  table <- subset(demographics_id_calculated,AGE_INITIATION < x)
  
  return(table)
  
}

