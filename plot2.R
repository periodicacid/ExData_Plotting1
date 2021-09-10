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

## Plot global active power vs time across the two days in question

globActPow <- as.numeric(powData$Global_active_power)
timeVec <- as.POSIXlt(paste(powData$Date, powData$Time))
plot(timeVec, globActPow, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Save the plot to a png file

dev.copy(png, file="plot2.png")
dev.off()