readPowerData <- function() {
    
    # assuming that the data is downloaded and extracted into the current working folder
    powerConsumptionFileName <- "./household_power_consumption.txt"
    
    
    powerConsumptionData <- read.table(powerConsumptionFileName, header = TRUE, sep=";", na.strings="?",
                                       col.names = c("Date", "Time", "GlobalActivePower",
                                                     "GlobalReactivePower", "Voltage", "GlobalIntensity",
                                                     "Submetering1", "Submetering2", "Submetering3"),
                                       colClasses = c("character", "character", "numeric",
                                                      "numeric", "numeric", "numeric", 
                                                      "numeric", "numeric", "numeric"))
    
    powerConsumptionDataSubset <- with(subset(powerConsumptionData, Date == "1/2/2007" | Date == "2/2/2007"),
                                       data.frame(Timestamp = strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"),
                                                  GlobalActivePower, GlobalReactivePower, Voltage,
                                                  GlobalIntensity, Submetering1, Submetering2, Submetering3))
    
    # return the subset data
    powerConsumptionDataSubset
}


powerData <- readPowerData()
png(filename = 'plot3.png', width = 480, height = 480)

plot(powerData$Timestamp, powerData$Submetering1, type="n", xlab="", ylab="Energy sub metering") # build the empty base plot

points(powerData$Timestamp, powerData$Submetering1, type="l", col="black")
points(powerData$Timestamp, powerData$Submetering2, type="l", col="red")
points(powerData$Timestamp, powerData$Submetering3, type="l", col="blue")

legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
