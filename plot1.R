# Read data from the downloaded data file
powerData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
pData <- powerData

# Extract data only from target dates
dates <- pData$Date == "1/2/2007" | pData$Date == "2/2/2007"
pData <- pData[dates,]
pData$Date <- as.Date(pData$Date, format = "%d/%m/%Y")

# Plot and save histogram of Global Active Power data
hist(pData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()