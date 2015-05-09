# This file constructs a barplot from data on "Global Active Power"
# It assumes a file called household_power_consumption.txt with the data in the source folder

# Imports
library("plyr")

# 1. Read the data
data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = c('?'))
relevant_data <- data[data$Date == "1/2/2007" |data$Date == "2/2/2007",]
remove(data) #remove the large source dataset which is no longer needed from memory

# 2. Prepare the data (Create the frequencies grouped by increments of 0.5)
rounded_gap <- round_any(relevant_data$Global_active_power, 0.5, ceiling)
frequencies_gap <- table(rounded_gap)

# 3. Plot the results and output to png file
png("plot1.png")
barplot(frequencies_gap, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", space = 0, xaxt = 'n')
axis(1, at = seq(0,12, by = 4), labels =  as.character(seq(0,6, by = 2)))
dev.off()


