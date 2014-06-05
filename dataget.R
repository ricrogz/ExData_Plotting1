# These functions are common to all plotX.R files,
# and therefore they are stored in this file,
# which is sourced at the beginning of each plotX.R

# General purpose download file:
# Checks existence of "fname", and if not present
# downloads "fileURL" and stores it as "fname"
dlFile <- function(fileURL, fname) {
    
    if(!file.exists(fname)) {
        print("Downloading...")
        if (.Platform$OS.type == "windows")
            download.file(fileURL, destfile=fname)
        else
            download.file(fileURL, destfile=fname, method="curl")
    }
    
    invisible(fname)
}

# Get the data, either downloading, preparing and storing a copy,
# or opening the stored copy
getData <- function() {
    
    # Storage name
    cleanFile <- "clean_data.csv"
    
    # If we have a stored copy, use this one
    if(file.exists(cleanFile)) {
        print("Reading data from cached file.")
        tbl <- read.csv(cleanFile)

    # If we do not have a copy...
    } else {    
        # urls & file names
        webFile   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        localZip  <- "household_power_consumption.zip"
        localFile <- "household_power_consumption.txt"
        
        # Download file from given url (as zip file)
        fname <- dlFile(webFile, localZip)
        print("Cleaning data...")
        
        # extract file from zip and return a connection
        con <- unz(localZip, localFile)
        
        # read in unzipped file. This would be faster with fread
        # but it is not done frequently, and this is quicker to write
        rawtbl <- read.table(con, header=T, sep=';', na.strings="?", row.names=NULL,
                          colClasses=c("character","character","numeric","numeric",
                                       "numeric","numeric","numeric","numeric","numeric")
                )

        # extract just the data we are interested in
        tbl <- rawtbl[rawtbl$Date == "1/2/2007" | rawtbl$Date == "2/2/2007",]
        
        # reassign row names
        rownames(tbl) <- NULL
        
        # write cached file to disk
        write.csv(tbl, cleanFile)
        print("Cleaning finished, clean data stored.")
    }
    
    # whether the file was cached or downloaded, properly convert Date/Time
    tbl$DateTime <- strptime(paste(tbl$Date, tbl$Time, sep = " "), "%e/%m/%Y %H:%M:%S")    
    invisible(tbl)
}