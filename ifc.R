#select population based on last date patient could have signed informed consent (ifc) from demographics
#how to use: paste the lines below into your R code and modify per criteria
#source("ifc.R")
#demographics_id_calculated <- ifc('mm/dd/yyyy')

ifc <- function(x){
  x <- as.Date(x, "%m/%d/%Y")
  newdemo <- subset(demographics_id_calculated,PKT_PROSPECTIVE_DATE <= x)
  return(newdemo)
}

