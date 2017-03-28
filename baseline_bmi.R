#select patients that have baseline BMI
#how to use: paste the lines below into your R code and modify per criteria
#source("baseline_bmi.R")
#baseline_list_bmi <- baseline_bmi()

baseline_bmi <- function(){
  
  #select patients that have baseline BMI
  baseline_bmi <- subset(anthropometrics_id_research, BMI!="NA" & DAY_TYPE==1)
  
  #get list of patients with baseline BMI
  baseline_list_bmi <- subset(baseline_bmi, select="MRNUMBER")
  
  #create list of unique MRNUMBER with baseline BMI
  baseline_list_bmi <- unique(baseline_list_bmi, fromLast = TRUE)
  
  return(baseline_list_bmi)
  
}







