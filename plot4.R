## Coursera Peer Assignment 
## Course 04 Exploratory data analysis
## WEEK1 - PLOT4

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
par(mfrow=c(2,2))
with(subSet, {
    #PLOT(1,1)
    par(mar=c(5.1,5.1,4.1,2.1))
    plot(dateTime, Global_active_power ,type="l", ylab="Global Active Power", xlab = "") 
    #PLOT(1,2)
    par(mar=c(5.1,4.1,4.1,2.1))
    plot(dateTime, Voltage, ylab="Voltage", xlab = "datetime",type = "l") 
    #PLOT(2,1)
    par(mar=c(5.1,5.1,4.1,2.1))
    plot(dateTime, Sub_metering_1, ylab="Energy sub metering",xlab="",type="l",col="black")
    lines(dateTime, Sub_metering_2, type="l",col="red")
    lines(dateTime, Sub_metering_3, col="blue",type="l")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty=1, lwd=2, col=c("black", "red", "blue"),cex = .7,bty = "n")
    #PLOT(2,2)
    par(mar=c(5.1,4.1,4.1,2.1))
    plot(dateTime, Global_reactive_power,xlab = "datetime",ylab = "Global_reactive_power",type = "l") 
})
#create figure png
dev.copy(png, file = "plot4.png",height=480,width=480)
dev.off()
