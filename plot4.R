# This file constructs a 2x2 panel of different plots
# It assumes a file called household_power_consumption.txt with the data in the source folder

# 1. Read the data
data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = c('?'))
relevant_data <- data[data$Date == "1/2/2007" |data$Date == "2/2/2007",]
remove(data) #remove the large source dataset which is no longer needed from memory

# 2. Prepare the data (create time series)
gap_time_series <- ts(relevant_data$Global_active_power, frequency = 1440)
volt_time_series <- ts(relevant_data$Voltage, frequency = 1440)
grp_time_series <- ts(relevant_data$Global_reactive_power, frequency = 1440)

sub_metering_1 <- ts(relevant_data$Sub_metering_1, frequency = 1440)
sub_metering_2 <- ts(relevant_data$Sub_metering_2, frequency = 1440)
sub_metering_3 <- ts(relevant_data$Sub_metering_3, frequency = 1440)

# 3. Plot the results and output to png file
png("plot4.png")
par(mfrow=c(2, 2))

plot(gap_time_series, ylab = "Global Active Power (kilowatts)", xaxt = 'n')
axis(1, at = c(1,2,3), labels = c("Thu", "Fri", "Sat"))

plot(volt_time_series, ylab = "Voltage", xaxt = 'n')
axis(1, at = c(1,2,3), labels = c("Thu", "Fri", "Sat"))

ts.plot(sub_metering_1, sub_metering_2, sub_metering_3, gpars = list(xaxt = 'n'),  ylab = "Energy sub metering", col = c("black", "red", "blue"))
axis(1, at = c(1,2,3), labels = c("Thu", "Fri", "Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

plot(grp_time_series, ylab = "Global_reactive_power", xaxt = 'n')
axis(1, at = c(1,2,3), labels = c("Thu", "Fri", "Sat"))

dev.off()