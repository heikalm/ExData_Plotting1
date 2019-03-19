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

#draw plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(my_dat, {
        plot(Global_active_power~DateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~DateTime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~DateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~DateTime, type="l", 
             ylab="Global Reactive Power (kilowatts)",xlab="")
})

# export to png
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

