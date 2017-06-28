#Purpose: Calculate seizure score for every set of days listed at the time period value for the patients defined in poplist
#How to use: paste the lines below into your R code and modify per criteria
#source("szscore.R")
#table_name<-szscore(table_name)

sznumberscore<-function(time_period_value, poplist){
time_period<-time_period_value#time_period_value

library(plyr)

#separate baseline and therapy days
#get dataframe with baseline days
baseline_szscore<-subset(seizure_data_id_research,DAY_TYPE=="1")
#get data frame with therapy days
therapy_szscore<-subset(seizure_data_id_research,DAY_TYPE=="2")
#reorder the columns
therapy_szscore<-subset(therapy_szscore,select=c("MRNUMBER",
                                                 "row_names",
                                                 "DATE",
                                                 "DAY_TYPE",
                                                 "DAY_QUALITY_S",
                                                 "SEIZURE_LOAD_DAY",
                                                 "SEIZURE_NUMBER_DAY",
                                                 "SEIZURE_RESPONSE_DAY",
                                                 "SEIZURE_NUMBER_RESPONSE_DAY",
                                                 "PKT_INITIATED_DATE",
                                                 "DOB",
                                                 "DOPKT",
                                                 "AGE",
                                                 "AGE_MO",
                                                 "AGE_DOL"))



#create new data frame with frequency of baseline days per MRNUMBER
baseline_days<-subset(count(baseline_szscore,"MRNUMBER"))
#sum the seizure load for all baseline days per MRNUMBER
baseline_sumsn<-aggregate(cbind(SEIZURE_NUMBER_DAY)~MRNUMBER, data=baseline_szscore,sum)
#divide sum of seizure load by total frequency of baseline days and multiply by the time period value. 
#This will be the denominator when calculating seizure score
baseline_days$time_period<-(baseline_sumsn$SEIZURE_NUMBER_DAY/
                            baseline_days$freq
                            [match(baseline_sumsn$MRNUMBER, baseline_days$MRNUMBER)])*time_period



#create patient list for for loop
patient_list=as.numeric(unique(poplist$MRNUMBER))


#calculate seizure score per time period value per MRNUMBER. Will need to use a for loop to do this
#define empty dataframe to be filled in as it goes through the for loop
emptydf <- data.frame(NROW=as.integer(),emptypdf=as.numeric()) 

#sort df by MRNUMBER then DATE
therapy_szscore<-therapy_szscore[order(therapy_szscore$MRNUMBER, therapy_szscore$DATE),] 

#create new column NROW and number the rows in the df
therapy_szscore$NROW<-1:nrow(therapy_szscore) 

#create empty final data frame for all patients to be put afterwards
szresearch_score<-subset(therapy_szscore,FALSE)

#for loop to cycle through all patients and calculate seizrue score per time period value
for(i in 1:length(patient_list)){ 
  #create a temporary dataframe for only one patient at a time
  temp_df <- subset(therapy_szscore,MRNUMBER==patient_list[i]) 
  
  #sort dataframe by DATET
  temp_df<-temp_df[order(temp_df$DATE),] 
  
  #if the number of days on PKT is greater than or equal to the defined time period 
  #and also number of days on PKT is not equal to 0. 
  #Then remove the remainder above block_period modulus
  if(nrow(temp_df)>=time_period && (nrow(temp_df) %% time_period)!=0){
    temp_df <- head(temp_df, -(nrow(temp_df) %% time_period)) 
  }
  
  #chunk seizure load by the time period so that we can calculate seizure score 
  #for every number of days defined in the time period
  chunk <- split(temp_df, (seq(nrow(temp_df))-1) %/% time_period) 
  
  #get starting row for this patient to start calculating seizure score
  list_row <- as.numeric(temp_df$NROW[1])
  
  #make a conitnuous vector for all of the nrows in temp_df
  list_row <- list_row:(list_row+nrow(temp_df)-1) 
  
  #determine row offset, because 30 days starts with day 1, not 0
  list_row_offset <- time_period-1; if(list_row_offset > nrow(temp_df)){list_row_offset <- nrow(temp_df)-1} 
  
  #chunk the vector based on time period size
  list_row <- list_row[seq(1, length(list_row), time_period)]+list_row_offset 
 
  #calculate the sum seizure load for each chunk of days in the defined time period. 
  #This will be divided by the baseline for the time period value
  list_emptydf_block <- lapply(chunk, function(block) sum(block$SEIZURE_NUMBER_DAY, na.rm=TRUE)) 
  
  #replace NA values with 0, because seizure free days or 0s were NA to begin this section
  list_emptydf_block[is.na(list_emptydf_block)] <- 0 
  
  #format list for merging
  list_emptydf_block <- unname(unlist(list_emptydf_block)) 
  
  #merge list_row number by the  and list  together
  emptydf <- data.frame(NROW = list_row, emptydf = list_emptydf_block) 
  
  #make NROW an integer again
  emptydf<-transform(emptydf, NROW=as.integer(NROW))
  
  #add seizure score to emptydf for merging
  emptydf$SEIZURE_NUMBER_SCORE <- 100*emptydf$emptydf/baseline_days[,"time_period"][i] 
  
  #merge select fields into dataframe
  temp_df<-merge(temp_df, emptydf, by="NROW", all = TRUE) 
  
  #fill in dataframe for each patient
  szresearch_score<-rbind(szresearch_score,temp_df)
 
  
  }
  

  #format final dataframe for selected columns
  szresearch_score<-subset(szresearch_score,select=c(    "MRNUMBER",
                                                         "row_names",
                                                         "DATE",
                                                         "DAY_TYPE",
                                                         "DAY_QUALITY_S",
                                                         "SEIZURE_LOAD_DAY",
                                                         "SEIZURE_NUMBER_DAY",
                                                         "SEIZURE_RESPONSE_DAY",
                                                         "SEIZURE_NUMBER_RESPONSE_DAY",
                                                         "SEIZURE_NUMBER_SCORE",
                                                         "PKT_INITIATED_DATE",
                                                         "DOB",
                                                         "DOPKT",
                                                         "AGE",
                                                         "AGE_MO",
                                                         "AGE_DOL"))
  return(szresearch_score)
  
}
