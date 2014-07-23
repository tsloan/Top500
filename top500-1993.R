#############################################################################
## Download top500 XML list from 1993
##
## Possible instructions at
## http://stackoverflow.com/questions/2067098/how-to-transform-xml-data-into-a-data-frame
##
#############################################################################
library(XML)


fileURL="http://s.top500.org/static/lists/xml/TOP500_199306_all.xml"
doc<-xmlTreeParse(fileURL, useInternal=TRUE)
df1993<-xmlToDataFrame(doc, stringsAsFactors=FALSE)
names(df1993)
plot(df1993$rank)

fileURL="http://s.top500.org/static/lists/xml/TOP500_201306_all.xml"
doc<-xmlTreeParse(fileURL, useInternal=TRUE)
df2013<-xmlToDataFrame(doc, stringsAsFactors=FALSE)
names(df2013)
plot(df2013$rank)

## For each year since its inception, find out how many systems each country 
## had in the top500

unique(df2013$country)
summary(as.factor(df2013$country))
barplot(table(df2013$country),las=2) #las sets label orientation

#############################################################################
## create the list containing the names of the files containing
## the Top 500 lists between 1993 and 2014
##############################################################################
filelist<-character(0)
for (i in 1993:2014){
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
        Top500.df<-lapply(filelist[1:2],Top500dataframe)
        )
)


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
