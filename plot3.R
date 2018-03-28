## Coursera Peer Assignment 
## Course 04 Exploratory data analysis
## WEEK1 - PLOT3

## Upload needed libraries
library(dplyr)
Sys.setlocale(locale="en_US")
##################################################################################################
## Upload dataset
# NOTE: Required memory (2,075,259 x 9 x 8) / 2^20 = 142,5 Mbyte

#Setting path, dowload files, unzip
#path of zip file
fileurl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filezip <- "household_power_consumption.zip"
fileName <- "household_power_consumption.txt"

#download zip file
if(!file.exists(fileName)) {
  download.file(fileurl, filezip)
  #unzip file
  unzip(zipfile = filezip) }

#####################################################################################
## Read dataset household_power_consumption.txt
Mydata <- read.table(fileName, sep = ";",header = TRUE, na.strings = "?",
                     colClasses = c("character", "character", "numeric", 
                                    "numeric", "numeric", "numeric", "numeric", 
                                    "numeric", "numeric"))
#subset from Mydata only 1/2/2007 and 2/2/2007
subSet <- Mydata[Mydata$Date %in% c("1/2/2007","2/2/2007") ,]
#creating data_time variable
subSet$dateTime <- strptime(paste(subSet$Date, subSet$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
power <- subSet$Global_active_power
#reset device in case of previuos error
dev.off()

#####################################################################################
## PLOT
par(mar=c(5.1,5.1,4.1,2.1))
with(subSet, {
    plot(dateTime, Sub_metering_1,type="l",col="black", ylab = "Energy sub metering")
    lines(dateTime, Sub_metering_2,type="l",col="red")
    lines(dateTime, Sub_metering_3,type="l",col="blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty=1, lwd=2.5, col=c("black", "red", "blue"),cex = 1) 
})
#create figure png
dev.copy(png, file="plot3.png", width=480, height = 480)
dev.off()
