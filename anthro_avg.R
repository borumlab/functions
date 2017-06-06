#Purpose: Calculate anthros for every set of days listed at the time period value for the patients defined in poplist
#How to use: paste the lines below into your R code and modify per criteria
#source("anthro_avg.R")
#table_name <- anthro_avg(time_period in days, poplist, col="column of interest")

anthro_avg <- function(time_period, poplist, col = "column") {
  
  library(plyr)
  
  #create patient list
  patient_list = as.numeric(unique(poplist$MRNUMBER))
  
  # define empty dataframe to be filled in as it goes through the for loop
  emptydf <- data.frame(NROW=as.integer(), col=as.numeric()) 
  
  # sort df by MRNUMBER then DATE
  anthropkt <- anthropkt[order(anthropkt$MRNUMBER, anthropkt$DATE),] 
  
  # create new column NROW and number the rows in the df
  anthropkt$NROW <- 1:nrow(anthropkt) 
  
  # create empty final data frame for all patients to be put afterwards
  anthropkt_final <- subset(anthropkt,FALSE)
  
  # for loop to cycle through all patients and calculate average
  for(i in 1:length(patient_list)){ 
    
    # create a temporary data frame for only one patient at a time
    temp_df <- subset(anthropkt,MRNUMBER==patient_list[i]) 
    
    # sort dataframe by date
    temp_df <- temp_df[order(temp_df$DATE),] 
    
    # chunk data by the time period so that we can calculate average for every number of days defined in the time period
    chunk <- split(temp_df, (seq(nrow(temp_df))-1) %/% time_period) 
    
    # get starting row for this patient to start calculating average
    list_row <- as.numeric(temp_df$NROW[1])
    
    # make a conitnuous vector for all of the nrows in temp_df
    list_row <- list_row:(list_row+nrow(temp_df)-1) 
    
    # determine row offset, because 7 days starts with day 1, not 0
    list_row_offset <- time_period-1; if(list_row_offset > nrow(temp_df)){list_row_offset <- nrow(temp_df)-1} 
    
    # chunk the vector based on time period size
    list_row <- list_row[seq(1, length(list_row), time_period)]+list_row_offset 
    
    # calculate the average for each chunk of days in the defined time period 
    list_emptydf_block <- lapply(chunk, function(block) mean(block[, col], na.rm=TRUE)) 
    
    # format list for merging
    list_emptydf_block <- unname(unlist(list_emptydf_block)) 
    
    # merge list_row number by the and list together
    emptydf <- data.frame(NROW = list_row, col = list_emptydf_block) 
    
    # make NROW an integer again
    emptydf <- transform(emptydf, NROW=as.integer(NROW))
    
    # merge select fields into dataframe
    temp_df <- merge(temp_df, emptydf, by="NROW", all = TRUE) 
    
    # fill in dataframe for each patient
    anthropkt_final <- rbind(anthropkt_final,temp_df)
    
    
  }
  
  names(anthropkt_final)[names(anthropkt_final)=="col"] <- col
  
  return(anthropkt_final)
  
}

