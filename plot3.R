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

# Plot and save time series of energy sub metering data
with(pData, plot(DTG, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(pData, lines(DTG, Sub_metering_2, col = "red"))
with(pData, lines(DTG, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png")
dev.off()