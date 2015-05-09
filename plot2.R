# This file constructs a barplot from data on "Global Active Power"
# It assumes a file called household_power_consumption.txt with the data in the source folder

# Imports
library("plyr")

# 1. Read the data
data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = c('?'))
relevant_data <- data[data$Date == "1/2/2007" |data$Date == "2/2/2007",]
remove(data) #remove the large source dataset which is no longer needed from memory

# 2. Prepare the data (create time series)
gap_time_series <- ts(relevant_data$Global_active_power, frequency = 1440)

# 3. Plot the results and output to png file
png("plot2.png")
plot(gap_time_series, main = "Global Active Power", ylab = "Global Active Power (kilowatts)", xaxt = 'n')
axis(1, at = c(1,2,3), labels = c("Thu", "Fri", "Sat"))
dev.off()