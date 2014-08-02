Top500
======

This repository contains R scripts for downloading and 
analysing data from the Supercomputing Top 500 lists at
http://www.top500.org/

The purpose of the task will be to find the 10 supercomputers with
be best ratio of R-max (Maximal LINPACK performance achieved) 
to power over the lifetime of the Top
500 list.

This involves the following steps.

1. Getting the data for each Top500 list from the Top 500 site and storing
it locally.  (The data is stored locally so that the students do not 
bombard the sites with requests).
    + See DownloadTop500Lists.R : downloads the lists and stores them locally
    + See ReadLocalTop500Lists.R: Reads the locally stored lists into a list 
                                  of data frames, adds the year and month of the
                                  list to the data frame

1. Examining the description of the lists to understand the format of the 
downloaded data and to identify the fields of interest. 

1. Examining the contents of the fields of interest to determine if their 
contents are valid.  Here graphs can be helpful.

1. The contents of the fields of interest will need to be converted to 
appropriate format and the required ratio derived from this.

1. Extract the top 10 machines with the highest Rmax per watt of power.

1. Profile the various stages using system.time

1. Use the R parallel library to try and improve the elapsed time performance of
any of the stages.

