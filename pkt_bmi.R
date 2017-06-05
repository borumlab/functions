#select patients that have pkt at desired time point on PKT (get rid of patients with missing data)
#how to use: paste the lines below into your R code and modify per criteria
#source("pkt_bmi.R")
#pkt_list_bmi <- pkt_bmi(x days)

pkt_bmi <- function(x){
  
  #select patients that have baseline BMI
  pkt_bmi <- subset(anthropometrics_id_research, BMI_DAY!="NA" & DOPKT==x)
  
  #get list of patients with baseline BMI
  pkt_list_bmi <- subset(pkt_bmi, select="MRNUMBER")
  
  #create list of unique MRNUMBER with baseline BMI
  pkt_list_bmi <- unique(pkt_list_bmi, fromLast = TRUE)
  
  return(pkt_list_bmi)
  
}







