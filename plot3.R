#This R script is designed to plot "Global Active Power" histogram
##Dowload Electric Power consumption dataset
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "ElectPowerDataset.zip")

##unzip downloaded file
unzip(zipfile = "ElectPowerDataset.zip")

##read file into R
T1 <- read.csv("household_power_consumption.txt", sep=";")

##filter for two days (2007-02-01 and 2007-02-02)
###check if dplyr package is installed or need installation
check_package <- function(x){
        is.element(x, installed.packages()[,1])
}
if (!check_package("dplyr")){
        install.packages("dplyr")
}
library(dplyr)
if (!check_package("lubridate")){
        install.packages("lubridate")
}
library(lubridate)
T2 <- filter(T1, Date == "1/2/2007" | Date =="2/2/2007")

##convert Global Active Power to Numeric and replace "?" to be ""
T2$Global_active_power <- as.numeric(gsub("/?","",T2$Global_active_power))

##convert Date & Time to dateTime
T2$DateTime <- dmy(T2$Date) + hms(T2$Time)


##plot design
png("plot3.png", width = 480, height = 480)
plot(T2$DateTime, T2$Sub_metering_1, type = "l", xlab = '', ylab = "Energy sub metering")
lines(T2$DateTime, T2$Sub_metering_2, col = "red")
lines(T2$DateTime, T2$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = "solid")
dev.off()

