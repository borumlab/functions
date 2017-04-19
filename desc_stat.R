#calculate descriptive statistics for any dataset, column header, and day on PKT value
#how to use: paste the lines below into your R code and modify per criteria
#source("desc_stat.R")
#table_name <- desc_stat(name of data frame, 
#"name of column header", 
#write "all" if you want all data in the specified column to be include or 
#write numerical value equal to day on PKT)

desc_stat<-function(df, col="column",DOPKT_value){

if(DOPKT_value=="all")  dfnew<-df
 else dfnew<-subset(df,DOPKT==DOPKT_value)



columnheader<-c('DOPKT',
                'median',
                'variance',
                'standard_deviation',
                'maximum',
                'minimum',
                'range',
                '5th_percentile',
                '25th_percentile',
                '50th_percentile',
                '75th_percentile',
                '95th_percentile',
                'total_number_of_values',
                'mean',
                'standard_error',
                'coefficient_of_variation'
)
  
addme<-c(DOPKT_value,
        with(dfnew,paste0(median(dfnew[, col]))),
        with(dfnew,paste0(var(dfnew[, col]))), 
        with(dfnew,paste0(sd(dfnew[, col]))),
        with(dfnew,paste0(max(dfnew[, col]))),
        with(dfnew,paste0(min(dfnew[, col]))),
        with(dfnew,paste0(max(dfnew[, col])-min(dfnew[, col]))),
        with(dfnew,paste0(quantile(dfnew[, col],probs = c(.05)))),
        with(dfnew,paste0(quantile(dfnew[, col],probs = c(.25)))),
        with(dfnew,paste0(quantile(dfnew[, col],probs = c(.50)))),
        with(dfnew,paste0(quantile(dfnew[, col],probs = c(.75)))),
        with(dfnew,paste0(quantile(dfnew[, col],probs = c(.95)))),
        with(dfnew,paste0(length(dfnew[, col]))),
        with(dfnew,paste0(mean(dfnew[, col]))),
        with(dfnew,paste0(sd(dfnew[, col])/sqrt(length(dfnew[, col])))),
        with(dfnew,paste0(sd(dfnew[, col],na.rm=TRUE)/mean(dfnew[, col], na.rm=TRUE))))






descrp_table<-data.frame(columnheader,addme)

descrp_table$addme<-as.numeric(as.character(descrp_table$addme))

descrp_table[,'addme']=round(descrp_table[,'addme'],2)

return(descrp_table)

}