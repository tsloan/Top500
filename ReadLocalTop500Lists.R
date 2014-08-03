#############################################################################
##
## ReadLocalTop500Lists.R 
##
## This script reads locally stored copies of Top500 supercomputer lists
## previously downloadedfrom the Supercomputer Top 500 site.
##
################################################################################  

source("Top500-Helper.R") # helper functions

start.year <- 1993 # Initial year to read the Top 500 list 
end.year <- 2013 # Final year to read the Top 500 list
data.dir <- "data-Top500-lists"  # local directory where the lists are stored

##############################################################################
## ~ReadTop500file - This function takes a Top 500 filename, checks if
##    a file of that name exists in the the local directory, reads
##    that file into a data frame, and adds two columns, the first of which
##    indicates the year of the Top500 list and the second of which
##    indicates the month of the Top 500 list
##  
##############################################################################
ReadTop500file <- function(Top500filename){
    if (file.exists(Top500filename)){
        df<-read.csv(Top500filename, stringsAsFactors=FALSE)
        ## need to add a column containing the list year and month
        ## assumes Top500filename is of format YYYYMM
        df$list.year<-substr(Top500filename,1,4)
        df$list.month<-substr(Top500filename,5,6)
        df
    }
}

##############################################################################
##
## ~ReadTop500Lists
##
##############################################################################
ReadTop500Lists<-function(dir, start.year, end.year){
    work.dir<-getwd()
    setwd(dir)
    ## create the names of the files containing the Top500 lists
    Top500FilenameList <- CreateFileList(start.year, end.year)
    
    top500.df<-lapply(Top500FilenameList, ReadTop500file)
    setwd(work.dir)
    #########################################################################
    ## return the list of data frames containing the contents
    ## of the Top500 files
    
    top500.df 
         
}

# test run
top500.df<-ReadTop500Lists(paste("./",data.dir,sep=""),
                           start.year,end.year)

