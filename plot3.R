filePath <- "D:/Code/R/Coursera/Exploratory Data Analysis/exdata_data_household_power_consumption/"
nrows = 2075300
startDate <- as.Date("2007-02-01")
endDate <- as.Date("2007-02-02")

## Read and preprocess data

filename <- paste(filePath, "household_power_consumption.txt", sep="")
powData <- read.table(filename, sep=";", header=TRUE, comment.char=" ", nrows=nrows)
powData$Date <- as.Date(powData$Date, "%d/%m/%Y")
powData <- powData[powData$Date >= startDate & powData$Date <= endDate, ]
powData <- powData[!mapply(identical, as.character(powData$Sub_metering_1), "?"), ]
powData <- powData[!mapply(identical, as.character(powData$Sub_metering_2), "?"), ]
powData <- powData[!mapply(identical, as.character(powData$Sub_metering_3), "?"), ]

## Plot energy sub-metering data

subData1 <- as.numeric(powData$Sub_metering_1)
subData2 <- as.numeric(powData$Sub_metering_2)
subData3 <- as.numeric(powData$Sub_metering_3)

timeVec <- as.POSIXlt(paste(powData$Date, powData$Time))

plot(timeVec ,subData1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(timeVec, subData2, type="l", col="red")
lines(timeVec, subData3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, inset=c(0.12, 0.01), box.col="white")

## Save as png

dev.copy(png, file="plot3.png")
dev.off()