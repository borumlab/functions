#define list of MRNUMBERS that meets inclusion criteria
#how to use: paste the lines below into your R code and modify per criteria
#source("mrlist.R")
#pop0000xx <- mrlist(df1, df2, df3, etc.)

mrlist <- function(a,b,c,d,e){
  
  list <- merge(a, b, by.x="MRNUMBER", by.y="MRNUMBER")
  list <- merge(list, c, by.x="MRNUMBER", by.y="MRNUMBER")
  list <- merge(list, d, by.x="MRNUMBER", by.y="MRNUMBER")
  list <- merge(list, e, by.x="MRNUMBER", by.y="MRNUMBER")
  
  return(list)
  
}
























