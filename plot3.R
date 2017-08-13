createPlot3 <- function() {
  library(dplyr)
  
  if(!file.exists("exdata%2Fdata%2Fhousehold_power_consumption.zip")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url,
                  destfile="exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  method="curl", 
                  mode="wb") 
    unzip(zipfile = "exdata%2Fdata%2Fhousehold_power_consumption.zip")
  }
  powerRead <- read.table("household_power_consumption.txt", sep=";", nrows=2879,
                      skip=66638, na.strings="?")
  names(powerRead) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                    "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                    "Sub_metering_3")
  
  powerRead <- mutate(powerRead, dateTime = paste(Date, Time, sep=" "))
  powerRead$dateTime <- strptime(powerRead$dateTime, format = "%d/%m/%Y %H:%M:%S")
  
  png(filename="plot3.png", width=480, height=480, units="px")
  
  plot(powerRead$dateTime, powerRead$Sub_metering_1, type="l", 
       ylab = "Energy sub metering", xlab = "")
  lines(powerRead$dateTime, powerRead$Sub_metering_2, type="l", col="red")
  lines(powerRead$dateTime, powerRead$Sub_metering_3, type="l", col="blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lty = 1)
  
  dev.off()
}