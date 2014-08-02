#############################################################################
##
## Top500-Helper.R : This file contains various helper functions for this 
##      exercise
##
#############################################################################

##############################################################################
## ~CreatFileList: create a character containing the names of the files 
##       containing the Top 500 liss between start year and end year
##
##     This function makes the following assumptions
##     -  start.year and end. year contain a valid year
##     - if end.year is before start.year it swaps them round
##    
##############################################################################
CreateFileList<-function(start.year,end.year){
    # assumes a valid year is given
    flist<-character(0)
    if (end.year < start.year){
        #swap round
        tmp.year <- start.year
        start.year <- end.year
        end.year <- start.year
    }
    for (i in start.year:end.year){
        flist<-c(flist, paste(i,"06",sep=""),paste(i,"11",sep=""))
    }
    flist # return the vector of file names
}

#############################################################################
## ~Top500FileDownload: This function downloads the XML for a specfied 
##      year-month (YYYYMM) Top500 list and writes it out to a
##      file in the current directory. 
#############################################################################
Top500FileDownload <- function(Top500list){
    fileURL=paste(
        "http://s.top500.org/static/lists/xml/TOP500_", 
        Top500list,"_all.xml",sep="")
    doc<-xmlTreeParse(fileURL, useInternal=TRUE)
    df<-xmlToDataFrame(doc, stringsAsFactors=FALSE)
    write.csv(df,file=Top500list,row.names=FALSE)
    return 
}

