#clean anthropometrics data
#how to use: paste the lines below into your R code and modify per criteria
#source("clean_anthros.R")
#anthropometrics_id_research <- clean_anthros()

clean_anthros <- function (){
  
  
  #remove all data that is not baseline or on PKT (keep day type 1 and 2)
  table <- subset(anthropometrics_id_research, DAY_TYPE==1 | DAY_TYPE==2 )
  
  
  #per recommendations, use WHo for children <2 years of age and use CDC for children >= 2 years of age
  table$HT_Z_SCORE <- ifelse(table$AGE_MO <24, table$WHO_HT_Z_DAY,
                                                   ifelse(table$AGE_MO >=24 & table$AGE_MO <=240, table$CDC_HT_Z_DAY, table$NHANES_HT_Z_DAY))
  
  table$WT_Z_SCORE <- ifelse(table$AGE_MO <24, table$WHO_WT_Z_DAY,
                                                   ifelse(table$AGE_MO >=24 & table$AGE_MO <=240, table$CDC_WT_Z_DAY, table$NHANES_WT_Z_DAY))
  
  table$BMI_Z_SCORE <- ifelse(table$AGE_MO <24, table$WHO_BMI_Z_DAY,
                                                    ifelse(table$AGE_MO >=24 & table$AGE_MO <=240, table$CDC_BMI_Z_DAY, table$NHANES_BMI_Z_DAY))
  
  
  #no recommendations exist, use WHO for children <=1856 days of life and use NHANES for children >1856 days of life
  table$UAC_Z_SCORE <- ifelse(table$AGE_DOL <=1856, table$WHO_UAC_Z_DAY,table$NHANES_UAC_Z_DAY)
  
  table$TSF_Z_SCORE <- ifelse(table$AGE_DOL <=1856, table$WHO_TSF_Z_DAY,table$NHANES_TSF_Z_DAY)
  
  table$SSF_Z_SCORE <- ifelse(table$AGE_DOL <=1856, table$WHO_SSF_Z_DAY,table$NHANES_SSF_Z_DAY)
  
  
  return(table)
  
}
