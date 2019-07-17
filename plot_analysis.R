download <- "Electric Power Consumption"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dir <- "./data/Electric Power.zip"
if(!file.exists(dir)){
  download.file(fileURL, dir,mode = "wb")
}
unzip(dir,files = NULL,exdir = ".")

hh_cons <- read.table('./data/Electric Power/household_power_consumption.txt', header = TRUE, sep = ";", stringsAsFactors = FALSE)
hh_cons$DateTime <- paste(hh_cons$Date,hh_cons$Time)
hh_cons$Date <- as.Date(hh_cons$Date, format = "%d/%m/%Y")
hh_cons$DateTime <- strptime(hh_cons$DateTime, format = "%Y-%m-%d %H:%M:%S")
hh_cons[,3:8] <- lapply(hh_cons[,3:8],as.numeric)
hh_cn <- subset(hh_cons, Date == "2007-02-01"|Date == "2007-02-02")

#plot 1
png(filename = "plot1.png")
hist(hh_cn$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)", ylim = c(0,1200))
dev.off()

#plot 2
png(filename = "plot2.png")
plot(hh_cn$DateTime,hh_cn$Global_active_power, type = 'l',ylab = "Global Active Power(kilowatts)", xlab = "Days")
dev.off()

#Plot 3
png(filename = "plot3.png")
plot(hh_cn$DateTime, hh_cn$Sub_metering_1, type = 'l', col = "blue", lty = 1, xlab = "Date", ylab = "Energy sub metering")
lines(hh_cn$DateTime, hh_cn$Sub_metering_2, col = "red", lty = 2)
lines(hh_cn$DateTime, hh_cn$Sub_metering_3, col = "dark red", lty = 3)
legend("topright", legend = c("Submetering 1", "Submetering 2", "Submetering 3"),col = c("blue", "red", "dark red"), lty = 1:2, cex = 0.8)
dev.off()

#Plot 4
png(filename = "plot4.png")
par(mfrow = c(2,2), mar = c(4,4,2,2))
plot(hh_cn$DateTime,hh_cn$Global_active_power, type = 'l',ylab = "Global Active Power(kilowatts)", xlab = "Days")
plot(hh_cn$DateTime, hh_cn$Sub_metering_1, type = 'l', col = "blue", lty = 1, xlab = "Date", ylab = "Energy sub metering")
lines(hh_cn$DateTime, hh_cn$Sub_metering_2, col = "red", lty = 2)
lines(hh_cn$DateTime, hh_cn$Sub_metering_3, col = "dark red", lty = 3)
legend("topright", legend = c("Submetering 1", "Submetering 2", "Submetering 3"),col = c("blue", "red", "dark red"), lty = 1:2, cex = 0.8)
plot(hh_cn$DateTime,hh_cn$Voltage, type ='l', xlab = "Date", ylab = "Voltage")
plot(hh_cn$DateTime, hh_cn$Global_reactive_power, type = "l", xlab = "Date", ylab = "Global Reactive Power")
dev.off()

