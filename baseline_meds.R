#subset patients who have baseline meds > 0
#how to use: paste the lines below into your R code and modify per criteria
#source("baseline_meds.R")
#baseline_list_meds <- baseline_meds(0)

baseline_meds <- function(x){
  
  #select patients that have baseline meds
  baseline_meds <- subset(med_data_id_research, DAY_TYPE=="1")
  
  #sum med load to identify if baseline is not 0
  sum_baseline_meds <- aggregate(cbind(MED_LOAD_DAY)~MRNUMBER, data=baseline_meds, sum)
  
  #get baseline days with meds
  baseline_days_meds <- subset(sum_baseline_meds, sum_baseline_meds$MED_LOAD_DAY > x)
  
  #get list of patients with baseline meds
  baseline_list_meds <- subset(baseline_days_meds, select="MRNUMBER")
  
  #create list of unique MRNUMBER with baseline meds
  baseline_list_meds <- unique(baseline_list_meds, fromLast = TRUE)
  
  return(baseline_list_meds)
  
}







