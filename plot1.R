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
T2 <- filter(T1, Date == "1/2/2007" | Date =="2/2/2007")

##convert Global Active Power to Numeric and replace "?" to be ""
T2$Global_active_power <- as.numeric(gsub("/?","",T2$Global_active_power))

##plot design
hist(T2$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()

