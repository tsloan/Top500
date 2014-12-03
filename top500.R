#############################################################################
## Download Supercomputer top500 XML list from http://www.top500.org/
##
#############################################################################
library(XML)

#############################################################################
## create the list containing the names of the files containing
## the Top 500 lists between 1993 and 2013
##############################################################################
filelist<-character(0)
for (i in 1993:2013){
    filelist<-c(filelist, paste(i,"06",sep=""),paste(i,"11",sep=""))
}

#############################################################################
## ~Top500dataframe: This function downloads the XML for a specfied 
##      year-month (YYYYMM) Top500 list and returns it as a data frame 
#############################################################################
Top500dataframe <- function(Top500list){
    fileURL=paste(
        "http://s.top500.org/static/lists/xml/TOP500_", 
        Top500list,"_all.xml",sep="")
    doc<-xmlTreeParse(fileURL, useInternal=TRUE)
    df<-xmlToDataFrame(doc, stringsAsFactors=FALSE)
}

##############################################################################
## use lapply to download the file for each Top500 list and put in a 
## dataframe.
## The code below returns a list of data frames.
##############################################################################
print(
    system.time(
        Top500.df<-lapply(filelist,Top500dataframe)
        )
)

## If you do something with power then it is interesting because not all years
## have the power


TotalPower<-function(year.df){
    # check to see if the data frame has the power variable
    if ( length(grep("power",names(year.df))) > 0 ){
        # find the number of NAs
        sum(is.na(as.numeric(year.df$power)))    
    }
    else{
        0
    }
}

x<-TotalPower(Top500.df[[42]])
print(paste("x = ",x))

x<-TotalPower(Top500.df[[1]])
print(paste("x = ",x))





##  and extract the number of systems in each country for that
##  year
##

## (note from a parallel point of view, the network will likely be 
##  the bottleneck)
##
## Bring out the data together to create a 2D matrix
## with list of countries and year as the 2 dimensions
## 

## Create a dataframe of size (2014-1993+1)*2 by nCountries
## This will mean finding  out in total how many countries are 
## across all years.


## Fill the data frame row by row with the values for each year
## This may mean doing an rbind - can this be done in parallel?
## ie since the resulting array can just be sorted in necessary
