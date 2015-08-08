if(!file.exists("EPC_DAT")){dir.create("EPC_DAT")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./EPC_DAT/EPC_Dataset.zip")
dateDownloaded <- date()
library(downloader)
library(data.table)

unzip(zipfile="./EPC_DAT/EPC_Dataset.zip", exdir="./EPC_DAT")
EPC <- read.table("./EPC_DAT/household_power_consumption.txt", header=T, sep=";", na.strings = "?")
EPC$Date <- as.Date(EPC$Date, format="%d/%m/%Y")
EPCDT <- EPC[(EPC$Date=="2007-02-01") | (EPC$Date=="2007-02-02"),]
EPCDT <- transform(EPCDT, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

# plot 1
hist(EPCDT$Global_active_power, main = "Global Active Power", ylab = "Frequency", 
     xlab = "Global Active Power (kilowatts)", col = "red",  ylim = c(0, 1200), xlim = c(0, 6))
dev.copy(png, file = "plot1.png", height=480, width=480)
dev.off()

# plot 2
plot(EPCDT$timestamp, EPCDT$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l" )
dev.copy(png, file = "plot2.png", height=480, width=480)
dev.off()

#plot3
par(mar = c(4,4,2,2))
plot(EPCDT$timestamp, EPCDT$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(EPCDT$timestamp, EPCDT$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "red")
points(EPCDT$timestamp, EPCDT$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1), lwd = c(1, 1), bty="n", cex=.5)
dev.copy(png, file = "plot3.png", height=480, width=480)
dev.off()

par(mar = c(4,4,2,2))
par(mfrow = c(2, 2))

# plot 4
plot(EPCDT$timestamp, EPCDT$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")


plot(EPCDT$timestamp, EPCDT$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")


plot(EPCDT$timestamp, EPCDT$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
points(EPCDT$timestamp, EPCDT$Sub_metering_2, type = "l", xlab = "", ylab = "Sub_metering_2", 
       col = "red")
points(EPCDT$timestamp, EPCDT$Sub_metering_3, type = "l", xlab = "", ylab = "Sub_metering_3", 
       col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", 
                                                                        "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1), lwd = c(1, 1), bty="n", cex=.5 )

plot(EPCDT$timestamp, EPCDT$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power", ylim = c(0, 0.5))
dev.copy(png, file = "plot4.png", height=480, width=480)
dev.off()Enter file contents here
