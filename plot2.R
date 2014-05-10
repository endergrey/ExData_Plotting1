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

# Plot and save time series of Global Active Power data
with(pData, plot(DTG, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.copy(png, file = "plot2.png")
dev.off()