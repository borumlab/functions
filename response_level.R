#SEIZURE_SCORE.R
#**Purpose**: This function is used for grouping patients based on response levels.



#**How to use**: df equals the name of the data frame, x is equal to the value you want the level to be greater than, y is equal to the value you want the level to be less than

response_level<-function(df,x,y,z,a){
  
  table1<-subset(df,df$SEIZURE_SCORE>=x& df$SEIZURE_SCORE<=y)
  table2<-subset(df,df$SEIZURE_SCORE>y& df$SEIZURE_SCORE<=z)
  table3<-subset(df,df$SEIZURE_SCORE>z& df$SEIZURE_SCORE<=a)
  table4<-subset(df,df$SEIZURE_SCORE>a)
  
  

  return(table)
}
  