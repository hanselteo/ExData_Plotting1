## `plot2` reads the relevant data from household_power_consumption.txt,
## creates the required plot using the base plotting system and saves
## the plot as the .png file "plot2.png"


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

## Redefine data set as the subset consisting of the variables Date, Time and
## Global_active_power from Date==1/2/2007 to Date==2/2/2007
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", 
             c("Date", "Time", "Global_active_power")]

## Create the variable datetime by combining the variables Date and Time using
## `strptime`
data$Date <- paste(data$Date, data$Time)
data$Date <- strptime(data$Date, "%d/%m/%Y %H:%M:%S")
data <- data[,c(1,3)]
colnames(data)[1] <- "datetime"

## Launch PNG graphics device, create plot and send plot to file plot2.png
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data$datetime, data$Global_active_power, type = "l",
     main = NULL, xlab = "", ylab = "Global Active Power (kilowatts)",
     cex.axis = 1, cex.lab = 1, mgp = c(2.5,1,0))
dev.off()
