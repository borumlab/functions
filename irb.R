#select population from IRB protcol of interest from demographics
#how to use: paste the lines below into your R code and modify per criteria
#source("irb.R")
#demographics_id_calculated <- irb("TYPE IRB# HERE")

irb <- function(x){
  newdemo <- subset(demographics_id_calculated,IRB_NUMBER==x)
  return(newdemo)
}
  
