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

## Redefine data set as the subset consisting of the variable Global_active_power
## from Date==1/2/2007 to Date==2/2/2007
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",
             "Global_active_power"]
                    
## Launch PNG graphics device, create plot and send plot to file plot1.png                    
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data, col = "red", ylim = c(0, 1200),
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     yaxp = c(0, 1200, 6), 
     mgp = c(2.5,1,0))
dev.off()
