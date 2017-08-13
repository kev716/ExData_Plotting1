createPlot2 <- function() {
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
  
  # Create plot with y-axis label
  
  plot(powerRead$dateTime, powerRead$Global_active_power, type="l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  
  # Create png file from plot
  
  dev.copy(png, "plot2.png")
  dev.off()
}