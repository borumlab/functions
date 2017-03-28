#Purpose: Calculate outcome score for every set of days listed at the time period value for the patients defined in poplist
#How to use: paste the lines below into your R code and modify per criteria
#source("outcomescore.R")
#table_name<-outcomescore(seizure table name, med table name)

outcomescore<-function(seizure_table_deidentified,med_table_deidentified){

#merge deidentified seizure and med table together by mathcing KGID and DOPKT
outcome_score<-merge(seizure_table_deidentified,med_table_deidentified,by.x=c("KGID","DOPKT"),by.y=c("KGID","DOPKT"))
#calculate outcome score by averaging seizure score and med score
outcome_score$OUTCOME_SCORE<-(outcome_score$SEIZURE_SCORE+outcome_score$MED_SCORE)/2  
#order outcome score by KGID then DOPKT
outcome_score<-outcome_score[order(outcome_score$KGID, outcome_score$DOPKT),] 

#format final dataframe for selected columns
outcome_score<-subset(outcome_score,select=c(            "KGID",
                                                         "DOPKT",
                                                         "SEIZURE_SCORE",
                                                         "MED_SCORE",
                                                         "OUTCOME_SCORE"))
  return(outcome_score)
  
}
