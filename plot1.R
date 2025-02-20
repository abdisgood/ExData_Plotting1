## This file contains the script to generate plots for
## the course "Exploratory Data Analysis", week 1 project
## assignment.

        ## Load required libraries
        library(lubridate)
        library (dplyr)
        
        ## Access data source to read data into R object
        url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        if(!dir.exists("./dataset")) {dir.create("./dataset")}
        download.file (url, destfile = "./dataset/data.zip")
        unzip("./dataset/data.zip", exdir = "./dataset")
        file<-"./dataset/household_power_consumption.txt"
        
        ## data = readLines(con= file, grep("1/2/2007",readLines(file)
        
        range <- data.frame(grep("^1/2/2007|^2/2/2007",
                                readLines(file)))
        
        data <- read.table(file,
                           skip = range[1,1]-1,
                           nrow = nrow(range),
                           sep =";")
        names(data)<- c("Date","Time","Global_active_power",
                        "Global_reactive_power","Voltage",
                        "Global_intensity","Sub_metering_1",
                        "Sub_metering_2","Sub_metering_3")
        
        unlink("./dataset/data.zip")
        unlink(file)

        ## Strip date and time variable into table single variable
        data$dt <- parse_date_time(paste(data$Date,data$Time),
                                        "%d/%m/%y% h:%m:%s")
        
        ## Generate frequency histogram for Global Active Power
        par (mar=c(2,2,2,2),mfcol=c(1,1))
        hist(data$Global_active_power,col="red",
             breaks=11,
             main = "Global Active Power",
             xlab = "Global Active Power (kilowatts)")
        
        ## Export to PNG graphic device
        dev.copy(png,"plot1.png", 
                 width=480, 
                 height =480)
        dev.off()
        