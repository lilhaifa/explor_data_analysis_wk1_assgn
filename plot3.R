#!/usr/local/bin/Rscript

library(readr)
library(lubridate)
library(dplyr)
library(tidyr)

# load the data from the data file
hpc_raw <- read_delim("household_power_consumption.txt",delim=";",na="?",col_types="ccddddddd")

# filter the dates needed - 01-Feb-2007 and 02-Feb-2007
hpc_raw_B <- filter(hpc_raw,Date == "1/2/2007" | Date == "2/2/2007")

# convert the Date variable to Date type from character
hpc_raw_B$Date <- as.Date(hpc_raw_B$Date,format="%d/%m/%Y")

# capture the indices of the variable Time where the day starts, i.e., 00:00:00. These indices will be needed to label the x-axis
# The command below returns c(1,1441)
day_start_idx <- grep("^00:00:00$",hpc_raw_B$Time)

# Command below returns the total number of rows which is also = the last index
# the value = 2880
last_idx = length(hpc_raw_B$Time)

# now, start the plot #3 - line plots for sub metering 1,2 and 3 over the 2 days 
# the default pixel size = 480 x 480 which is what is needed

png(file="plot3.png")
with(hpc_raw_B,plot(Sub_metering_1,type="n",xlab="",ylab="Energy sub metering",axes=FALSE))
lines(hpc_raw_B$Sub_metering_1,type="l",col="black")
lines(hpc_raw_B$Sub_metering_2,type="l",col="red")
lines(hpc_raw_B$Sub_metering_3,type="l",col="blue")
axis(1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))
axis(2)
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

quit(status=0)


