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

## Create a list with all the XML file names
## use lapply across each of these lists to download the file
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
