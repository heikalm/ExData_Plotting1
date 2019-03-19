library(data.table)

filename <- "data/EDAweek1.zip"

if (!dir.exists("data")) {
        dir.create("data")
}

# Check for file and unzip
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, filename, method="curl")
        unzip(filename, exdir="data")
}  

#read data, format date and time, and get relevant date subset
dat <- read.table("data/household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
my_dat <- subset(dat, Date>="2007-2-1" & Date<="2007-2-2")
my_dat$DateTime <- as.POSIXct(paste(my_dat$Date, my_dat$Time))

#draw histogram
hist(my_dat$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# export to png
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

