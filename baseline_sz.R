#subset patients who have baseline seizures > 0
#how to use: paste the lines below into your R code and modify per criteria
#source("baseline_sz.R")
#baseline_list_seizure <- baseline_sz(0)

baseline_sz <- function(x){
  
  #select patients that have a baseline seizure
  baseline_seizure <- subset(seizure_data_id_research, DAY_TYPE=="1")
  
  #sum seizure load to identify if baseline is not 0
  sum_baseline_seizure <- aggregate(cbind(SEIZURE_LOAD_DAY)~MRNUMBER, data=baseline_seizure, sum)
  
  #get baseline days with seizures
  baseline_days_seizure <- subset(sum_baseline_seizure, sum_baseline_seizure$SEIZURE_LOAD_DAY > x)
 
  #get list of patients with baseline seizures
  baseline_list_seizure <- subset(baseline_days_seizure, select="MRNUMBER")
 
  #create list of unique MRNUMBER with baseline seizures
  baseline_list_seizure <- unique(baseline_list_seizure, fromLast = TRUE)
 
  return(baseline_list_seizure)
  
}






