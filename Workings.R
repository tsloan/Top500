#############################################################################
## 
## This file contains various workings and try-outs
##
#############################################################################

source("ReadLocalTop500Lists.R") # read file function
start.year <- 1993 # Initial year to read the Top 500 list 
end.year <- 2013 # Final year to read the Top 500 list
data.dir <- "data-Top500-lists"  # local directory where the lists are stored

##############################################################################
## ~ReadTop500df - This function takes a Top 500 filename, checks if 
##    as a file of that name exists in the the local directory, 
##    check if the file contains the power column, if yes then read
##    that file into a data frame, and adds two columns, the first of which
##    indicates the year of the Top500 list and the second of which
##    indicates the month of the Top 500 list
##  
##  Note this wil return NULL if filename does not exist or the 
##  Top 500 list does now contain power as a column name
##  
##############################################################################

ReadTop500df <- function(Top500filename){
    if ( file.exists(Top500filename) ) {
        df<-read.csv(Top500filename, stringsAsFactors=FALSE)
        ## check if the data frame contains the column power
        #if ("power" %in% names(df)) {
            # add a column containing the list year and month
            # assumes Top500filename is of format YYYYMM
            df$list.year<-substr(Top500filename,1,4)
            df$list.month<-substr(Top500filename,5,6)
            # calculate the  ratio
         #   df$ratio <- df$r.max/df$power
            df$ratio <- df$r.max / df$number.of.processors
            return (df)
        #}
    }
}

##############################################################################
## create the list containing the names of the files 
##       containing the Top 500 lists between start year and end year
##############################################################################

filelist<-CreateFileList(start.year,end.year)
work.dir<-getwd()
setwd(data.dir)

system.time(
    Top500.df <- lapply(filelist,ReadTop500df)
)

setwd(work.dir)

## Trying out plots

with (top500.df[[1]],
      plot(pch=20,
           number.of.processors,
           r.max,col=as.factor(area.of.installation)))
with(top500.df[[1]], 
     legend("topright",pch=20, 
            col=as.factor(area.of.installation),
            legend=unique(area.of.installation)))

## Note from list Nov 20133 onwards, area.of.installation only has
## a number and not character string

with(Top500.df[[37]], 
     plot(r.max, n.max, pch=19, 
                           col=as.factor(area.of.installation),
                           main=paste(list.year[1],list.month[1],sep=" ")
     )
)
with(Top500.df[[37]], 
     legend("top",unique(area.of.installation), 
            fill=as.factor(unique(area.of.installation)),
            
                           )
)




