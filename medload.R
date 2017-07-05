#Purpose: Calculate med score for every set of days listed at the time period value for the patients defined in poplist
#How to use: paste the lines below into your R code and modify per criteria
#source("medscore.R")
#table_name<-medscore(table_name)

medload<-function(time_period_value, poplist){
time_period<-time_period_value#time_period_value


library(plyr)

#separate baseline and therapy days
#get dataframe with baseline days
baseline_medscore<-subset(med_data_id_research,DAY_TYPE=="1")
#get data frame with therapy days
therapy_medscore<-subset(med_data_id_research,DAY_TYPE=="2")
#reorder the columns
therapy_medscore<-subset(therapy_medscore,select=c("MRNUMBER",
                                                 "row_names",
                                                 "DATE",
                                                 "DAY_TYPE",
                                                 "MED_LOAD_DAY",
                                                 "MED_NUMBER_DAY",
                                                 "MED_RESPONSE_DAY",
                                                 "MED_NUMBER_RESPONSE_DAY",
                                                 "PKT_INITIATED_DATE",
                                                 "DOB",
                                                 "DOPKT",
                                                 "AGE",
                                                 "AGE_MO",
                                                 "AGE_DOL"))



#create new data frame with frequency of baseline days per MRNUMBER
baseline_days<-subset(count(baseline_medscore,"MRNUMBER"))
#sum the med load for all baseline days per MRNUMBER
baseline_summl<-aggregate(cbind(MED_LOAD_DAY)~MRNUMBER, data=baseline_medscore,sum)
#divide sum of med load by total frequency of baseline days and multiply by the time period value. 
#This will be the denominator when calculating med score
baseline_days$time_period<-(baseline_summl$MED_LOAD_DAY/
                            baseline_days$freq
                            [match(baseline_summl$MRNUMBER, baseline_days$MRNUMBER)])*time_period



#create patient list for for loop
patient_list=as.numeric(unique(poplist$MRNUMBER))


#calculate med score per time period value per MRNUMBER. Will need to use a for loop to do this
#define empty dataframe to be filled in as it goes through the for loop
emptydf <- data.frame(NROW=as.integer(),emptypdf=as.numeric()) 

#sort df by MRNUMBER then DATE
therapy_medscore<-therapy_medscore[order(therapy_medscore$MRNUMBER, therapy_medscore$DATE),] 

#create new column NROW and number the rows in the df
therapy_medscore$NROW<-1:nrow(therapy_medscore) 

#create empty final data frame for all patients to be put afterwards
medresearch_score<-subset(therapy_medscore,FALSE)

#for loop to cycle through all patients and calculate med score per time period value
for(i in 1:length(patient_list)){ 
  #create a temporary dataframe for only one patient at a time
  temp_df <- subset(therapy_medscore,MRNUMBER==patient_list[i]) 
  
  #sort dataframe by DATE
  temp_df<-temp_df[order(temp_df$DATE),] 
  
  #if the number of days on PKT is greater than or equal to the defined time period 
  #and also number of days on PKT is not equal to 0. 
  #Then remove the remainder above block_period modulus
  if(nrow(temp_df)>=time_period && (nrow(temp_df) %% time_period)!=0){
    temp_df <- head(temp_df, -(nrow(temp_df) %% time_period)) 
  }
  
  #chunk med load by the time period so that we can calculate med score 
  #for every number of days defined in the time period
  chunk <- split(temp_df, (seq(nrow(temp_df))-1) %/% time_period) 
  
  #get starting row for this patient to start calculating med score
  list_row <- as.numeric(temp_df$NROW[1])
  
  #make a conitnuous vector for all of the nrows in temp_df
  list_row <- list_row:(list_row+nrow(temp_df)-1) 
  
  #determine row offset, because 30 days starts with day 1, not 0
  list_row_offset <- time_period-1; if(list_row_offset > nrow(temp_df)){list_row_offset <- nrow(temp_df)-1} 
  
  #chunk the vector based on time period size
  list_row <- list_row[seq(1, length(list_row), time_period)]+list_row_offset 
 
  #calculate the sum med load for each chunk of days in the defined time period. 
  #This will be divided by the baseline for the time period value
  list_emptydf_block <- lapply(chunk, function(block) sum(block$MED_LOAD_DAY, na.rm=TRUE)) 
  
  #replace NA values with 0, because med free days or 0s were NA to begin this section
  list_emptydf_block[is.na(list_emptydf_block)] <- 0 
  
  #format list for merging
  list_emptydf_block <- unname(unlist(list_emptydf_block)) 
  
  #merge list_row number by the  and list  together
  emptydf <- data.frame(NROW = list_row, emptydf = list_emptydf_block) 
  
  #make NROW an integer again
  emptydf<-transform(emptydf, NROW=as.integer(NROW))
  
  #add med score to emptydf for merging
  emptydf$MED_LOAD_SUM <- emptydf$emptydf/91
  
  #merge select fields into dataframe
  temp_df<-merge(temp_df, emptydf, by="NROW", all = TRUE) 
  
  #fill in dataframe for each patient
  medresearch_score<-rbind(medresearch_score,temp_df)
 
  
  }
  

  #format final dataframe for selected columns
  medresearch_score<-subset(medresearch_score,select=c(  "MRNUMBER",
                                                         "row_names",
                                                         "DATE",
                                                         "DAY_TYPE",
                                                         "MED_LOAD_DAY",
                                                         "MED_NUMBER_DAY",
                                                         "MED_RESPONSE_DAY",
                                                         "MED_NUMBER_RESPONSE_DAY",
                                                         "MED_LOAD_SUM",
                                                         "PKT_INITIATED_DATE",
                                                         "DOB",
                                                         "DOPKT",
                                                         "AGE",
                                                         "AGE_MO",
                                                         "AGE_DOL"))
  return(medresearch_score)
  
}
