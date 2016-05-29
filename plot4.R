# LOADING DATA SOURCE
dataSource = "household_power_consumption.zip"

if (!file.exists(dataSource)) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
    destfile = dataSource
  )
}


if (!file.exists("household_power_consumption.txt")) {
  unzip(dataSource)
}

# PREPARE DATA
original_data <- read.csv2("household_power_consumption.txt")
subset_data <-
  original_data[original_data$Date %in% c("1/2/2007", "2/2/2007"),]
subset_data$datetime <-
  strptime(paste(subset_data$Date, subset_data$Time, sep = " "),"%d/%m/%Y %H:%M:%S")

subset_data$Global_active_power <-
  as.numeric(as.character(subset_data$Global_active_power))

subset_data$Global_reactive_power <-
  as.numeric(as.character(subset_data$Global_reactive_power))

subset_data$Sub_metering_1 <-
  as.numeric(as.character(subset_data$Sub_metering_1))

subset_data$Sub_metering_2 <-
  as.numeric(as.character(subset_data$Sub_metering_2))

subset_data$Sub_metering_3 <-
  as.numeric(as.character(subset_data$Sub_metering_3))

subset_data$Voltage <- as.numeric(as.character(subset_data$Voltage))

# SET THE INTERFACE
par(mfcol = c(2,2), cex = 0.6) # 2 rows 2 columns

# PLOTS
# Pos [0,0]
plot(
  subset_data$datetime, subset_data$Global_active_power , type = "l",xlab = "", ylab = "Global Active Power"
)

# Pos [1,0]
with(
  subset_data,
  plot(
    datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"
  )
  
)
lines(subset_data$datetime,subset_data$Sub_metering_2,  col = "red")
lines(subset_data$datetime, subset_data$Sub_metering_3, col = "blue")
legend(
  "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red", "blue"), lty = 1,
  bty = "n"
)


# Pos[0,1]
plot(
  subset_data$datetime, subset_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage"
)

# Post[1,1]
with(subset_data, plot(datetime, Global_reactive_power, type = "l"))


dev.copy(device = png, "plot4.png", width = 480, height = 480)
dev.off()