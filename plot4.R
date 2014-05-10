# Read data from the downloaded data file
powerData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
pData <- powerData

# Extract data only from target dates
dates <- pData$Date == "1/2/2007" | pData$Date == "2/2/2007"
pData <- pData[dates,]
pData$Date <- as.Date(pData$Date, format = "%d/%m/%Y")

# Convert to date/time format
pData$DTG <- paste(pData$Date, pData$Time)
pData$DTG <- as.POSIXct(strptime(pData$DTG, format = "%Y-%m-%d %H:%M:%S"))

# Plot and save multiple time series of power data
png(file = "plot4.png")
par(mfrow = c(2,2))
with(pData, {
  plot(DTG, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
  plot(DTG, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(DTG, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(DTG, Sub_metering_2, col = "red")
  lines(DTG, Sub_metering_3, col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(DTG, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()
