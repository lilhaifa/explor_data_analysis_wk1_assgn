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

# now, start the plot #2 - line plot for global active power over the 2 days 
# default file size = 480x480 pixels

png(file="plot2.png")
with(hpc_raw_B,plot(Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",axes=FALSE))
axis(1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))
axis(2)
dev.off()

quit(status=0)


