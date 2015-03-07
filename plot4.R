## `plot1` reads the relevant data from household_power_consumption.txt,
## creates the required plot using the base plotting system and saves
## the plot as the .png file "plot1.png"


## Initial read procedure reads first 50 rows of data to determine column classes
initial <- read.table("./household_power_consumption.txt", 
                      header = TRUE, sep = ";", nrows = 50)
classes <- sapply(initial, class)
## Read full data set with column classes specified
data <- read.table("./household_power_consumption.txt",
                   header = TRUE, sep = ";", na.strings = "?",
                   colClasses = classes, nrows = 2076000,
                   comment.char = "")
rm("initial")
rm("classes")

## Redefine data set as the subset consisting of the variables 
## from Date==1/2/2007 to Date==2/2/2007
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

## Create the variable datetime by combining the variables Date and Time using
## `strptime`
data$Date <- paste(data$Date, data$Time)
data$Date <- strptime(data$Date, "%d/%m/%Y %H:%M:%S")
colnames(data)[1] <- "datetime"

## Launch PNG graphics device, create plot and send plot to file plot4.png
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2,2), mar = c(4,4,4,1))

plot(data$datetime, data$Global_active_power, type = "l",
     main = NULL, xlab = "", ylab = "Global Active Power")

plot(data$datetime, data$Sub_metering_1, type = "l",
     main = NULL, xlab = "", ylab = "Energy sub metering")
points(data$datetime, data$Sub_metering_2, type = "l", col = "red")
points(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lwd = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

plot(data$datetime, data$Voltage, type = "l",
     main = NULL, xlab = "datetime", ylab = "Voltage")

plot(data$datetime, data$Global_reactive_power, type = "l",
     main = NULL, xlab = "datetime", ylab = "Global_reactive_power")

dev.off()