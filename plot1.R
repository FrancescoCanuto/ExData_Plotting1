## Coursera Peer Assignment 
## Course 04 Exploratory data analysis
## WEEK1 - PLOT1

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
hist(power, main = "Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
#create figure png
dev.copy(png,file="plot1.png",height=480,width=480)
dev.off()
