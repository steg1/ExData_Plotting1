# This is part of Assignment 1, Exploratory Data Analysis.  In this assignment, we create four separate plots, with one R file creating one plot.

# I am using data from the UC Urvine Machine Learning Repository: Electric power consumption.  The coursera website describes
#    this as "Measurements of electric power consumption in one household with a one-minute sampling rate over a period 
#    of almost 4 years. Different electrical quantities and some sub-metering values are available."

# This script does the following:
#  Imports the above data from a file
#  Subsets out the relevant data to our needs (1-2 Feb 2007)
#  Converts character data to numeric data so we can plot it
#  Converts date information to usable date types so we can plot it
#  Opens the relevant PNG display device
#  Plots the plot to that device
#  Closes the device.


#####################################

#Import the data
###   Use Lubridate to format our date-time.
library(lubridate)

###   Set working directory to where the data lives.
setwd("H:/BigStegShare/COURSERA/DataScience/Exploratory Data Analysis/")

###   Read in data.
consump <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", as.is = TRUE, stringsAsFactors = FALSE)

#Subset out the dates we care about for this exercise- 01 and 02 FEB 2007
subconsump <- transform(subset(consump, Date=="1/2/2007" | Date=="2/2/2007"))

#Convert relevant character fields to numeric.  I didn't do this on import because there were some "?" values that were causing problems.
subconsump$Global_active_power <- as.numeric(subconsump$Global_active_power)
subconsump$Global_reactive_power <- as.numeric(subconsump$Global_reactive_power)
subconsump$Voltage <- as.numeric(subconsump$Voltage)
subconsump$Global_intensity <- as.numeric(subconsump$Global_intensity)
subconsump$Sub_metering_1 <- as.numeric(subconsump$Sub_metering_1)
subconsump$Sub_metering_2 <- as.numeric(subconsump$Sub_metering_2)
subconsump$Sub_metering_3 <- as.numeric(subconsump$Sub_metering_3)

#Create our proper date-time stamp for the time series.
subconsump$DateTime <- dmy_hms(paste(subconsump$Date,subconsump$Time))

# credit to anusha in discussion forum for strptime() usage
# https://www.coursera.org/learn/exploratory-data-analysis/discussions/O8NxdrY-EeWF6gpqp4BTmQ

#########################
#2... Open the PNG device
png("./plot2.png", width = 480, height = 480)
plot(subconsump$DateTime, subconsump$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
lines(subconsump$DateTime, subconsump$Global_active_power, lty = 1)

#close the PNG
dev.off()

