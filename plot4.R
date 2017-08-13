createPlot4 <- function() {
  library(dplyr)
  
  # Check if directory exists, download & extract if it doesn't
  
  if(!file.exists("exdata%2Fdata%2Fhousehold_power_consumption.zip")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url,
                  destfile="exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  method="curl", 
                  mode="wb") 
    unzip(zipfile = "exdata%2Fdata%2Fhousehold_power_consumption.zip")
  }
  
  # Read rows for 2/1/2007 & 2/2/2007 only to save memory, save into powerRead
  
  powerRead <- read.table("household_power_consumption.txt", sep=";", nrows=2879,
                          skip=66638, na.strings="?")
  
  # Add names for powerRead
  
  names(powerRead) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                        "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                        "Sub_metering_3")
  
  # Combine Date and Time fields together and format as datetime
  
  powerRead <- mutate(powerRead, dateTime = paste(Date, Time, sep=" "))
  powerRead$dateTime <- strptime(powerRead$dateTime, format = "%d/%m/%Y %H:%M:%S")
  
  # Create png file for plots
  
  png(filename="plot4.png", width=480, height=480, units="px")
  
  # Create 2 X 2 grid for plots
  
  par(mfcol=c(2,2))
  
  # Create first plot
  
  plot(powerRead$dateTime, powerRead$Global_active_power, type="l", 
       ylab = "Global Active Power", xlab = "")
  
  # Create second plot
  
  plot(powerRead$dateTime, powerRead$Sub_metering_1, type="l", 
       ylab = "Energy sub metering", xlab = "")
  lines(powerRead$dateTime, powerRead$Sub_metering_2, type="l", col="red")
  lines(powerRead$dateTime, powerRead$Sub_metering_3, type="l", col="blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lty = 1, y.intersp=1)
  
  # Create third plot
  
  plot(powerRead$dateTime, powerRead$Voltage, type="l", 
       ylab = "Voltage", xlab = "")
  
  # Create fourth plot
  
  plot(powerRead$dateTime, powerRead$Global_reactive_power, type="l", 
       ylab = "Global_reactive_power", xlab = "")
  
  # Finish png file
  
  dev.off()
}