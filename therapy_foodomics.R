#subset patients who have foodomics data
#how to use: paste the lines below into your R code and modify per criteria
#source("foodomics.R")
#list_food <- foodomics()

therapy_foodomics <- function(){
  
  #get list of patients with food data
  listfood<-subset(foodomics_daily_diet_research,select="MRNUMBER")
 
  #create list of unique MRNUMBER with baseline med
  listfood<-(unique(listfood,fromLast = TRUE ))
  
  return(listfood)
  
}





