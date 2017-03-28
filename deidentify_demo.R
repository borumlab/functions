#purpose: de-identify demographics
#how to use: paste the lines below into your R code and modify per criteria
#source("deidentify_demo.R")
#demographics_id_calculated <- deidentify_demo()

deidentify_demo <- function(){
  
  #merge table with KGID table
  demographics_id_calculated <- merge(x = demographics_id_calculated, y = kgid_mrnumber_link_research[ , c("MRNUMBER", "KGID")], by = "MRNUMBER", all.x=TRUE)
  
  table <- demographics_id_calculated
  
  #create new columns that will replace identifiable dates with de-indentified DOL
  table$DOB <- as.Date(table$DOB)
  
  #replace NULL text with missing data
  table$VNS_IMP_DATE[table$VNS_IMP_DATE == "NULL"] <- NA
  
  table$VNS_IMP_DATE <- as.Date(table$VNS_IMP_DATE)
  span <- interval(table$DOB, table$VNS_IMP_DATE)
  table$VNS_IMP_DOL <- as.period(span, "days")
  table$VNS_IMP_DOL <- as.numeric(day(table$VNS_IMP_DOL)) + 1
 
  table$EONSET_DATE <- as.Date(table$EONSET_DATE)
  span <- interval(table$DOB, table$EONSET_DATE)
  table$EONSET_DOL <- as.period(span, "days")
  table$EONSET_DOL <- as.numeric(day(table$EONSET_DOL)) + 1
  
  span <- interval(table$DOB, table$PKT_INITIATED_DATE)
  table$PKT_INITIATED_DOL <- as.period(span, "days")
  table$PKT_INITIATED_DOL <- as.numeric(day(table$PKT_INITIATED_DOL)) + 1
  
  span <- interval(table$DOB, table$PKT_STOPPED_DATE)
  table$PKT_STOPPED_DOL <- as.period(span, "days")
  table$PKT_STOPPED_DOL <- as.numeric(day(table$PKT_STOPPED_DOL)) + 1
  
  table$PKT_PROSPECTIVE_DATE <- as.Date(table$PKT_PROSPECTIVE_DATE)
  span <- interval(table$DOB, table$PKT_PROSPECTIVE_DATE)
  table$PKT_PROSPECTIVE_DOL <- as.period(span, "days")
  table$PKT_PROSPECTIVE_DOL <- as.numeric(day(table$PKT_PROSPECTIVE_DOL)) + 1

  #remove identifying columns
  demographics_id_calculated <- subset(table, select=-c(MRNUMBER,
                                                        LAST,
                                                        FIRST,
                                                        FILA_ABBR,
                                                        CITY,
                                                        STATE,
                                                        ZIP_CODE,
                                                        COUNTY,
                                                        VNS_IMP_DATE,
                                                        EONSET_DATE,
                                                        PKT_INITIATED_DATE,
                                                        DOB,
                                                        PKT_STOPPED_DATE,
                                                        PKT_PROSPECTIVE_DATE))
                                                                      
  return(demographics_id_calculated)
  
}



