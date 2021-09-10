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

## Extract data for global active power and generate a histogram

globActPow <- as.numeric(powData$Global_active_power)
hist(globActPow, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

## Save the plot to a png file

dev.copy(png, file="plot1.png")
dev.off()