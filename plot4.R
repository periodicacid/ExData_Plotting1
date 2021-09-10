filePath <- "D:/Code/R/Coursera/Exploratory Data Analysis/exdata_data_household_power_consumption/"
nrows = 2075300
startDate <- as.Date("2007-02-01")
endDate <- as.Date("2007-02-02")

## Read and preprocess data

filename <- paste(filePath, "household_power_consumption.txt", sep="")
powData <- read.table(filename, sep=";", header=TRUE, comment.char=" ", nrows=nrows)
powData$Date <- as.Date(powData$Date, "%d/%m/%Y")
powData <- powData[powData$Date >= startDate & powData$Date <= endDate, ]
powData <- powData[!mapply(identical, as.character(powData$Global_active_power), "?"), ]
powData <- powData[!mapply(identical, as.character(powData$Global_reactive_power), "?"), ]
powData <- powData[!mapply(identical, as.character(powData$Voltage), "?"), ]
powData <- powData[!mapply(identical, as.character(powData$Sub_metering_1), "?"), ]
powData <- powData[!mapply(identical, as.character(powData$Sub_metering_2), "?"), ]
powData <- powData[!mapply(identical, as.character(powData$Sub_metering_3), "?"), ]

## Plot graphs
globActPow <- as.numeric(powData$Global_active_power)
globReactPow <- as.numeric(powData$Global_reactive_power)
voltage <- as.numeric(powData$Voltage)

subData1 <- as.numeric(powData$Sub_metering_1)
subData2 <- as.numeric(powData$Sub_metering_2)
subData3 <- as.numeric(powData$Sub_metering_3)

timeVec <- as.POSIXlt(paste(powData$Date, powData$Time))

par(mfrow= c(2, 2))

## Subplot 1
plot(timeVec, globActPow, type="l", ylab="Global Active Power", xlab="")

## Subplot 2
plot(timeVec, voltage, type="l", ylab="Voltage", xlab="datetime")

## Subplot 3
plot(timeVec ,subData1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(timeVec, subData2, type="l", col="red")
lines(timeVec, subData3, type="l", col="blue")
leg=legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, plot=FALSE)
legx <- leg$rect$left + leg$rect$w / 1.9
legy <- leg$rect$top
legend(x=legx, y=legy, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.7)

## Subplot 4
plot(timeVec, globReactPow, type="l", ylab="Global_reactive_power", xlab="datetime")

## Save as png

dev.copy(png, file="plot4.png")
dev.off()