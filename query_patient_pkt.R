#query database(s) of interest from MySQL
#how to use: paste the line below into your R code
#source("query_patient_pkt.R")

#packages required for this script
library(RMySQL)
library(lubridate)
library(getPass)

#enter MysQL password
getPass()

#connect to database
rm(list=ls(all=TRUE))

connect <- dbConnect(MySQL(),user='hjallen',getPass(),dbname='patient_pkt',host='IF-SRVV-BORUM')

send_query <- function(query) {
  dbSendQuery(connect,query)
}

get_query <- function(query) {
  output <- data.frame(dbGetQuery(connect,query))
  return(output)
}

send_query("USE patient_pkt;")

#increase memory limit
memory.limit(10000)

#select all tables from MySQL that contain patient data
alertness_id_calculated <- get_query("SELECT * FROM alertness_id_calculated;")
anthropometrics_id_research <- get_query("SELECT * FROM anthropometrics_id_research;")
bmr_id_calculated <- get_query("SELECT * FROM bmr_id_calculated;")
clinic_gi_issues_id_calculated <- get_query("SELECT * FROM clinic_gi_issues_id_calculated;")
clinic_visit_id_calculated <- get_query("SELECT * FROM clinic_visit_id_calculated;")
clinical_labs_id_research <- get_query("SELECT * FROM clinical_labs_id_research;")
demographics_id_calculated <- get_query("SELECT * FROM demographics_id_calculated;")
diet_rx_id_calculated <- get_query("SELECT * FROM diet_rx_id_calculated;")
foodomics_daily_diet_research <- get_query("SELECT * FROM foodomics_daily_diet_research;")
foodomics_daily_recommendations <- get_query("SELECT * FROM foodomics_daily_recommendations;")
kgid_mrnumber_link_research <- get_query("SELECT * FROM kgid_mrnumber_link_research;")
meal_challenge_id_calculated <- get_query("SELECT * FROM meal_challenge_id_calculated;")
med_data_id_calculated <- get_query("SELECT * FROM med_data_id_calculated;")
med_data_id_research <- get_query("SELECT * FROM med_data_id_research;")
seizure_data_id_calculated <- get_query("SELECT * FROM seizure_data_id_calculated;")
seizure_data_id_research <- get_query("SELECT * FROM seizure_data_id_research;")
urine_kt_sg_id_calculated <- get_query("SELECT * FROM urine_kt_sg_id_calculated;")
vitals_id_calculated <- get_query("SELECT * FROM vitals_id_calculated;")
vns_id_calculated <- get_query("SELECT * FROM vns_id_calculated;")

#disconnect from database
all_cons <- dbListConnections(MySQL())
for (con in all_cons) {
  dbDisconnect(con)
}


#create list of data frames that functions will be applied to, need help creating functions
#df.list <- mget(ls(pattern="alertness_id_calculated|anthropometrics_id_research|bmr_id_calculated|clinic_gi_issues_id_calculated|clinic_visit_id_calculated|clinical_labs_id_research|demographics_id_calculated|diet_rx_id_calculated|foodomics_daily_diet_research|foodomics_daily_recommendations|kgid_mrnumber_link_research|meal_challenge_id_calculated|med_data_id_calculated|med_data_id_research|seizure_data_id_calculated|seizure_data_id_research|urine_kt_sg_id_calculated|vitals_id_calculated|vns_id_calculated"))

