##############################################################################
##
## DownloadTop500lists.R
##
##  This script downloads from the Supercomputer Top 500 site, all the Top 500
##  list between the specified dates and stores them in a local directory.
##
##############################################################################

library(XML)
start.year <- 1993 # Initial year to download Top 500 list for 
end.year <- 2013 # Final year to download Top 500 list for

##############################################################################
## create the list containing the names of the files 
##       containing the Top 500 lists between start year and end year
##############################################################################

filelist<-CreateFileList(start.year,end.year)

###############################################################################
## Create directory to hold the data
###############################################################################

data.dir <- "data-Top500-lists"

if (!file.exists(data.dir)){
    
    dir.create(data.dir)
    
    # get the current working directory
    workdir <- getwd()
    # set the working directory to data.dir
    setwd(paste("./",data.dir,sep=""))
    
    ############################################################################
    ## use lapply to download the file for each Top500 list and put it into a 
    ## file
    ############################################################################
    print(
        system.time(
            lapply(filelist,Top500FileDownload)
        )
    )
    ###########################################################################
    ## Add a file indicating the date the data was downloaded.
    ###########################################################################
    
    write(date(),file="DateDataDownloaded")

    ## reset the working directory
    setwd(workdir)

}


